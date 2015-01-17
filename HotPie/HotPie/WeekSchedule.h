//
//  WeekSchedule.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DaySchedule;

@interface WeekSchedule : NSObject

+ (void)getCurrentScheduleNameOnCompletion:(void (^)(NSString *name, NSError *error))success;
+ (void)getWeekScheduleWithName:(NSString *)name completion:(void (^)(WeekSchedule *weekSchedule, NSError *error))success;
- (DaySchedule *)scheduleForDay:(NSString *)day;

@end
