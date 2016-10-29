//
//  FreshBlogViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/10/29.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "FreshBlogViewController.h"
#import "BlogCell.h"
#import <AFNetworking/AFNetworking.h>
@interface FreshBlogViewController ()

@end

@implementation FreshBlogViewController
NSArray * freshNames;
NSArray * freshDates;
NSArray * freshAvatars;
NSArray * freshContents;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    freshNames = [NSArray arrayWithObjects:@"one",@"two",nil];
    freshDates = [NSArray arrayWithObjects:@"2016-10-30", @"2016-10-31",nil];
    freshContents = [NSArray arrayWithObjects:@"第一篇文章内容", @"第二篇文章内容",nil];
    NSString *url = @"https://open.timepill.net/api/diaries/today";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @1;
    params[@"page_size"] = @10;
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Response: %@", responseObject);  } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [freshNames count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIndentifier = @"BlogCell";
    BlogCell *cell = (BlogCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIndentifier];
    if (cell == nil) {
        cell = (BlogCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIndentifier];
    }
    cell.author.text = [freshNames objectAtIndex:indexPath.row];
    cell.createtime.text = [freshDates objectAtIndex:indexPath.row];
    return cell;
}


@end
