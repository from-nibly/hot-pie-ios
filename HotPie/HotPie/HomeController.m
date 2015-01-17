//
//  MenuControllerViewController.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "HomeController.h"
#import "LabelSwipeControl.h"
#import "Temperature.h"
#import "WeekSchedule.h"
#import "WeekSchedulerController.h"

@interface HomeController () <LabelSwipeControlDelegate>

@property (strong, nonatomic) NSTimer *updateTimer;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBarButtonItem;
@property (strong, nonatomic) LabelSwipeControl *labelSwipeControl; // Used to set the temperature after it's hooked up to a label

@end

@implementation HomeController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.1f target:self selector:@selector(updateTemperature:) userInfo:nil repeats:YES];
    self.labelSwipeControl = [[LabelSwipeControl alloc] initWithUILabel:self.temperatureLabel value:72];
    self.labelSwipeControl.delegate = self;
    [Temperature getOverrideOnCompletion:^(CGFloat temperature, NSError *error) {
        self.labelSwipeControl.value = temperature; // This will set the temperatureLabel's text
    }];
    [self setup];
}

#pragma mark - Memory Management
    
- (void)dealloc {
    self.labelSwipeControl = nil;
    for(UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:recognizer];
    }
}

#pragma mark - Setup

- (void)setup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    revealViewController.rearViewRevealWidth = [[UIScreen mainScreen] bounds].size.width / 2;
    if ( revealViewController )
    {
        [self.menuBarButtonItem setTarget: self.revealViewController];
        [self.menuBarButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

#pragma mark - IBActions

- (IBAction)schedulePressed:(UIBarButtonItem *)sender {
    [WeekSchedule getWeekScheduleWithName:@"default" completion:^(WeekSchedule *weekSchedule, NSError *error) {
        [self performSegueWithIdentifier:@"modalWeekScheduler" sender:weekSchedule];
    }];
}
    
#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navController = segue.destinationViewController;
    UIViewController *viewController = nil;
    if([navController isKindOfClass:[UINavigationController class]]) {
        viewController = [navController.viewControllers firstObject];
    } else {
        viewController = segue.destinationViewController;
    }
    if([viewController isKindOfClass:[WeekSchedulerController class]]) {
        WeekSchedulerController *weekSchedulerController = (WeekSchedulerController *)viewController;
        weekSchedulerController.weekSchedule = sender;
    }
}

#pragma Network Calls

// TODO: Possibly replace with MQTT. The timer to update the temperature is for demo purposes.
- (void)updateTemperature:(NSTimer *)timer {
    [Temperature getTemperatureOnCompletion:^(CGFloat temperature, NSError *error) {
        self.currentTemperatureLabel.text = [NSString stringWithFormat:@" %@", [Temperature formattedTextWithTemperature:temperature]];
    }];
    if(!self.labelSwipeControl.inUse) { // Don't updated it if we're in the middle of editing it
        [Temperature getOverrideOnCompletion:^(CGFloat temperature, NSError *error) {
            self.labelSwipeControl.value = temperature; // This will set the temperatureLabel's text
        }];
    }
}

#pragma LabelSwipeControl Delegate

- (void)didFinishSwipeWithLabelSwipeControl:(LabelSwipeControl *)labelSwipeControl {
    NSLog(@"Value: %@", @(labelSwipeControl.value));
    [Temperature postNewValue:labelSwipeControl.value completion:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
