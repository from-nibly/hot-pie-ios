//
//  ViewController.m
//  HotPie
//
//  Created by Michael Daniels on 1/15/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "DaySchedule.h"
#import "SchedulerCell.h"
#import "ScheduleTimeCell.h"
#import "Temperature.h"
#import "TempatureSettingsController.h"
#import "TimeRangeSchedule.h"
#import "WeekSchedulerController.h"

@interface WeekSchedulerController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SchedulerCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *days;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) BOOL scrolling;

@end

@implementation WeekSchedulerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.days = @[@"sunday", @"monday", @"tuesday", @"wednesday", @"thursday", @"friday", @"saturday"];
    [self.collectionView registerNib:[UINib nibWithNibName:SchedulerCellIdentifier bundle:nil] forCellWithReuseIdentifier:SchedulerCellIdentifier];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)dismissPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.days.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SchedulerCell *cell = (SchedulerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:SchedulerCellIdentifier forIndexPath:indexPath];
    cell.dayLabel.text = [self.days[indexPath.row] capitalizedString];
    [cell.tableView reloadData];
    cell.delegate = self;
    cell.itemCount = 24;
    return cell;
}

#pragma mark UICollectionView Delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, collectionView.frame.size.height);
}

// The tableview is on the SchedulerCell. Part of the tableview methods are being passed to this class from the SchedulerCell through delegate methods.
#pragma mark - SchedulerCell Delegate

-(UITableViewCell *)schedulerCell:(SchedulerCell *)schedulerCell tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:SchedulerTimeCellIdentifier];
    NSInteger dayIndex = self.currentPage;//self.days.count - (self.collectionView.contentSize.width / (cell.frame.origin.x + cell.frame.size.width));
    NSString *dayString = self.days[dayIndex];
    NSString *period = indexPath.row < 11 || indexPath.row == 24 ? @"AM" : @"PM";
    NSInteger hour = indexPath.row % 12 + 1;
    NSString *hourString = [NSString stringWithFormat:@"%@", @(hour)];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@:00 %@", hourString, period];
    DaySchedule *daySchedule = [self.weekSchedule scheduleForDay:dayString];
    
    if(!self.scrolling) {
        TimeRangeSchedule *timeRange = [daySchedule timeRangeScheduleForHour:indexPath.row + 1]; // Use indexPath.row because the ranges are based of 1-24 instead of 1-12
        cell.temperatureLabel.text = [Temperature formattedTextWithTemperature:timeRange ? timeRange.temp : daySchedule.defaultValue];
        cell.backgroundColor = timeRange ? timeRange.color : [UIColor whiteColor];
    }
    return cell;
    
}

-(NSIndexPath *)schedulerCell:(SchedulerCell *)schedulerCell tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *currentIndexPath = [tableView indexPathForSelectedRow];
    if(currentIndexPath) {
        // Selected start and end indexPaths
        PopupController *tempatureSettingsController = [TempatureSettingsController popupController]; // TODO: setup delegate so we can send the info to the server
        [tempatureSettingsController show];
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
        return nil;
    }
    return indexPath;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrolling = YES;
    self.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.scrolling = NO;
    self.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentPage inSection:0]]];
}

@end
