//
//  BaseController.h
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseController : UIViewController
-(void)post:(NSString*) tag uri:(NSString*) uri params:(id)firstObject, ...;
-(void)load:(NSString*) tag uri:(NSString*) uri params:(id)firstObject, ...;
-(void)onRequestFinished:(NSString*)tag response:(Response *)response;
-(NSDictionary*)argsToMap:(va_list)args;
@property(strong, nonatomic) UILabel *loadingLabel;
@property(strong, nonatomic) MBProgressHUD * hud;
@end
