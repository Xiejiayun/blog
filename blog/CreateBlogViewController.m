//
//  CreateBlogViewController.m
//  blog
//
//  Created by Jiayun Xie on 16/10/30.
//  Copyright © 2016年 Jiayun Xie. All rights reserved.
//

#import "AppDelegate.h"
#import "CreateBlogViewController.h"
#import "FreshBlogViewController.h"
#import "ArticlesViewController.h"
#import <AFNetworking/AFNetworking.h>


@interface CreateBlogViewController ()

@end

@implementation CreateBlogViewController
NSArray *blogSets;
NSDictionary *uinfo;


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    uinfo = delegate.uinfo;
    NSInteger uid = (NSInteger)[uinfo objectForKey:@"id"];
    [self initBlogSets:uid];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return blogSets.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [blogSets[row] objectForKey:@"subject"];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSNumber *blogSetId = [blogSets[row] valueForKey:@"id"];
    _hiddenBlogSetId.text = [blogSetId stringValue];
}

-(void) initBlogSets:(NSInteger)uid{
    NSString *url = @"https://open.timepill.net/api/notebooks/my";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager.requestSerializer setHTTPShouldHandleCookies:TRUE];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass: [NSArray class]]) {
            blogSets = (NSArray *) responseObject;
            [self.pickerView reloadAllComponents];
            NSLog(@"blogs: %@", blogSets);
        }
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (IBAction)createBlog:(id)sender {
    [self createBlog];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSNumber *blogSetId = (NSNumber*)sender;
    if ([[segue identifier] isEqualToString:@"backArticles"]) {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
            ArticlesViewController *articleController =(ArticlesViewController *)[navController topViewController];
            articleController.blogSetId = blogSetId;
        }
    }
}

-(void) createBlog {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    NSString *content = _content.text;
    NSString *blogSetId = _hiddenBlogSetId.text;
    NSString *url = [[@"https://open.timepill.net/api/notebooks/" stringByAppendingString:blogSetId] stringByAppendingString:@"/diaries"];
    NSData *fileData = _image.image?UIImageJPEGRepresentation(_image.image, 0.5):nil;
    NSString *username = @"furnace09@163.com";
    NSString *password = @"xiexie123";
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (fileData) {
            [formData appendPartWithFileData:fileData
                                        name:@"photo" fileName:@"img.jepg" mimeType:@"image/jpeg"];
        }
        [formData appendPartWithFormData:[content dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"content"];
        [self.pickerView reloadAllComponents];
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self performSegueWithIdentifier:@"backArticles" sender:blogSetId];
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
- (IBAction)back:(id)sender {
    [self performSegueWithIdentifier:@"back" sender:self];
}

@end
