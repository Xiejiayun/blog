//
//  ArticlesViewController.h
//  blog
//
//  Created by Jiayun Xie on 16/11/7.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticlesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSNumber *blogSetId;

@property NSMutableDictionary *heightCache;

@end
