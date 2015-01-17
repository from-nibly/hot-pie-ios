//
//  TouchWindow.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "TouchWindow.h"

@implementation TouchWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if(self.touchDelegate && [self.touchDelegate respondsToSelector:@selector(touchWindow:touchedPoint:)]) {
        [self.touchDelegate touchWindow:self touchedPoint:point];
    }
    return hitView;
}

@end
