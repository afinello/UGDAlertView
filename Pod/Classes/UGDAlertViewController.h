//
//  AlertViewController.h
//  KudaGo
//
//  Created by Afinello on 11.12.15.
//  Copyright © 2015 UGD Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGDAlertViewDefinitions.h"

@interface UGDAlertViewController : UIViewController

@property (nonatomic, retain) NSString* strTitle;
@property (nonatomic, retain) NSString* strText;
@property (nonatomic, retain) NSString* strPositive;
@property (nonatomic, retain) NSString* strNegative;
@property (nonatomic, retain) UIImage* imageIcon;

- (id) initWithTitle:(NSString*)title text:(NSString*)text icon:(UIImage*)icon actionTitle:(NSString*)actionTitle negativeTitle:(NSString*)negativeTitle;

- (void) setActionButtonColor:(UIColor*)actionBtnColor withTextColor:(UIColor*)actionTextColor;
- (void) setNegativeButtonColor:(UIColor*)negativeColor withTextColor:(UIColor*)negativeTextColor;

- (void) setMargin:(UIEdgeInsets)margin;
- (void) setMarginTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

- (void) showInViewController:(UIViewController*)vc withCompletion:(UGDCompletionBlockWithResult)complete;
- (void) hide:(BOOL)animated;

@end
