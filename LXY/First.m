
//
//  First.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "First.h"
#import "UIImage+AddImage.h"
#import "BarView.h"
#import "PopViewController.h"
#import "SecondViewController.h"
#import "Constant.h"
#import "DPAPI.h"
#import "DownData.h"
#import "CollectionViewCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"


@interface First ()<DPRequestDelegate> //实现大众点评的delegate
@property(nonatomic,assign)NSInteger pageNumber;
@end

@implementation First
{
    UIBarButtonItem* firstItem;
    UIBarButtonItem* secondItem;
    UIBarButtonItem* thirdItem;
    UIPopoverController* popVC;
    
    
    
    NSString* _categoryName;
    NSString* _subCategoryName;
    NSString* _cityName;
    NSString* _regionName;
    
    NSArray* _totalArray;
}

static NSString * const reuseIdentifier = @"CollectionViewCell";

-(instancetype)init
{
    UICollectionViewFlowLayout* layout=[[UICollectionViewFlowLayout alloc] init];//UICollectionView的layout得是UICollection
    
    //设置UICollectionViewFlowLayout
    layout.itemSize=CGSizeMake(300, 300);
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    #warning collectionView is init and background color is black
    self.collectionView.backgroundColor=[UIColor whiteColor];
    //拒绝调整
    self.navigationController.navigationBar.autoresizingMask=UIViewAutoresizingNone;
    
    [self setLayOutWhenLaunched];

    //设置标题bar
    [self createNavBar];
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChanged:) name:City_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryChanged:) name:Category_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subCategoryChanged:) name:SubCategory_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regionChanged:) name:Region_Change_Notifaction object:nil];
    
    //指定collectionviewcell的样式，可以为nib，也可以为cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
     //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //下拉刷新
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self createRequest];
        [self.collectionView.header endRefreshing];
    }];
    
    //上拉加载
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        [self.collectionView.footer endRefreshing];
    }];

    
}


-(void)createNavBar
{
    //logo
    UIImage* image=[UIImage imageWithText:[NSString stringWithFormat:@"lxy团购"] scale:1.5 size:CGSizeMake(128, 62)];
#warning UIBarButtonItem is changed with the size of image
    UIBarButtonItem * imageItem=[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:nil action:nil];
    
    //后面的三个一样的BarButtonItem
    
    BarView * barView1=[BarView createItem];
    [barView1 addTarget:self action:@selector(firstCreatePopoverViewController)];
    
    [[NSNotificationCenter defaultCenter] addObserver:barView1 selector:@selector(changeSubCategoryName:) name:SubCategory_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:barView1 selector:@selector(changeCategoryName:) name:Category_Change_Notifaction object:nil];

    
    BarView * barView2=[BarView createItem];
    [barView2 addTarget:self action:@selector(secondCreatePopoverViewController)];

    [[NSNotificationCenter defaultCenter] addObserver:barView2 selector:@selector(changeCityName:) name:City_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:barView2 selector:@selector(changeRegionName:) name:Region_Change_Notifaction object:nil];
    
    
    firstItem=[[UIBarButtonItem alloc] initWithCustomView:barView1];
    secondItem=[[UIBarButtonItem alloc] initWithCustomView:barView2];
    
    self.navigationItem.leftBarButtonItems=@[imageItem,firstItem,secondItem];
}



-(void)firstCreatePopoverViewController
{
    [self createPopoverVCWithBarButtonItem:firstItem];
}

-(void)secondCreatePopoverViewController
{
    [self createPopoverVCWithBarButtonItem:secondItem];
}

-(void)thirdCreatePopoverViewController
{
    [self createPopoverVCWithBarButtonItem:thirdItem];
}



