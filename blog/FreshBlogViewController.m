//
//  FreshBlogViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/10/29.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "FreshBlogViewController.h"
#import "BlogCell.h"
#import "UserInfoViewController.h"
#import "CommentViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface FreshBlogViewController ()

@end

@implementation FreshBlogViewController

int page = 1;

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
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass: [NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary *) responseObject;
            blogs = [jsonDict objectForKey:@"diaries"];
            [self.tableView reloadData];
            NSLog(@"blogs: %@", blogs);
        }
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    page++;
    NSString *url = @"https://open.timepill.net/api/diaries/today";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @1;
    params[@"page_size"] = @10;
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass: [NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary *) responseObject;
            blogs = [jsonDict objectForKey:@"diaries"];
            [self.tableView reloadData];
            NSLog(@"blogs: %@", blogs);
        }
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [refreshControl endRefreshing];
}


- (IBAction)swipeLeft:(id)sender {
    page++;
    [self refreshBlog:[NSNumber numberWithInt:page]];
}

/**
 刷新博客
 */
-(void)refreshBlog:(NSNumber *)page {
    NSString *url = @"https://open.timepill.net/api/diaries/today";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = page;
    params[@"page_size"] = @10;
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass: [NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary *) responseObject;
            blogs = [jsonDict objectForKey:@"diaries"];
            [self.tableView reloadData];
            NSLog(@"blogs: %@", blogs);
        }
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)swipePage:(UISwipeGestureRecognizer *)sender {
    page--;
    if (page <= 0)
        page = 1;
    [self refreshBlog:[NSNumber numberWithInt:page]];
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
    
    cell.author.text = [[blog objectForKey:@"user"]objectForKey:@"name"];
    cell.createtime.text = [blog objectForKey:@"created"];
    cell.brief.text = [blog objectForKey:@"content"];
    cell.book.text =[blog objectForKey:@"notebook_subject"];
    NSString *commentCount = [blog objectForKey:@"comment_count"];
    
    NSString * comment = [NSString stringWithFormat:@"%@,%@", @"回复", commentCount];
    [cell.reply setTitle:comment forState:UIControlStateNormal];
    NSString *url = [[blog objectForKey:@"user"]objectForKey:@"iconUrl"];
    NSLog(@"the icon url is %@", url);
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString:url]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                          }];
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    UITapGestureRecognizer *tapBook = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBook:)];
    [tapBook setNumberOfTouchesRequired:1];
    [tapBook setNumberOfTapsRequired:1];
    [cell.createtime addGestureRecognizer:tapBook];
    UITapGestureRecognizer *tapAvatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBook:)];
    [tapAvatar setNumberOfTouchesRequired:1];
    [tapAvatar setNumberOfTapsRequired:1];
    [cell.avatar addGestureRecognizer:tapAvatar];
    return cell;
}

- (void)tapBook:(UITapGestureRecognizer *)sender{
    NSLog(@"点击了笔记本");
}

- (void)tapAvatar:(UITapGestureRecognizer *)sender{
    NSLog(@"点击了头像");
}
- (IBAction)book:(id)sender {
    NSLog(@"点击了笔记本");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self performSegueWithIdentifier:@"userinfo" sender:indexPath];
    [self performSegueWithIdentifier:@"comment" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender {
    NSIndexPath *indexPath = (NSIndexPath*)sender;
    if ([segue.identifier isEqualToString:@"userinfo"]) {
        UserInfoViewController *destViewController = segue.destinationViewController;
        destViewController.blog = [blogs objectAtIndex:indexPath.row];
    }
    if ([segue.identifier isEqualToString:@"comment"]) {
        CommentViewController *destViewController = segue.destinationViewController;
        destViewController.blog = [blogs objectAtIndex:indexPath.row];
    }
}

/**
 切换进入最新日记
 */
- (IBAction)freshBlogs:(id)sender {
     [self refreshBlog:[NSNumber numberWithInt:page]];
}


/**
 切换进入关注日记
 */
- (IBAction)followBlogs:(id)sender {
    NSString *url = @"https://open.timepill.net/api/diaries/follow";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @1;
    params[@"page_size"] = @10;
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass: [NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary *) responseObject;
            blogs = [jsonDict objectForKey:@"diaries"];
            [self.tableView reloadData];
            NSLog(@"blogs: %@", blogs);
        }
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

/**
 切换进入话题日记
 */
- (IBAction)topicBlogs:(id)sender {
    
}


@end
