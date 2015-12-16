//
//  AlertViewController.m
//  KudaGo
//
//  Created by Afinello on 11.12.15.
//  Copyright © 2015 UGD Software. All rights reserved.
//

#import "UGDAlertViewController.h"

@interface UGDAlertViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblText;
@property (weak, nonatomic) IBOutlet UIButton *btnYes;
@property (weak, nonatomic) IBOutlet UIButton *btnNo;

@property (nonatomic, retain) UIView* superview;
@property (nonatomic, strong) NSMutableArray* superviewConstraints;

@property (nonatomic) UIEdgeInsets margin;
@property (nonatomic, strong) NSNumber* padding;

@property (nonatomic, strong) UIColor* colorBtnAction;
@property (nonatomic, strong) UIColor* colorBtnNegative;
@property (nonatomic, strong) UIColor* colorTitleAction;
@property (nonatomic, strong) UIColor* colorTitleNegative;

@property (nonatomic, copy) UGDCompletionBlockWithResult onComplete;

@end

@implementation UGDAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.imgIcon.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgIcon.clipsToBounds = YES;
    self.imgIcon.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    self.lblText.translatesAutoresizingMaskIntoConstraints = NO;
    self.lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnYes.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnNo.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.lblTitle.font = kUGDAlertViewFontTitle;
    self.lblTitle.textColor = kUGDAlertViewColorDark;
    
    self.lblText.font = kUGDAlertViewFontText;
    self.lblText.textColor = kUGDAlertViewColorLight;
    
    self.btnNo.titleLabel.font = kUGDAlertViewFontButton;
    self.btnYes.titleLabel.font = kUGDAlertViewFontButton;
    
    self.view.backgroundColor = kUGDAlertViewColorMask;
    self.containerView.backgroundColor = kUGDAlertViewColorBackground;
    
    self.padding = (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) ? @(12) : @(24);
    
    self.colorBtnAction = kUGDAlertViewColorAction;
    self.colorBtnNegative = [UIColor clearColor];
    self.colorTitleAction = kUGDAlertViewColorBackground;
    self.colorTitleNegative = kUGDAlertViewColorLight;
    
    [self updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) initWithTitle:(NSString *)title text:(NSString *)text icon:(UIImage *)icon actionTitle:(NSString *)actionTitle negativeTitle:(NSString *)negativeTitle
{
    self = [super initWithNibName:@"UGDAlertViewController" bundle:nil];
    if(self){
        self.strTitle = title;
        self.strText = text;
        self.imageIcon = icon;
        self.strPositive = actionTitle;
        self.strNegative = negativeTitle;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.lblTitle setText:_strTitle];
    [self.lblText setText:_strText];
    [self.btnNo setTitle:self.strNegative forState:UIControlStateNormal];
    [self.btnYes setTitle:self.strPositive forState:UIControlStateNormal];
    [self.imgIcon setImage:(self.imageIcon != nil) ? self.imageIcon : [UIImage imageNamed:@"icon_default_alert"]];
    
    [self.btnNo setBackgroundColor:self.colorBtnNegative];
    [self.btnNo setTitleColor:self.colorTitleNegative forState:UIControlStateNormal];
    [self.btnYes setBackgroundColor:self.colorBtnAction];
    [self.btnYes setTitleColor:self.colorTitleAction forState:UIControlStateNormal];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.view.alpha = 1;
    } completion:nil];
}

- (void) showInViewController:(UIViewController *)vc withCompletion:(UGDCompletionBlockWithResult)complete
{
    self.onComplete = complete;
    self.view.alpha = 0;
    
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
    
    self.superview = vc.view;
    
    self.view.center = vc.view.center;
    [self didMoveToParentViewController:vc];
}

- (void) dismiss
{
    if(self.superview){
        [self.superview removeConstraints:self.superviewConstraints];
        self.superview = nil;
    }
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void) hideAnimated:(BOOL)animated
{
    if(animated){
        [UIView animateWithDuration:0.3f animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            if(finished){
                [self dismiss];
            }
        }];
    } else {
        [self dismiss];
    }
    
}

