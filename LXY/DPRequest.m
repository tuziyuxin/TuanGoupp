//
//  DPRequest.m
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//
//基本上没有用SBJson

#import "DPRequest.h"
#import "DPConstants.h"
#import "DPAPI.h"

#import <CommonCrypto/CommonDigest.h>


#define kDPRequestTimeOutInterval   180.0
#define kDPRequestStringBoundary    @"9536429F8AAB441bA4055A74B72B57DE"



@interface DPAPI ()
- (void)requestDidFinish:(DPRequest *)request;
@end





@interface DPRequest () <NSURLConnectionDelegate>

@end

@implementation DPRequest {
    
    NSURLConnection                 *_connection;
    NSMutableData                   *_responseData;
    
}

#pragma mark - Private Methods

- (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString {
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
		
		if ([elements count] <= 1) {
			return nil;
		}
		
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

- (NSMutableData *)postBodyHasRawData:(BOOL*)hasRawData
{
//    NSString *bodyPrefixString = [NSString stringWithFormat:@"--%@\r\n", kDPRequestStringBoundary];
//    NSString *bodySuffixString = [NSString stringWithFormat:@"\r\n--%@--\r\n", kDPRequestStringBoundary];
//    
//    NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionary];
//    
//    NSMutableData *body = [NSMutableData data];
//    [self appendUTF8Body:body dataString:bodyPrefixString];
//    
//    for (id key in [params keyEnumerator])
//    {
//        if (([[params valueForKey:key] isKindOfClass:[UIImage class]]) || ([[params valueForKey:key] isKindOfClass:[NSData class]]))
//        {
//            [dataDictionary setObject:[params valueForKey:key] forKey:key];
//            continue;
//        }
//        
//        [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", key, [params valueForKey:key]]];
//        [self appendUTF8Body:body dataString:bodyPrefixString];
//    }
//    
//    if ([dataDictionary count] > 0)
//    {
//        *hasRawData = YES;
//        for (id key in dataDictionary)
//        {
//            NSObject *dataParam = [dataDictionary valueForKey:key];
//            
//            if ([dataParam isKindOfClass:[UIImage class]])
//            {
//                NSData* imageData = UIImagePNGRepresentation((UIImage *)dataParam);
//                [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"file\"\r\n", key]];
//                [self appendUTF8Body:body dataString:[NSString stringWithString:@"Content-Type: image/png\r\nContent-Transfer-Encoding: binary\r\n\r\n"]];
//                [body appendData:imageData];
//            }
//            else if ([dataParam isKindOfClass:[NSData class]])
//            {
//                [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"file\"\r\n", key]];
//                [self appendUTF8Body:body dataString:[NSString stringWithString:@"Content-Type: content/unknown\r\nContent-Transfer-Encoding: binary\r\n\r\n"]];
//                [body appendData:(NSData*)dataParam];
//            }
//            [self appendUTF8Body:body dataString:bodySuffixString];
//        }
//    }
//    
//    return body;
	return nil;
}

- (void)handleResponseData:(NSData *)data
{
    if ([_delegate respondsToSelector:@selector(request:didReceiveRawData:)])
    {
        [_delegate request:self didReceiveRawData:data];
    }
    
    NSError* error=nil;
    id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
	//SBJsonParser *parser = [[SBJsonParser alloc] init];
  //  id result = [parser objectWithData:data];
	NSLog(@"return: \n%@", result);
    if (!result) {
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
								  error, @"error",nil ];
		NSError *error = [NSError errorWithDomain:kDPAPIErrorDomain
											 code:-1
										 userInfo:userInfo];
		[self failedWithError:error];
	} else {
		NSString *status = 0;
        if([result isKindOfClass:[NSDictionary class]])
        {
            status = [result objectForKey:@"status"];
        }
		
		if ([status isEqualToString:@"OK"]) {
			if ([_delegate respondsToSelector:@selector(request:didFinishLoadingWithResult:)])
			{
				[_delegate request:self didFinishLoadingWithResult:(result == nil ? data : result)];
			}
		} else {
			if ([status isEqualToString:@"ERROR"]) {
				// TODO: 处理错误代码
			}
		}
	}
}

- (id)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo
{
    return [NSError errorWithDomain:kDPAPIDomain code:code userInfo:userInfo];
}

- (void)failedWithError:(NSError *)error
{
	if ([_delegate respondsToSelector:@selector(request:didFailWithError:)])
	{
		[_delegate request:self didFailWithError:error];
	}
}

#pragma mark - Public Methods

+ (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName
{
    if (![paramName hasSuffix:@"="])
    {
        paramName = [NSString stringWithFormat:@"%@=", paramName];
    }
    
    NSString * str = nil;
    NSRange start = [url rangeOfString:paramName];
    if (start.location != NSNotFound)
    {
        // confirm that the parameter is not a partial name match
        unichar c = '?';
        if (start.location != 0)
        {
            c = [url characterAtIndex:start.location - 1];
        }
        if (c == '?' || c == '&' || c == '#')
        {
            NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
            NSUInteger offset = start.location+start.length;
            str = end.location == NSNotFound ?
            [url substringFromIndex:offset] :
            [url substringWithRange:NSMakeRange(offset, end.location)];
            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    return str;
}

//sign的生成：以appkey为首，中间为key1value1key2value2,最后为app secret
//将整个字符串进行sha-1计算，并转换为16进制。
//转换为大写

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params
{
//请求的字符串为utf8编码，并且中间加上％字符
	NSURL* parsedURL = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[self parseQueryString:[parsedURL query]]];
//把所有的key和value变为utf8 形式，中间不再有％。保存到数组里
	if (params) {
		[paramsDic setValuesForKeysWithDictionary:params];
	}
	
	NSMutableString *signString = [NSMutableString stringWithString:kDPAppKey];
	NSMutableString *paramsString = [NSMutableString stringWithFormat:@"appkey=%@",kDPAppKey];
//key的排序
	NSArray *sortedKeys = [[paramsDic allKeys] sortedArrayUsingSelector: @selector(compare:)];
	for (NSString *key in sortedKeys) {
		[signString appendFormat:@"%@%@", key, [paramsDic objectForKey:key]];
		[paramsString appendFormat:@"&%@=%@", key, [paramsDic objectForKey:key]];
	}
	[signString appendString:kDPAppSecret];
//进行sha－1的计算
	unsigned char digest[CC_SHA1_DIGEST_LENGTH];
	NSData *stringBytes = [signString dataUsingEncoding: NSUTF8StringEncoding];
	if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
		/* SHA-1 hash has been calculated and stored in 'digest'. */
		NSMutableString *digestString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
		for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
			unsigned char aChar = digest[i];
//把里面的每个字节都变成16进制
			[digestString appendFormat:@"%02X", aChar];
		}
		[paramsString appendFormat:@"&sign=%@", [digestString uppercaseString]];
//返回总的:https: api.dianping.com/v1/deal/find_deals?appkey=975791789&category=%E8%A5%BF%E5%8C%97%E8%8F%9C&city=%E5%8C%97%E4%BA%AC&sign=B70EFE1CC08981467A8AA6118A3C5AF4B0D8CDAB
		return [NSString stringWithFormat:@"%@://%@%@?%@", [parsedURL scheme], [parsedURL host], [parsedURL path], [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	} else {
		return nil;
	}
}

+ (DPRequest *)requestWithURL:(NSString *)url
                              params:(NSDictionary *)params
                            delegate:(id<DPRequestDelegate>)delegate
{
    DPRequest *request = [[DPRequest alloc] init];
    
    request.url = url;
    request.params = params;
    request.delegate = delegate;
    
    return request;
}

//开始进入到连接状态
- (void)connect
{
//urlString是将每一个参数进行了utf8编码，并且有sign。
    NSString* urlString = [[self class] serializeURL:_url params:_params];
//设置request，其中包括NSURLRequest的缓存类型
    NSMutableURLRequest* request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                        timeoutInterval:kDPRequestTimeOutInterval];
//将request的http设置为get。
    [request setHTTPMethod:@"GET"];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)disconnect
{
	_responseData = nil;
    
    [_connection cancel];
    _connection = nil;
}


#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	_responseData = [[NSMutableData alloc] init];
	
	if ([_delegate respondsToSelector:@selector(request:didReceiveResponse:)])
    {
		[_delegate request:self didReceiveResponse:response];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
	[self handleResponseData:_responseData];
    
	_responseData = nil;
    
    [_connection cancel];
	_connection = nil;
    
    [_dpapi requestDidFinish:self];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	[self failedWithError:error];
	
	_responseData = nil;
    
    [_connection cancel];
	_connection = nil;
    
    [_dpapi requestDidFinish:self];
}

#pragma mark - Life Circle
- (void)dealloc
{
    [_connection cancel];
	_connection = nil;
}

@end



