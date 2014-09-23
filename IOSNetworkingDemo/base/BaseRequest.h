//
//  LBaseRequest.h
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject
@property(strong, nonatomic)NSString* baseUrl;
+(BaseRequest*)shared;
-(BOOL)beforeExecute:(Response*)response;
-(void)execute:(NSString*)uri params:(NSDictionary*)params callback:(void (^)(Response* response))callback;
-(BOOL)afterExecute:(Response*)response;
-(void)alertErrorMessage:(NSString *)message;
@end
