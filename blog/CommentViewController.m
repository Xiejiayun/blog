//
//  CommentViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/11/1.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize blog;
@synthesize notebook;
@synthesize content;
@synthesize commentView;
@synthesize commentContent;
@synthesize commentBtn;
@synthesize pic;
@synthesize avatar;


- (void)viewDidLoad {
    [super viewDidLoad];
    notebook.text = [blog objectForKey:@"notebook_subject"];
    content.text = [blog objectForKey:@"content"];
    NSString *blogurl = [blog objectForKey:@"photoUrl"];
    NSString *avatarUrl = [[blog objectForKey:@"user" ]objectForKey:@"iconUrl"];
    if (avatarUrl && (NSNull *)avatarUrl != [NSNull null]) {
        [avatar sd_setImageWithURL:[NSURL URLWithString:avatarUrl]
                  placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                         }];
    }
    
    if (blogurl && (NSNull *)blogurl != [NSNull null]) {
        [pic sd_setImageWithURL:[NSURL URLWithString:blogurl]
               placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                      }];
    }
    
    NSString *blogid = [[blog objectForKey:@"id"] stringValue];
    NSString *url = @"https://open.timepill.net/api/diaries/";
    url = [url stringByAppendingString:blogid];
    url = [url stringByAppendingString:@"/comments"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass: [NSArray class]]) {
            _comments = [[NSMutableArray alloc] initWithArray:responseObject];
            [self.commentView reloadData];
            NSLog(@"comments: %@", _comments);
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

//添加评论
- (IBAction)comment:(id)sender {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSMutableDictionary *uinfo = (NSMutableDictionary *)delegate.uinfo;
    NSString *comment = commentContent.text;
    NSString *blogid = [[blog objectForKey:@"id"] stringValue];
    NSString *url = @"https://open.timepill.net/api/diaries/";
    url = [url stringByAppendingString:blogid];
    url = [url stringByAppendingString:@"/comments"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"content"] = comment;
    params[@"recipient_id"] = [uinfo objectForKey:@"id"];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self.commentView beginUpdates];
            NSDictionary *comment = (NSDictionary*)responseObject;
            [_comments addObject:comment];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[_comments count]-1 inSection:0]];
            [[self commentView] insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
            [self.commentView endUpdates];
            
            NSLog(@"responseObject: %@", responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_comments count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CommentCell";
    CommentCell * cell = (CommentCell*)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = (CommentCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.name.text = [[_comments[indexPath.row] objectForKey:@"user"]objectForKey:@"name"];
    cell.time.text = [_comments[indexPath.row] objectForKey:@"created"];
    cell.comment.text = [_comments[indexPath.row] objectForKey:@"content"];
    NSString *url = [[_comments[indexPath.row] objectForKey:@"user" ]objectForKey:@"iconUrl"];
    if (url && (NSNull *)url != [NSNull null]) {
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:url]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                              }];
    }
    return cell;
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *uinfo = (NSMutableDictionary *)delegate.uinfo;
    NSDictionary *commentInfo = [_comments objectAtIndex:indexPath.row];
    if ([uinfo objectForKey:@"id"] == [[commentInfo objectForKey:@"user"]objectForKey:@"id"]) {
        NSString *commentid = [[commentInfo objectForKey:@"id"] stringValue];
        NSString *url = @"https://open.timepill.net/api/comments/";
        url = [url stringByAppendingString:commentid];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString *username = @"furnace09@163.com";
        NSString *password = @"xiexie123";
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
        [manager DELETE:url parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [_comments removeObjectAtIndex:indexPath.row];
                [commentView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

- (void)setComments:(NSMutableArray *)comments {
    
    NSMutableArray * tmp = [comments mutableCopy];
    _comments = tmp;
}


@end
