//
//  CreateBlogViewController.h
//  blog
//
//  Created by Jiayun Xie on 16/10/30.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateBlogViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *title;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *saveBlog;
@property (weak, nonatomic) IBOutlet UIButton *cancel;

@end
