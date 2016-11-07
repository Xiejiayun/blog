//
//  UserInfoViewController.h
//  blog
//
//  Created by Jiayun Xie on 16/10/30.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UITableView *blogSet;
@property (strong, nonatomic) NSDictionary * blog;

@end
