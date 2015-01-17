//
//  TouchWindow.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchWindow;

@protocol TouchWindowDelegate <NSObject>

- (void)touchWindow:(TouchWindow *)window touchedPoint:(CGPoint)point;

@end

@interface TouchWindow : UIWindow

@property (nonatomic, weak) id <TouchWindowDelegate> touchDelegate;

@end
