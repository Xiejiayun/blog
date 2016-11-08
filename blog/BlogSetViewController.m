//
//  BlogSetViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/11/7.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "BlogSetViewController.h"
#import "BlogSet.h"
#include "ArticlesViewController.h"
#import <AFNetworking/AFNetworking.h>
@interface BlogSetViewController ()


@end

@implementation BlogSetViewController

NSArray * blogSet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *url = @"https://open.timepill.net/api/notebooks/my";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass: [NSArray class]]) {
            blogSet = (NSArray *) responseObject;
            [self.tableView reloadData];
            NSLog(@"blogs: %@", blogSet);
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [blogSet count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"BlogSet";
    BlogSet * cell = (BlogSet*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = (BlogSet*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.name.text = [blogSet[indexPath.row] objectForKey:@"subject"];
    cell.time.text = [blogSet[indexPath.row] objectForKey:@"expired"];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
    [self performSegueWithIdentifier:@"blogSetDetail" sender:indexPath];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"blogSetDetail"]) {
        NSIndexPath *indexPath = (NSIndexPath*)sender;
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
            ArticlesViewController *articleController = [navController topViewController];
            articleController.blogSetId = (NSNumber*)[[blogSet objectAtIndex:indexPath.row] objectForKey:@"id"];
        }
        NSLog(@"the index is %ld",(long)indexPath.row);
    }
}

//查看某个笔记本的详情信息
- (IBAction)blogSetDetail:(id)sender {
    
}

@end
