//
//  ArticlesViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/11/7.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "ArticlesViewController.h"
#include "ArticleCell.h"
#include <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface ArticlesViewController ()

@end

@implementation ArticlesViewController

NSArray *articles;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *bookid;
    if ([_blogSetId isKindOfClass:[NSString class]]) {
        bookid = (NSString *)_blogSetId;
    } else {
       bookid = [_blogSetId stringValue];
    }
    
    NSString *url = @"https://open.timepill.net/api/notebooks/";
    url = [[url stringByAppendingString:bookid] stringByAppendingString:@"/diaries"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass: [NSArray class]]) {
            articles = (NSArray *) responseObject;
            NSLog(@"articles: %@", articles);
            [self.tableView reloadData];
            self.tableView.estimatedRowHeight = 72.0 ;
            self.tableView.rowHeight = UITableViewAutomaticDimension;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *photoUrl = [articles[indexPath.row] objectForKey:@"photoUrl"];
    CGFloat height = [[self.heightCache objectForKey:photoUrl] floatValue];
    if (height > 18) {
        height += 82;
    } else {
        height = 200;
    }
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [articles count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"ArticleCell";
    ArticleCell * cell = (ArticleCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = (ArticleCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.updatetime.text = [articles[indexPath.row] objectForKey:@"updated"];
    cell.content.text = [articles[indexPath.row] objectForKey:@"content"];
    NSString *url = [articles[indexPath.row] objectForKey:@"photoUrl"];
    if (url && (NSNull *)url != [NSNull null]) {
        [cell.image sd_setImageWithURL:[NSURL URLWithString:url]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             }];
    }
    return cell;
}


@end
