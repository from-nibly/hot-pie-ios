//
//  PopupController.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "PopupController.h"
#import "TouchWindow.h"

static UIViewController *currentViewController = nil; // Holds the current popup

@interface PopupController () <TouchWindowDelegate>

@property(nonatomic, strong) TouchWindow *window;
@property(nonatomic) BOOL displayed;

@end

@implementation PopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.cornerRadius = 10;
    self.view.layer.borderColor = [[UIColor blackColor] CGColor];
    self.view.layer.borderWidth = 1;
}

#pragma mark - Inherited methods

+ (NSString *)controllerName {
    // Implemented by child view controller
    return nil;
}

+ (CGSize)viewSize {
    return CGSizeMake(300, 300); // Default, should be implemented by child view controller
}

#pragma mark - Public Methods

+ (PopupController *)popupController
{
    if(![self controllerName]) {
        return nil; // Can't show a popup if no controller name is defined.
    }
    if(currentViewController) {
        NSLog(@"Tried to display multiple popups");
        return nil; // Can't display mutliple popups at the same time
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Popup" bundle:nil];
    PopupController *viewController = [storyBoard instantiateViewControllerWithIdentifier:[self controllerName]];
    currentViewController = viewController;
    TouchWindow *window = [[TouchWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.touchDelegate = viewController;
    viewController.displayed = YES;
    viewController.window = window;
    viewController.window.windowLevel = UIWindowLevelAlert + 1;
    viewController.window.backgroundColor = [UIColor clearColor];
    CGRect frame;
    frame.size = [self viewSize];
    frame.origin = CGPointMake([UIScreen mainScreen].bounds.size.width / 2 - frame.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2 - frame.size.height / 2);
    viewController.view.frame = frame;
    viewController.view.alpha = 0.0f;
    return viewController;
}

- (void)show {
    [self.window addSubview:self.view];
    [self.window makeKeyAndVisible];
    [UIView animateWithDuration:0.25f animations:^{
        self.view.alpha = 1.0f;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"test");
}

- (void)dismiss {
    if(!self.displayed) {
        return; // Don't try and dismiss multiple times
    }
    currentViewController = nil;
    self.displayed = NO;
    [UIView animateWithDuration:0.25f animations:^{
        self.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self.window removeFromSuperview];
    }];
}

#pragma mark - TouchWindow Delegate

- (void)touchWindow:(TouchWindow *)window touchedPoint:(CGPoint)point {
    if(!CGRectContainsPoint(self.view.frame, point)) {
        [self dismiss];
    }
}

@end
