//
//  WeekSchedule.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "APIClient.h"
#import "WeekSchedule.h"
#import "DaySchedule.h"
#import "DaySchedule.h"

@interface WeekSchedule()

@property (nonatomic, strong) NSMutableDictionary *scheduleDictionaries;

@end

@implementation WeekSchedule

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]) {
        self.scheduleDictionaries = [NSMutableDictionary new];
        NSArray *keys = [dict allKeys];
        for(NSString *key in keys) {
            NSDictionary *dayDict = dict[key];
            DaySchedule *daySchedule = [[DaySchedule alloc] initWithDictionary:dayDict];
            self.scheduleDictionaries[key] = daySchedule;
        }
    }
    return self;
}

- (DaySchedule *)scheduleForDay:(NSString *)day {
    return self.scheduleDictionaries[day];
}

#pragma mark - API Calls

+ (void)getCurrentScheduleNameOnCompletion:(void (^)(NSString *name, NSError *error))success {
    [[APIClient sharedClient] GET:@"/schedule" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Schedule: %@", responseObject);
        success(@"", nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(nil, error);
    }];
}

+ (void)getWeekScheduleWithName:(NSString *)name completion:(void (^)(WeekSchedule *weekSchedule, NSError *error))success {
    [[APIClient sharedClient] GET:[NSString stringWithFormat:@"/schedules/%@", name] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Schedules: %@", responseObject);
        WeekSchedule *weekSchedule = [[WeekSchedule alloc] initWithDictionary:responseObject];
        success(weekSchedule, nil); // Updated when the call is updated
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(nil, error);
    }];
}

@end
