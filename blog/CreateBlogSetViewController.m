//
//  CreateBlogSetViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/11/9.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "CreateBlogSetViewController.h"
#import <AFNetworking/AFNetworking.h>
@interface CreateBlogSetViewController ()

@end

@implementation CreateBlogSetViewController
NSMutableArray *privacys;
- (void)viewDidLoad {
    [super viewDidLoad];
    privacys = [[NSMutableArray alloc]init];
    [privacys addObject:@{@"privacy": @10,@"desc": @"大家"}];
    [privacys addObject:@{@"privacy": @1,@"desc": @"私密"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initBlogSetData:(NSString*)notebookid{
    NSString *url = @"https://open.timepill.net/api/notebooks/";
    url = [url stringByAppendingString:notebookid];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return privacys.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [privacys[row] objectForKey:@"desc"];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSNumber *blogSetId = (NSNumber *)[privacys[row] valueForKey:@"privacy"];
    _hiddenPrivacy.text= [blogSetId stringValue];
}


//创建或者保存日记本信息
- (IBAction)saveBlogSet:(id)sender {
    NSString *url = @"https://open.timepill.net/api/notebooks";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    param[@"subject"] = _subject.text;
    param[@"description"] = _desc.text;
    param[@"expired"] = _expire.text;
    param[@"privacy"] = (NSNumber*)_hiddenPrivacy.text;
    [manager POST:url parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self performSegueWithIdentifier:@"backBlogSet" sender:self];
        }
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


@end
