//
//  ScheduleTimeCell.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const SchedulerTimeCellIdentifier;

@interface ScheduleTimeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end
