//
//  TimeRangeSchedule.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "TimeRangeSchedule.h"

@implementation TimeRangeSchedule

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]) {
        self.label = dict[@"label"];
        self.temp = [dict[@"temp"] integerValue];
        NSArray *startTime = [dict[@"start"] componentsSeparatedByString:@":"];
        self.startHour = [startTime[0] integerValue];
        self.startMin = [startTime[1] integerValue];
        NSArray *stopTime = [dict[@"stop"] componentsSeparatedByString:@":"];
        self.stopHour = [stopTime[0] integerValue];
        self.stopMin = [stopTime[1] integerValue];
    }
    return self;
}

@end
