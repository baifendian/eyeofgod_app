//
//  BFDMarsURLConnection.h
//  mars
//
//  Created by linde on 16/6/14.
//  Copyright © 2016年 linde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDMarsURLConnection : NSURLConnection<NSURLConnectionDelegate>
+(void)BFDURL_POSTRequestWithUrl:(NSString *)urlStr  Params:(NSData *)params
                    successBlock:(void(^)(NSString *json))successBlock
                     failedBlock:(void(^)(NSError *error))failedBlock;

+(void)BFDURL_GETRequestWithUrl:(NSString *)urlStr  Params:(NSString *)params
                   successBlock:(void(^)(NSDictionary *json))successBlock
                    failedBlock:(void(^)(NSError *error))failedBlock;
@end
