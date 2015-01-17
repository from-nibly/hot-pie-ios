//
//  TempatureSettingsController.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "TempatureSettingsController.h"
#import "LabelSwipeControl.h"

@interface TempatureSettingsController ()

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) LabelSwipeControl *labelSwipeControl;

@end

@implementation TempatureSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelSwipeControl = [[LabelSwipeControl alloc] initWithUILabel:self.temperatureLabel value:72];
}

- (void)dealloc {
    self.labelSwipeControl = nil;
    for(UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:recognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *)controllerName {
    return @"TempatureSettingsController";
}

+ (CGSize)viewSize {
    return CGSizeMake(300, 300);
}

@end