- (IBAction)onBtnPositive:(id)sender {
    if(self.onComplete){
        self.onComplete(true);
    }
    
    [self hide:YES];
}

- (IBAction)onBtnNegative:(id)sender {
    if(self.onComplete){
        self.onComplete(false);
    }
    [self hide:YES];
}

- (void) updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.view removeConstraints:self.view.constraints];
    
    [self.containerView removeConstraints:self.containerView.constraints];
    
    //
    // setup autolayout constraints for all child views (labels, buttons, image)
    //
    NSMutableArray* constraints = [NSMutableArray new];
    
    // prepare metrics dictionary with default inter-item spacing
    NSDictionary* metricsPadding = @{@"padding" : self.padding};
    
    // align elements horizontally
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=padding)-[image]-(>=padding)-|"
                                                                             options:0 metrics:metricsPadding
                                                                               views: @{@"image": self.imgIcon}]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[lblTitle]-padding-|"
                                                                             options:0 metrics:metricsPadding
                                                                               views: @{@"lblTitle": self.lblTitle}]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[lblText]-padding-|"
                                                                             options:0 metrics:metricsPadding
                                                                               views: @{@"lblText": self.lblText}]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[btnNo]-padding-[btnYes(==btnNo)]-padding-|"
                                                                             options:0 metrics:metricsPadding
                                                                               views: @{@"btnNo": self.btnNo, @"btnYes": self.btnYes}]];
    
    // align elements vertically
    [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[image]-24-[lblTitle(21.0)]-16-[lblText]-(>=24)-[btnYes]-padding-|"
                                                                              options:0 metrics:metricsPadding
                                                                                views:@{@"image": self.imgIcon, @"lblTitle":self.lblTitle, @"lblText": self.lblText, @"btnYes": self.btnYes}]];
    [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lblText]-(>=24)-[btnNo]-padding-|"
                                                                              options:0 metrics:metricsPadding
                                                                                views:@{@"lblText": self.lblText, @"btnNo": self.btnNo}]];
    
    // set icon image aspect ration to 1:1
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.imgIcon
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.containerView
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.f constant:0.f]];
    
    // apply all generated autolayout constraints to container view
    [self.containerView addConstraints:constraints];
    
    
    //
    // setup autolayout constraints for container view
    //
    NSMutableArray* constraintsVC = [NSMutableArray new];
    
    [constraintsVC addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-marginLeft-[container]-marginRight-|"
                                                                               options:0
                                                                               metrics:@{@"marginLeft": @(self.margin.left), @"marginRight": @(self.margin.right)}
                                                                               views: @{@"container": self.containerView}]];
    
    [constraintsVC addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=marginTop)-[container]-(>=marginBottom)-|"
                                                                               options:0
                                                                               metrics:@{@"marginTop": @(self.margin.top), @"marginBottom": @(self.margin.bottom)}
                                                                                 views: @{@"container": self.containerView}]];
    
    [self.view addConstraints:constraintsVC];
    
    
    //
    // setup autolayout constraints for superview
    //
    if(self.superview){
        if(self.superviewConstraints){
            [self.superview removeConstraints:self.superviewConstraints];
        }
        self.superviewConstraints = [NSMutableArray new];
        [self.superviewConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:@{@"view" : self.view}]];
        
        [self.superviewConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:@{@"view" : self.view}]];
        [self.superview addConstraints:self.superviewConstraints];
    }
    
}

- (void) setMargin:(UIEdgeInsets)margin
{
    _margin = margin;
    
    [self updateViewConstraints];
}

- (void) setMarginTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    [self setMargin:UIEdgeInsetsMake(top, left, bottom, right)];
}

- (void) setActionButtonColor:(UIColor *)actionBtnColor withTextColor:(UIColor *)actionTextColor
{
    self.colorBtnAction = actionBtnColor;
    self.colorTitleAction = actionTextColor;
}

- (void) setNegativeButtonColor:(UIColor *)negativeColor withTextColor:(UIColor *)negativeTextColor
{
    self.colorBtnNegative = negativeColor;
    self.colorTitleNegative = negativeTextColor;
}

@end
