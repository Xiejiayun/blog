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
NSMutableArray * blogs;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        if ([responseObject isKindOfClass: [NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary *) responseObject;
            blogs = [jsonDict objectForKey:@"diaries"];
            NSLog(@"blogs: %@", blogs);
        }
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [blogs count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"BlogCell";
    BlogCell *cell = (BlogCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = (BlogCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    NSDictionary *blog = [blogs objectAtIndex:indexPath.row];
    NSLog(@"blog: %@", blog);
    cell.author.text = [[blog objectForKey:@"user"]objectForKey:@"name"];
    cell.createtime.text = [blog objectForKey:@"created"];
    cell.brief.text = [blog objectForKey:@"content"];
    return cell;
}


@end
