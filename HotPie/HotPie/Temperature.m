//
//  Temperature.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "Temperature.h"
#import "APIClient.h"

@implementation Temperature

+ (void)getTemperatureOnCompletion:(void (^)(CGFloat temperature, NSError *error))success {
    [[APIClient sharedClient] GET:@"/temp/current" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        success([responseObject[@"newValue"] floatValue], nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(0, error);
    }];
}

+ (void)getOverrideOnCompletion:(void (^)(CGFloat temperature, NSError *error))success {
    [[APIClient sharedClient] GET:@"/temp/override" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        success([responseObject[@"newValue"] floatValue], nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(0, error);
    }];
}

+ (void)postNewValue:(CGFloat)value completion:(void (^)(NSError *error))success {
    [[APIClient sharedClient] POST:[NSString stringWithFormat:@"/temp/override/%@", @(value)] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        success(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(error);
    }];
}

+ (NSString *)formattedTextWithTemperature:(CGFloat)temperature {
    return [NSString stringWithFormat:@"%@°", @(temperature)];
}

@end
