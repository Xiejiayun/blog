//
//  CommentViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/11/1.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _notebook.text = [_blog objectForKey:@"notebook_subject"];
    _content.text = [_blog objectForKey:@"content"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//添加评论
- (IBAction)comment:(id)sender {
}

@end
