//
//  BaseController.m
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)post:(NSString*) tag uri:(NSString*) uri params:(id)firstObject, ... {
    
    va_list arguments;
    
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    id param;
    id object = firstObject;
    NSString *key;
    BOOL isFrist = true;
    if(object != nil) {
        va_start(arguments, firstObject);
        
        while((param = va_arg(arguments, id))) {
            if(param == nil)
                break;
            if(isFrist) {
                key = param;
                isFrist = false;
            } else {
                object = param;
                key = va_arg(arguments, id);
                if(key == nil) {
                    break;
                }
            }
            [md setObject:object forKey:key];
        }
        va_end(arguments);
    }
    
    if(self.hud == nil) {
        self.hud = [[MBProgressHUD alloc]init];
        self.hud.labelText = @"正在执行";
        [self.view addSubview:self.hud];
    }
    [self.hud show:YES];
    [[BaseRequest shared]execute:uri params:md callback:^(Response *response) {
        [self.hud hide:YES];
        [self onRequestFinished:tag response:response];
    }];
 
}



-(void)load:(NSString*) tag uri:(NSString*) uri params:(id)firstObject, ... {
    
    va_list arguments;
    
    NSMutableDictionary *md = [[NSMutableDictionary alloc]init];
    id param;
    id object = firstObject;
    NSString *key;
    BOOL isFrist = true;
    if(object != nil) {
        va_start(arguments, firstObject);
        
        while((param = va_arg(arguments, id))) {
            if(param == nil)
                break;
            if(isFrist) {
                key = param;
                isFrist = false;
            } else {
                object = param;
                key = va_arg(arguments, id);
                if(key == nil) {
                    break;
                }
            }
            [md setObject:object forKey:key];
        }
        va_end(arguments);
    }
    
    self.loadingLabel.hidden = NO;
    [[BaseRequest shared]execute:uri params:md callback:^(Response *response) {
        self.loadingLabel.hidden = YES;
        [self onRequestFinished:tag response:response];
    }];
    
}

@end
