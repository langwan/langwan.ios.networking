//
//  Response.h
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Response : NSObject
@property(strong, nonatomic) AFHTTPRequestOperationManager* afom;
@property(strong, nonatomic) NSString* tag;
@property(strong, nonatomic) NSDictionary *header;
@property(strong, nonatomic) NSNumber *status;
@property(strong, nonatomic) NSString *messsage;
@property(strong, nonatomic) NSDictionary *body;
@property(strong, nonatomic) NSString *text;
@property(strong, nonatomic) NSError *error;
@end
