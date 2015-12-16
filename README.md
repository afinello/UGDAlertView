# UGDAlertView

[![CI Status](http://img.shields.io/travis/afinello/UGDAlertView.svg?style=flat)](https://travis-ci.org/afinello/UGDAlertView)
[![Version](https://img.shields.io/cocoapods/v/UGDAlertView.svg?style=flat)](http://cocoapods.org/pods/UGDAlertView)
[![License](https://img.shields.io/cocoapods/l/UGDAlertView.svg?style=flat)](http://cocoapods.org/pods/UGDAlertView)
[![Platform](https://img.shields.io/cocoapods/p/UGDAlertView.svg?style=flat)](http://cocoapods.org/pods/UGDAlertView)

## Usage

Use similar code in your ciew controller to show a custom call-to-action alert view over your controller content:

```objective-c
UGDAlertViewController* actionVC = [[UGDAlertViewController alloc] initWithTitle:@"Alert title" 
                                                                            text:@"Want to use custom alert view with call to action?" 
                                                                            icon:nil 
                                                                     actionTitle:@"Sure" 
                                                                        negative:@"No, thanks"];

[actionVC setMargin:UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0)];

[actionVC showInViewController:self withCompletion:^(BOOL accepted) {
    // your code here
    // (accepted == YES) if user pressed the call to action button

    // remove alert view
    [actionVC hideAnimated:YES];
}];

```

## Requirements

iOS 7 and later

## Installation

UGDAlertView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UGDAlertView"
```

## Author

Afinello

## License

UGDAlertView is available under the MIT license. See the LICENSE file for more info.
