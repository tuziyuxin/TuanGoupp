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

@interface First ()

@end

@implementation First
{
    UIBarButtonItem* firstItem;
    UIBarButtonItem* secondItem;
    UIBarButtonItem* thirdItem;
    UIPopoverController* popVC;
}

static NSString * const reuseIdentifier = @"Cell";
-(instancetype)init
{
    UICollectionViewLayout* layout=[[UICollectionViewLayout alloc] init];
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
#warning collectionView is init and background color is black
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    [self createNavBar];
    
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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
    BarView * barView2=[BarView createItem];
    [barView2 addTarget:self action:@selector(secondCreatePopoverViewController)];
    BarView * barView3=[BarView createItem];
    [barView3 addTarget:self action:@selector(thirdCreatePopoverViewController)];
    
    firstItem=[[UIBarButtonItem alloc] initWithCustomView:barView1];
    secondItem=[[UIBarButtonItem alloc] initWithCustomView:barView2];
    thirdItem=[[UIBarButtonItem alloc] initWithCustomView:barView3];
    
    self.navigationItem.leftBarButtonItems=@[imageItem,firstItem,secondItem,thirdItem];
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
    PopViewController* popContent=[[PopViewController alloc] init];
    
    UIPopoverController* popVC=[[UIPopoverController alloc] initWithContentViewController:popContent];
    [popVC presentPopoverFromBarButtonItem:barButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //[popVC presentPopoverFromBarButtonItem:firstItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