-(void)createPopoverVCWithBarButtonItem:(UIBarButtonItem *)barButton
{
    if (popVC) {
        [popVC dismissPopoverAnimated:YES];
         popVC=nil;
    }
    UIViewController* popContent;
    if(barButton==firstItem)
    {
        popContent=[[PopViewController alloc] init];

    }else
    {
        popContent=[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    }
        
    popVC=[[UIPopoverController alloc] initWithContentViewController:popContent];
    [popVC presentPopoverFromBarButtonItem:barButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}





#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _totalArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell showUI:_totalArray[indexPath.row]];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // DetailViewController* detail=[[DetailViewController alloc] init];
    DetailViewController* detail=[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detail.md=_totalArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 调整layout边距


-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    int number;
    if(size.width<size.height) {
        number=2;
    }else
    {
        number=3;
    }
    [self setLayOutToDisplayView:number withSize:size];
}

-(void)setLayOutToDisplayView:(int) number withSize:(CGSize)size
{
    int insetNumber=20;
    UICollectionViewFlowLayout* layout=(UICollectionViewFlowLayout*)self.collectionViewLayout;
  //  CGFloat insetNumber=(size.width-number*layout.itemSize.width)/(number*2);
    layout.itemSize=CGSizeMake((size.width-insetNumber*number*2)/number, 300);
    layout.sectionInset=UIEdgeInsetsMake(20,20,20,20);
    
}

-(void)setLayOutWhenLaunched
{
    int number;
    if ([[UIScreen mainScreen] applicationFrame].size.width>[[UIScreen mainScreen] applicationFrame].size.height) {
        number=3;
    }else
    {
        number=2;
    }
    [self setLayOutToDisplayView:number withSize:[[UIScreen mainScreen] applicationFrame].size];
}

#pragma mark  通知＋网络请求
-(void)loadMoreData
{
    self.pageNumber++;
    [self createFinalRequest];
}

-(void)cityChanged:(NSNotification*)noti
{
    _cityName=noti.userInfo[city_name];
}
-(void)regionChanged:(NSNotification*)noti
{
    _regionName=noti.userInfo[region_name];
    if ([_regionName isEqualToString:@"全部"]) {
        _regionName=nil;
    }
    [popVC dismissPopoverAnimated:NO];
    [self createRequest];

}

-(void)categoryChanged:(NSNotification*)noti
{
    _categoryName=noti.userInfo[category_name];
    [popVC dismissPopoverAnimated:YES];
    if ([_categoryName isEqualToString:@"全部分类"]) {
        _categoryName=nil;
    }
    [self createRequest];
}

-(void)subCategoryChanged:(NSNotification*)noti
{
    [popVC dismissPopoverAnimated:YES];
    NSString* caN=noti.userInfo[category_name];
    NSString* subN=noti.userInfo[subCategory_name];
    if ([subN isEqualToString:@"全部"]) {
        _categoryName=caN;
    }else
    {
        if ([subN containsString:@"/"]) {
            NSRange range=[subN rangeOfString:@"/"];
            _categoryName=[subN substringFromIndex:(range.location+range.length)];//当出现了／符号时，应该选其后面那个。
        }else{
            _categoryName=subN;
        }
        
    }
    [self createRequest];
}

-(void)createRequest
{
    self.pageNumber=1;
    [self createFinalRequest];
}

-(void)createFinalRequest
{
    if (!_cityName) {
        _cityName=@"北京";
    }
    DPAPI* api=[[DPAPI alloc] init];
    NSMutableDictionary * params1=[[NSMutableDictionary alloc] init];
    [params1 setObject:@(self.pageNumber) forKey:@"page"];
    [params1 setValue:@20 forKey:@"limit"];
    
    [params1 setValue:_categoryName forKey:@"category"];
    [params1 setValue:_regionName forKey:@"region"];
    [params1 setValue:_cityName forKey:@"city"];
    
    [api requestWithURL:@"v1/deal/find_deals" params:params1 delegate:self];
}

#pragma mark -DPRequstDelegate

-(void)request:(DPRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    
}

//数据处理好以后
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
#warning  注意NSNull ,nil (block), 0(option)
    
    _totalArray=[DownData arryWithJsonData:result];
    [self.collectionView reloadData];
    
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error description]);

}


#pragma mark <UICollectionViewDelegate>

//添加监听后，需要dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:City_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Region_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Category_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SubCategory_Change_Notifaction object:nil];
    
   
    [[NSNotificationCenter defaultCenter] removeObserver:firstItem.customView name:Region_Change_Notifaction object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:secondItem.customView name:SubCategory_Change_Notifaction object:nil];
}
@end
