//
//  ViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/10/29.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#include "FreshBlogViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    NSString *username = _uname.text;
    NSString *password = _upwd.text;
    NSString *url = @"https://open.timepill.net/api/users/my";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            delegate.uinfo = (NSDictionary*)responseObject;
                [self performSegueWithIdentifier:@"login" sender:self];
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (IBAction)register:(id)sender {
}

@end
