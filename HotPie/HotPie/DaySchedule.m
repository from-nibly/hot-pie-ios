//
//  Schedule.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "DaySchedule.h"
#import "TimeRangeSchedule.h"

@implementation DaySchedule

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]) {
        self.ranges = [NSMutableArray new];
        CGFloat defaultValue = [dict[@"otherwise"] floatValue];
        self.defaultValue = defaultValue;
        int count = 0;
        for(NSDictionary *overrideDict in dict[@"overrides"]) {
            count++;
            TimeRangeSchedule *timeRange = [[TimeRangeSchedule alloc] initWithDictionary:overrideDict];
            float color = (240.0f - count * 7) / 255.0f;
            timeRange.color = [UIColor colorWithRed:color green:color blue:color alpha:1];
            [self.ranges addObject:timeRange];
        }
    }
    return self;
}

- (TimeRangeSchedule *)timeRangeScheduleForHour:(NSInteger)hour {
    NSArray *timeRanges = [self.ranges filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%@ >= SELF.startHour AND %@ <= SELF.stopHour", @(hour), @(hour)]];
    return [timeRanges firstObject];
}

@end
