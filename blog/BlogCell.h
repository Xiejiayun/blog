//
//  BlogCell.h
//  blog
//
//  Created by Jiayun Xie on 16/10/29.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *createtime;
@property (weak, nonatomic) IBOutlet UITextView *brief;
@property (weak, nonatomic) IBOutlet UILabel *book;
@property (weak, nonatomic) IBOutlet UIButton *reply;

@end
