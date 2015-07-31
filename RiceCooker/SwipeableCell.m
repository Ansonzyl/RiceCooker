//
//  SwipeableCell.m
//  RiceCooker
//
//  Created by yi on 15/7/28.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "SwipeableCell.h"

@interface SwipeableCell()
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewRightConstraint;

@end


static CGFloat kBounceValue = 20.0f;
@implementation SwipeableCell

- (IBAction)buttonClicked:(id)sender
{
    if (sender == self.shareButton) {
        [self.delegate buttonShareActionForItem:self.shareDevice];
    }else if (sender == self.managerButton) {
        [self.delegate buttonManagerActionForItem:self.shareDevice];
    }else
        NSLog(@"click unknown button");
}

- (void)setShareDevice:(DM_ShareDevices *)shareDevice
{
    _shareDevice = shareDevice;
    _titleLabel.text = shareDevice.devicename;
    _detailLabel.text = shareDevice.state;
    NSString *image = [NSString stringWithFormat:@"icon-%@133", _shareDevice.devicename];
    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
    self.iconImage.image = [UIImage imageWithContentsOfFile:path];

}



- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
    self.panRecognizer.delegate = self;
    [self.myContentView addGestureRecognizer:self.panRecognizer];
}


- (void)panThisCell:(UIPanGestureRecognizer *)recognizer{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = [recognizer translationInView:self.myContentView];
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint currentPoint = [recognizer translationInView:self.myContentView];
            CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
            BOOL panningLeft = YES;
            if (currentPoint.x < self.panStartPoint.x) {
                panningLeft = YES;
            }
            if (self.startingRightLayoutConstraintConstant == 0) { //2
                //The cell was closed and is now opening
                if (!panningLeft) {
                    CGFloat constant = MAX(-deltaX, 0); //3
                    if (constant == 0) { //4
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO]; //5
                    } else {
                        self.contentViewRightConstraint.constant = constant; //6
                    }
                } else {
                    CGFloat constant = MIN(-deltaX, [self buttonTotalWidth]); //7
                    if (constant == [self buttonTotalWidth]) { //8
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO]; //9
                    } else {
                        self.contentViewRightConstraint.constant = constant; //10
                    }
                }
            }else {
                CGFloat adjustment = self.startingRightLayoutConstraintConstant - deltaX;
                if (!panningLeft) {
                    CGFloat constant = MAX(adjustment, 0); //12
                    if (constant == 0) { //13
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO]; //14
                    } else {
                        self.contentViewRightConstraint.constant = constant; //15
                    }
                } else {
                    CGFloat constant = MIN(adjustment, [self buttonTotalWidth]); //16
                    if (constant == [self buttonTotalWidth]) { //17
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO]; //18
                    } else {
                        self.contentViewRightConstraint.constant = constant;//19
                    }
                }
            }
            
            self.contentViewLeftConstraint.constant = -self.contentViewRightConstraint.constant; //20
            
            
        }
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"Pan Ended");
            if (self.startingRightLayoutConstraintConstant == 0) {
                //1
                
                //Cell was opening
                CGFloat halfOfButtonOne = CGRectGetWidth(self.shareButton.frame) / 2;
                //2
                if (self.contentViewRightConstraint.constant >= halfOfButtonOne) {
                    //3
                    
                    //Open all the way
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    
                    //Re-close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            } else {
                
                //Cell was closing
                CGFloat buttonOnePlusHalfOfButton2 = CGRectGetWidth(self.shareButton.frame);
                //4
                if (self.contentViewRightConstraint.constant >= buttonOnePlusHalfOfButton2) {
                    //5
                    
                    //Re-open all the way
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    
                    //Close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            }
            break;
        case UIGestureRecognizerStateCancelled:
            if (self.startingRightLayoutConstraintConstant == 0) {
                [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
            }else {
                [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
            }
//            break;
        default:
            break;
    }}



- (void)updateConstraintsIfNeeded:(BOOL)animated completion:(void (^)(BOOL finished))completion;
{
    float duration = 0;
    if (animated) {
        duration = 0.1;
    }
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:completion];
}




- (CGFloat)buttonTotalWidth{
    return CGRectGetWidth(self.frame) - CGRectGetMinX(self.managerButton.frame);
}

- (void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)notifyDelegate
{
    if (notifyDelegate) {
        [self.delegate cellDidClose:self];
    }
    if (self.startingRightLayoutConstraintConstant == 0 &&
        self.contentViewRightConstraint.constant == 0) {
        
        //Already all the way closed, no bounce necessary
        return;
    }
    
    self.contentViewRightConstraint.constant = -kBounceValue;
    self.contentViewLeftConstraint.constant = kBounceValue;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        self.contentViewRightConstraint.constant = -18;
        self.contentViewLeftConstraint.constant = -8;
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }];
    }];
    
}

- (void)setConstraintsToShowAllButtons:(BOOL)animated notifyDelegateDidOpen:(BOOL)notifyDelegate
{
    //TODO: Build
    if (notifyDelegate) {
        [self.delegate cellDidClose:self];
    }
    if (self.startingRightLayoutConstraintConstant == [self buttonTotalWidth] && self.contentViewRightConstraint.constant == [self buttonTotalWidth]) {
        return;
    }
    self.contentViewLeftConstraint.constant = -[self buttonTotalWidth] - kBounceValue;
    self.contentViewRightConstraint.constant =  [self buttonTotalWidth] + kBounceValue;
    
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        self.contentViewLeftConstraint.constant = -[self buttonTotalWidth];
        self.contentViewRightConstraint.constant = [self buttonTotalWidth];
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            self.startingRightLayoutConstraintConstant = self.contentViewLeftConstraint.constant;
        }];
    }];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self resetConstraintContstantsToZero:NO notifyDelegateDidClose:NO];
}

- (void)openCell
{
    [self setConstraintsToShowAllButtons:NO notifyDelegateDidOpen:NO];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
