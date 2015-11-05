//
//  RegisterViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation RegisterViewController
static int myTime;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = UIColorFromRGB(0x40c8c4);
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.width/2;
    self.iconImage.layer.masksToBounds = YES;
    self.verificationBtn.layer.cornerRadius = 2;
    self.register_button.layer.cornerRadius = 2;
    self.verificationTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.nickNameTextField.delegate = self;
    [self countDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_timer invalidate];
    
}

#pragma mark CAPTCHA
- (void)changeButtonName
{
    if (myTime > 1) {
        self.verificationBtn.enabled = NO;
        myTime --;
        NSString *string = [NSString stringWithFormat:@"重获验证码(%d)", myTime];
        [self.verificationBtn setTitle:string forState:UIControlStateNormal];
        //        self.reGain.titleLabel.text = string;
    }else
    {
        [self.timer invalidate];
        self.verificationBtn.enabled = YES;
        [self.verificationBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        //        self.reGain.titleLabel.text = @"重新获取验证码";
    }
}

- (void)countDown
{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButtonName) userInfo:nil repeats:YES];
    self.verificationBtn.enabled = NO;
    [self.verificationBtn setTitle:@"重获验证码(30)" forState:UIControlStateNormal];
    
    myTime = 30;
    
}





- (IBAction)tapback:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)regain:(id)sender {
    NSString *str = [NSString stringWithFormat:@"发送验证码到 %@", self.phoneNumber];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认手机号" message:str preferredStyle:UIAlertControllerStyleAlert];
    

    UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"修改号码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *goAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self countDown];
        _manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *paramters = @{@"phonenumber":self.phoneNumber};
        [_manager POST:[NSString stringWithFormat:@"http://%@/ForgetPassword", SERVER_URL] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self countDown];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }];
    [alert addAction:backAction];
    [alert addAction:goAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];

    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认手机号" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"修改号码",@"确认", nil];
//    [alert show];
    
    
    

}

//#pragma mark UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else if (buttonIndex == 1)
//    {
//        [self countDown];
//        _manager = [AFHTTPRequestOperationManager manager];
//        NSDictionary *paramters = @{@"phonenumber":self.phoneNumber};
//        [_manager POST:[NSString stringWithFormat:@"http://%@/ForgetPassword", SERVER_URL] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            [self countDown];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//        }];
//    }
//}

- (IBAction)uploadImage:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择文件来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"本地相簿", nil];
    [actionSheet showInView:self.view];
    
    
    
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = [%ld]",(long)buttonIndex);
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;

        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
        UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(300.f,300.f)];
        [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imagePath atomically:YES];
        UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imagePath];
         self.iconImage.image = selfPhoto;
    
    [self.iconImage.layer setCornerRadius:CGRectGetHeight(self.iconImage.bounds)/2];
    self.iconImage.layer.masksToBounds = YES;
    
    [self imageUploadToInternet:imagePath];
    
}

- (void)imageUploadToInternet:(NSString *)path
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSURL *filePath = [NSURL fileURLWithPath:path];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager POST:[NSString stringWithFormat:@"http://%@/UploadServlet", SERVER_URL] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:@"selfPhoto.jpg" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *recive = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([recive isEqualToString:@"success"]) {
            [self showTopMessage:@"上传成功"];
        }else
            [self showTopMessage:@"上传失败"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showTopMessage:@"连接不上服务器"];
    }];
}


//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}





- (IBAction)upload:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _manager =  [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramters = @{@"edtextRandom":self.verificationTextField.text, @"edtextpassword":self.passwordTextField.text, @"edtextsname":self.nickNameTextField.text};
    
    [_manager POST: [NSString stringWithFormat:@"http://%@/RegisterPasswordServlet", SERVER_URL]
 parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
     [MBProgressHUD hideHUDForView:self.view animated:YES];
     NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:YES];
     if ([recieve isEqualToString:@""]) {
         
     }else
     {
         
     }
     
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     [MBProgressHUD hideHUDForView:self.view animated:YES];
 }];
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.verificationTextField]) {
        self.verificationCodeImage.highlighted = YES;
    }else if ([textField isEqual:self.passwordTextField])
    {
        self.passwordImage.highlighted = YES;
    }else if([textField isEqual:self.nickNameTextField])
    {
        self.nickNameImage.highlighted = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.verificationTextField.text isEqualToString:@""]) {
        self.verificationCodeImage.highlighted = NO;
    }
    if ([self.passwordTextField.text isEqualToString:@""]) {
        self.passwordImage.highlighted = NO;
    }
    if ([self.nickNameTextField.text isEqualToString:@""]) {
        self.nickNameImage.highlighted = NO;
    }
    
}










@end
