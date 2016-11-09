//
//  BlogSetViewController.h
//  blog
//
//  Created by Jiayun Xie on 16/11/7.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogSetViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, retain) NSMutableArray * blogSet;
//, setter=setBlogSets:

@end
