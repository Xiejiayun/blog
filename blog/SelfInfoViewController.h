//
//  SelfInfoViewController.h
//  blog
//
//  Created by Jiayun Xie on 16/11/9.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UICollectionView *followCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end
