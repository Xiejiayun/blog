//
//  FreshBlogViewController.h
//  blog
//
//  Created by Jiayun Xie on 16/10/29.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreshBlogViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSInteger *uid;

@end
