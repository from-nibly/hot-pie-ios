//
//  Schedule.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimeRangeSchedule;

@interface DaySchedule : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (TimeRangeSchedule *)timeRangeScheduleForHour:(NSInteger)hour;

@property (nonatomic, strong) NSMutableArray *ranges;
@property (nonatomic) CGFloat defaultValue;

@end
