//
//  Temperature.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Temperature : NSObject

+ (NSString *)formattedTextWithTemperature:(CGFloat)temperature;
+ (void)getTemperatureOnCompletion:(void (^)(CGFloat temperature, NSError *error))success;
+ (void)getOverrideOnCompletion:(void (^)(CGFloat temperature, NSError *error))success;
+ (void)postNewValue:(CGFloat)value completion:(void (^)(NSError *error))success;

@property (nonatomic) NSInteger value;

@end
