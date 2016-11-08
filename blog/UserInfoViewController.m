//
//  UserInfoViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/10/30.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "UserInfoViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController
@synthesize avatar;
@synthesize name;
@synthesize desc;
@synthesize blog;

- (void)viewDidLoad {
    [super viewDidLoad];
    name.text = [[blog objectForKey:@"user"] objectForKey:@"name"];
    
    NSString *url = [[blog objectForKey:@"user"]objectForKey:@"iconUrl"];
    [avatar sd_setImageWithURL:[NSURL URLWithString:url]
              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                         NSLog(@"Loaded: %@", image);
                     }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
