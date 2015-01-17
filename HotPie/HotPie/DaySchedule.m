//
//  Schedule.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "DaySchedule.h"
#import "TimeRangeSchedule.h"

// Temp
#define color(r, g, b) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f]


@implementation DaySchedule

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]) {
        _ranges = [NSMutableArray new];
        CGFloat defaultValue = [dict[@"otherwise"] floatValue];
        _defaultValue = defaultValue;
        int count = 0;
        for(NSDictionary *overrideDict in dict[@"overrides"]) {
            count++;
            TimeRangeSchedule *timeRange = [[TimeRangeSchedule alloc] initWithDictionary:overrideDict];
            timeRange.color = [self colorForIndex:count];
            [_ranges addObject:timeRange];
        }
    }
    return self;
}

- (TimeRangeSchedule *)timeRangeScheduleForHour:(NSInteger)hour {
    NSArray *timeRanges = [self.ranges filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%@ >= SELF.startHour AND %@ <= SELF.stopHour", @(hour), @(hour)]];
    return [timeRanges firstObject];
}

// Temp
- (UIColor *)colorForIndex:(NSInteger)index {
    NSArray *colors = @[color(200.0f, 255.0f, 255.0f), color(255.0f, 200.0f, 255.0f), color(255.0f, 255.0f, 200.0f), color(200.0f, 255.0f, 200.0f), color(200.0f, 200.0f, 255.0f), color(255.0f, 200.0f, 200.0f), color(200.0f, 200.0f, 200.0f)];
    if(index >= colors.count) {
        index = colors.count - 1;
    }
    return colors[index];
}

@end
