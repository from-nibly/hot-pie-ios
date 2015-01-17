//
//  PopupController.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupController : UIViewController

+ (PopupController *)popupController;
+ (NSString *)controllerName;
- (void)show;

@end
