//
//  RiceGradViewController.m
//  RiceCooker
//
//  Created by yi on 15/9/25.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "RiceGradViewController.h"
#import "DM_EVegetable.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kRate [UIScreen mainScreen].bounds.size.width / 414
@interface RiceGradViewController ()
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) UILabel *riceGradLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *buttomNumberLabel;
@end

@implementation RiceGradViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"精米程度";

    [self initializeView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LabelContentList" ofType:@"plist"];
    NSArray *array = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"riceGrad"];
    NSMutableString *label = [[NSMutableString alloc] init];
    for (int i = 0; i<array.count; i++) {
        [label appendString:array[i]];
        [label appendString:@"\n"];
    }
    self.textLabel.text = label;
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:_textLabel.text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label length])];
    [self.textLabel setAttributedText:attributeString];

    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self riceGridConnectNetWork];
}


- (void)riceGridConnectNetWork
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"UUID": _UUID,
                                 @"ricedegree" : _numberLabel.text};
    
    [manager POST:[NSString stringWithFormat:@"http://%@/RiceDegreeServlet", SERVER_URL] parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([recieve isEqualToString:@"success"])
        {
            
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
}





- (void)initializeView
{
    CGFloat size = 151 * kRate;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(132*kRate, 110*kRate, size, size)];
    imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"精米程度圆环" ofType:@"png"]];
    size = 34*kRate;
   UIImageView *miImageView = [[UIImageView alloc] initWithFrame:CGRectMake(190*kRate, 584*kRate, size, size)];
    miImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-精米程度阴" ofType:@"png"]];
    _textLabel = [self setLabelWithFrame:CGRectMake(0, 331*kRate, kWidth, 160*kRate) withSize:11 withText:nil];
//    _textLabel.center = CGPointMake(kWidth/2, 413*kRate);
    _textLabel.numberOfLines = 0;
    
    CGRect frame = CGRectMake(0, 0, 50, 30);
    _numberLabel = [self setLabelWithFrame:frame withSize:26*kRate withText:@"1"];
    _numberLabel.center = imageView.center;
    _riceGradLabel = [self setLabelWithFrame:frame withSize:15*kRate withText:@"糙米"];
    _riceGradLabel.center = [self makeCenterWithPoint:_numberLabel.center withWidth:0 withHeight:-30];
    _buttomNumberLabel = [self setLabelWithFrame:frame withSize:26 withText:_numberLabel.text];
    _buttomNumberLabel.center = [self makeCenterWithPoint:miImageView.center withWidth:0 withHeight:-50];
    UILabel *textLabel = [self setLabelWithFrame:frame withSize:10 withText:@"精米程度"];
        textLabel.center = [self makeCenterWithPoint:_numberLabel.center withWidth:0 withHeight:30];
        [self.view addSubview:textLabel];

    frame = CGRectMake(0, 0, 18*kRate, 34.5*kRate);
    UIButton *leftButton = [self buttonWithFrame:frame WithImageName:@"icon-箭头left" withAction:@selector(leftButton:)];
    leftButton.center = [self makeCenterWithPoint:miImageView.center withWidth:-126 withHeight:0];
    [self.view addSubview:leftButton];

    
    UIButton *rightButton = [self buttonWithFrame:frame WithImageName:@"icon-箭头right" withAction:@selector(rightButton:)];
    rightButton.center = [self makeCenterWithPoint:miImageView.center withWidth:126 withHeight:0];
    [self.view addSubview:rightButton];
    
        
    textLabel = [self setLabelWithFrame:frame withSize:9 withText:@"档"];
    textLabel.center = [self makeCenterWithPoint:miImageView.center withWidth:0 withHeight:-30];
    [self.view addSubview:textLabel];
    
    [self.view addSubview:_buttomNumberLabel];
    [self.view addSubview:miImageView];
    [self.view addSubview:imageView];
    [self.view addSubview:_riceGradLabel];
    [self.view addSubview:_textLabel];
    [self.view addSubview:_numberLabel];
    
}

- (CGPoint)makeCenterWithPoint:(CGPoint)center withWidth:(CGFloat)width withHeight:(CGFloat)height
{
    CGPoint point = center;
    point.x += width*kRate;
    point.y += height*kRate;
    return point;
}


- (UILabel *)setLabelWithFrame:(CGRect)frame withSize:(CGFloat)size withText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment =  NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:size * kRate];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    return label;
}

- (UIButton *)buttonWithFrame:(CGRect)frame WithImageName:(NSString *)name withAction:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    [button setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (IBAction)leftButton:(id)sender
{
    int i = [_numberLabel.text intValue];
    if ( i > 1 ) {
        i--;
        _numberLabel.text = [NSString stringWithFormat:@"%d", i];
        _buttomNumberLabel.text = _numberLabel.text;
    }
}

- (IBAction)rightButton:(id)sender
{
    int i = [_numberLabel.text intValue];
    if ( i < 4  ) {
        i++;
        _numberLabel.text = [NSString stringWithFormat:@"%d", i];
        _buttomNumberLabel.text = _numberLabel.text;
    }

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
