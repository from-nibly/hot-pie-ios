//
//  TimeRangeSchedule.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeRangeSchedule : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *label;
@property (nonatomic) CGFloat temp;
@property (nonatomic) NSInteger startHour;
@property (nonatomic) NSInteger startMin;
@property (nonatomic) NSInteger stopHour;
@property (nonatomic) NSInteger stopMin;

@end
