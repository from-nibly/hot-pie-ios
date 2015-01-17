//
//  UILabelSwipeControl.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "LabelSwipeControl.h"
#import "Temperature.h"

@interface LabelSwipeControl()

@property (nonatomic) CGFloat changeSpeed;
@property (nonatomic) CGFloat directionCount;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation LabelSwipeControl

- (instancetype)initWithUILabel:(UILabel *)label value:(NSInteger)value {
    if(self = [super init]) {
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [label addGestureRecognizer:self.panGestureRecognizer];
        label.userInteractionEnabled = YES;
        self.label = label;
        self.value = value; // temp
        self.changeSpeed = 0.3; // The rate at which the value changes. Higher faster, lower slower.
        [self updateText];
    }
    return self;
}

- (void)dealloc {
    [self.label removeGestureRecognizer:self.panGestureRecognizer];
    self.panGestureRecognizer = nil;
}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
    CGPoint point = [recognizer velocityInView:self.label];
    CGFloat multiplier = fabsf(point.x) < 100 ? 0.5 : 1 + abs(point.x / 150);
    point.x = (point.x > 0 ? self.changeSpeed : -self.changeSpeed) * multiplier;
    self.directionCount += point.x;
    if(self.directionCount >= 1) {
        self.value++;
        self.directionCount--;
    } else if(self.directionCount <= -1) {
        self.value--;
        self.directionCount++;
    }
    [self updateText];
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(didFinishSwipeWithLabelSwipeControl:)]){
            [self.delegate didFinishSwipeWithLabelSwipeControl:self];
        }
    }
}

- (void)updateText {
    // TODO: Make it so a prefix and suffix can be set so this can be used for other stuff besides values
    self.label.text = [NSString stringWithFormat:@" %@", [Temperature formattedTextWithTemperature:self.value]];
}

#pragma mark - Properties

- (void)setValue:(CGFloat)value {
    _value = value;
    [self updateText];
}

- (void)setSwipeEnabled:(BOOL)swipeEnabled {
    _swipeEnabled = swipeEnabled;
    self.panGestureRecognizer.enabled = swipeEnabled;
}

@end
