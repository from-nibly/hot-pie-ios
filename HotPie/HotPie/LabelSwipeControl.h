//
//  UILabelSwipeControl.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LabelSwipeControl;

@protocol LabelSwipeControlDelegate <NSObject>

- (void)didFinishSwipeWithLabelSwipeControl:(LabelSwipeControl *)labelSwipeControl;

@end

@interface LabelSwipeControl : NSObject

- (instancetype)initWithUILabel:(UILabel *)label value:(NSInteger)value;
@property (nonatomic, weak) id <LabelSwipeControlDelegate> delegate;
@property (nonatomic) CGFloat value;
@property (nonatomic) BOOL swipeEnabled;

@end
