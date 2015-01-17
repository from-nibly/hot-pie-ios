//
//  MenuController.m
//  HotPie
//
//  Created by Michael Daniels on 1/17/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "MenuController.h"
#import "WeekSchedule.h"

NSString * const MCVacationMode = @"Vacation Mode";

@interface MenuController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuItems = @[MCVacationMode];
}

#pragma mark - TableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

// TODO: Look in to pulling the tableview handlnig out of the cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.menuItems[indexPath.row];
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellTitleSelected = self.menuItems[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([cellTitleSelected isEqualToString:MCVacationMode]) {
        [WeekSchedule switchToScheduleWithName:@"vacation" completion:nil];
    }
}

@end
