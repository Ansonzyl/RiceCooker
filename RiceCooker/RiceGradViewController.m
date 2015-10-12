//
//  RiceGradViewController.m
//  RiceCooker
//
//  Created by yi on 15/9/25.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "RiceGradViewController.h"

@interface RiceGradViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;


@end

@implementation RiceGradViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"精米程度";
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), <#CGFloat height#>)];
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
    [self.textLabel sizeToFit];
    
    
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
