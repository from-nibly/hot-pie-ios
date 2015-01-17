//
//  SchedulerCellCollectionViewCell.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "SchedulerCell.h"
#import "ScheduleTimeCell.h"

NSString *const SchedulerCellIdentifier = @"SchedulerCell";

@interface SchedulerCell() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SchedulerCell

- (void)awakeFromNib {
    [self.tableView registerNib:[UINib nibWithNibName:SchedulerTimeCellIdentifier bundle:nil] forCellReuseIdentifier:SchedulerTimeCellIdentifier];
}

- (void)prepareForReuse {
    self.tableView.contentOffset = CGPointZero;
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemCount;
}

// TODO: Look in to pulling the tableview handlnig out of the cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.delegate && [self.delegate respondsToSelector:@selector(schedulerCell:tableView:cellForRowAtIndexPath:)]) {
        return [self.delegate schedulerCell:self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.delegate && [self.delegate respondsToSelector:@selector(schedulerCell:tableView:willSelectRowAtIndexPath:)]) {
        return [self.delegate schedulerCell:self tableView:self.tableView willSelectRowAtIndexPath:indexPath];
    }
    return nil;
}

@end
