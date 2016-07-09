//
//  BFDMarsURLConnection.m
//  mars
//
//  Created by linde on 16/6/14.
//  Copyright © 2016年 linde. All rights reserved.
//

#import "BFDMarsURLConnection.h"

@implementation BFDMarsURLConnection



+(void)BFDURL_POSTRequestWithUrl:(NSString *)urlStr  Params:(NSData *)params
                    successBlock:(void(^)(NSString *json))successBlock
                     failedBlock:(void(^)(NSError *error))failedBlock{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = params;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) { // 请求成功
            successBlock([[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
        } else { // 请求失败
            
        }
        
    }];
    [task resume];
    
}
+(void)BFDURL_GETRequestWithUrl:(NSString *)urlStr  Params:(NSString *)params
                   successBlock:(void(^)(NSDictionary *json))successBlock
                    failedBlock:(void(^)(NSError *error))failedBlock{
    
    NSURL *url =[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (data) { // 请求成功
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (dict.count&&successBlock) {
                successBlock(dict);
            }
        } else { // 请求失败
            if (failedBlock) {
                failedBlock(connectionError);
            }
        }
    }];}

@end
