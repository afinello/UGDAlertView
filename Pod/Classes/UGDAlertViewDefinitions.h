//
//  UGDAlertViewDefinitions.h
//  UGDAlertView
//
//  Created by Afinello on 16.12.15.
//  Copyright © 2015 UGD Software. All rights reserved.
//

#ifndef UGDAlertViewDefinitions_h
#define UGDAlertViewDefinitions_h

typedef void (^UGDCompletionBlockWithResult)(BOOL accepted);

/* default fonts */
#define kUGDAlertViewFontTitle          [UIFont systemFontOfSize:17.0f]
#define kUGDAlertViewFontText           [UIFont systemFontOfSize:14.0f]
#define kUGDAlertViewFontButton         [UIFont systemFontOfSize:15.0f]

/* default colors */
#define kUGDAlertViewColorBackground    [UIColor whiteColor]
#define kUGDAlertViewColorDark          [UIColor colorWithRed:33.0f/255.0f green:33.0f/255.0f blue:33.0f/255.0f alpha:1]
#define kUGDAlertViewColorLight         [UIColor colorWithRed:141.0f/255.0f green:141.0f/255.0f blue:141.0f/255.0f alpha:1]
#define kUGDAlertViewColorMask          [[UIColor blackColor] colorWithAlphaComponent:0.25f]
#define kUGDAlertViewColorAction        [UIColor redColor]

/* common definitions */
#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA           ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define PIXEL_WIDTH         1/[[UIScreen mainScreen] scale]

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5         (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6         (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P        (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#endif /* UGDAlertViewDefinitions_h */
