//
//  CreateBlogViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/10/30.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "CreateBlogViewController.h"
#import "FreshBlogViewController.h"
#import <AFNetworking/AFNetworking.h>


@interface CreateBlogViewController ()

@end

@implementation CreateBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)createBlog:(id)sender {
    [self createBlog];
}

-(void) createBlog {
    NSString *url = @"https://open.timepill.net/api/notebooks/803917/diaries";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    NSString *content = _content.text;
    NSData *fileData = _image.image?UIImageJPEGRepresentation(_image.image, 0.5):nil;
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:fileData
                                    name:@"photo"
                                fileName:@"img.jepg" mimeType:@"image/jpeg"];
        
        [formData appendPartWithFormData:[content dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"content"];
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response: %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *pictureController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pictureController.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        pictureController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    pictureController.delegate = self;
    [self presentViewController:pictureController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.image.image = image;
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

@end
