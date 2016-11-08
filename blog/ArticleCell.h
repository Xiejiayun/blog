//
//  ArticleCell.h
//  blog
//
//  Created by Jiayun Xie on 16/11/7.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *updatetime;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (nonatomic) NSInteger blogSetId;

@end
