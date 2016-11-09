//
//  CreateBlogSetViewController.h
//  blog
//
//  Created by Jiayun Xie on 16/11/9.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateBlogSetViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *subject;
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UITextField *expire;
@property (weak, nonatomic) IBOutlet UIButton *createBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *hiddenPrivacy;

@end
