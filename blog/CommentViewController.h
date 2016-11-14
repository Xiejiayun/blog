//
//  CommentViewController.h
//  blog
//
//  Created by Jiayun Xie on 16/11/1.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSDictionary * blog;

@property (nonatomic, copy, setter=setComments:) NSMutableArray *comments;
@property (weak, nonatomic) IBOutlet UILabel *notebook;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UITableView *commentView;
@property (weak, nonatomic) IBOutlet UITextField *commentContent;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIButton *follow;
@property NSString *userid;

@end
