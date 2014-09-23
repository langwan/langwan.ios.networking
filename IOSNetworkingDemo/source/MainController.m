//
//  MainController.m
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import "MainController.h"

@interface MainController ()

@end

@implementation MainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    NSString * articleId = @"10";
    [self load:@"view" uri:API_ARTICLE_VIEW params:articleId, @"id", nil];
    [super viewDidLoad];
}
- (IBAction)onSave:(id)sender {
    [self post:@"save" uri:API_ARTICLE_CREATE params:nil];
}

-(void)onRequestFinished:(NSString *)tag response:(Response *)response {
    if([tag isEqualToString:@"view"]) {
        [self onView:response];
    } else if ([tag isEqualToString:@"save"]) {
        [self onSaveFinished:response];
    }
}

-(void)onView:(Response *)response {
    if(response.error == nil)
    self.titleLabel.text = [response.body objectForKey:@"title"];
}

-(void)onSaveFinished:(Response*)response {
    if(response.error == nil)
        NSLog(@"完成提交");
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

@end
