//
//  CommentViewController.h
//  blog
//
//  Created by Jiayun Xie on 16/11/1.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController

@property (strong, nonatomic) NSDictionary * blog;
@property (weak, nonatomic) IBOutlet UILabel *notebook;
@property (weak, nonatomic) IBOutlet UILabel *diary;

@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *commentContent;

@end
