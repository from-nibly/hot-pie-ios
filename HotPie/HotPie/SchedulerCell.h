//
//  SchedulerCellCollectionViewCell.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SchedulerCell;

@protocol SchedulerCellDelegate <NSObject>

- (UITableViewCell *)schedulerCell:(SchedulerCell *)schedulerCell tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)schedulerCell:(SchedulerCell *)schedulerCell tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

extern NSString *const SchedulerCellIdentifier;

@interface SchedulerCell : UICollectionViewCell
@property (nonatomic, weak) id <SchedulerCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (nonatomic) NSInteger itemCount;

@end
