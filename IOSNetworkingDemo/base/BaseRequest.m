//
//  LBaseRequest.m
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"

@implementation BaseRequest

static BaseRequest* _instance;
static dispatch_once_t onceToken;

+(BaseRequest*)shared {
    dispatch_once(&onceToken, ^{
        if(_instance == nil) {
            _instance = [[BaseRequest alloc]init];
        }
    });
    return _instance;
}

-(BOOL)beforeExecute:(Response*)response {
    NSOperationQueue *operationQueue = response.afom.operationQueue;
    [response.afom.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [response.afom.reachabilityManager startMonitoring];
    return true;
}
-(void)execute:(NSString*)uri params:(NSDictionary*)params callback:(void (^)(Response* response))callback {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
    Response* response = [[Response alloc]init];
    response.afom = manager;
    if (![self beforeExecute:response]) {
        return;
    };
    [manager POST:uri parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        response.text = operation.responseString;
        response.header = [responseObject objectForKey:@"header"];
        response.status = [responseObject objectForKey:@"status"];
        response.body = [responseObject objectForKey:@"body"];
        response.messsage = [responseObject objectForKey:@"message"];
        response.error = nil;
        if(callback != nil)
            callback(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        response.text = operation.responseString;
        response.header = nil;
        response.body = nil;
        response.messsage = nil;
        response.error = error;
        response.status = [[NSNumber alloc]initWithInt:-1];
        [self afterExecute:response];
        callback(response);
    }];
}

-(BOOL)afterExecute:(Response*)response {
    if (response.error == nil) {
        return TRUE;
    }
    if ([response.error code] == NSURLErrorNotConnectedToInternet) {
        [self alertErrorMessage:@"网络不给力"];
        return FALSE;
    }
    [self alertErrorMessage:@"服务器故障，请稍后再试。"];
    return true;
}

-(void)alertErrorMessage:(NSString *)message
{
    [[[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil]show];
}


@end
