//
//  MainViewController.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/16/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "MainViewController.h"
#import "NavBarViewController.h"
#import "TimelineViewController.h"
#import "MenuViewController.h"

#define REVEAL_DURATION 0.8

@interface MainViewController ()

@property (nonatomic, strong) TimelineViewController *timelineVC;
@property (nonatomic, strong) MenuViewController *menuVC;
@property (nonatomic, strong) NavBarViewController *navbarVC;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.timelineVC = [[TimelineViewController alloc] init];
        self.menuVC = [[MenuViewController alloc] init];
        self.navbarVC = [[NavBarViewController alloc] init];
        
        self.timelineVC.signout_delegate = self.signout_delegate;
        self.menuVC.signout_delegate = self.signout_delegate;
        
        self.navbarVC.mainView = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addMenuView];
    [self addNavView];
    [self addTimelineView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNavView {
    [self addChildViewController:self.navbarVC];
    // This is not needed in this case, but we do need it to nil on remove
    [self.navbarVC willMoveToParentViewController:self];
    [self.view addSubview:self.navbarVC.view];
    [self.navbarVC didMoveToParentViewController:self];
}
    
- (void)addMenuView {
    [self addChildViewController:self.menuVC];
    // This is not needed in this case, but we do need it to nil on remove
    [self.menuVC willMoveToParentViewController:self];
    [self.view addSubview:self.menuVC.view];
    [self.menuVC didMoveToParentViewController:self];
    //    [UIView animateWithDuration:2.0 animations:
    //     ^{
    //         [self.view addSubview:self.menuVC.view];
    //     } completion:^(BOOL finished) {
    //         [self.menuVC didMoveToParentViewController:self];
    //     }];
    
}

- (void)addTimelineView {
    self.timelineVC.view.frame = self.contentView.frame;
    [self addChildViewController:self.timelineVC];
    // This is not needed in this case, but we do need it to nil on remove
    [self.timelineVC willMoveToParentViewController:self];
    [self.view addSubview:self.timelineVC.view];
    [self.timelineVC didMoveToParentViewController:self];
}

- (void)showMenu {
    [UIView animateWithDuration:REVEAL_DURATION animations:
     ^{
         // I am not sure why this doesn't work....
         // self.fullView.frame = self.menuVC.contentView.frame;
         // So we'll try moving both views...
         // I'm glad I figured this out once, because I'm not sure I'd do it again.  Math SCARY! :)
         // This seems terribly kludgey, I'm sure I'm missing some awesome here.
         // NSLog(@"nav height = %f", self.navView.frame.size.height);
         self.navbarVC.view.frame =
         CGRectMake(self.menuVC.contentView.frame.origin.x,
                    self.menuVC.contentView.frame.origin.y,
                    self.navView.frame.size.width,
                    self.navView.frame.size.height);
         
         self.timelineVC.view.frame =
         CGRectMake(self.menuVC.contentView.frame.origin.x,
                    (self.menuVC.contentView.frame.origin.y +
                     self.navView.frame.size.height),
                    self.menuVC.contentView.frame.size.width,
                    self.menuVC.contentView.frame.size.height);
     } completion:^(BOOL finished) {
         // Nada?
     }];
}

- (void)hideMenu {
    [UIView animateWithDuration:REVEAL_DURATION animations:
     ^{
         NSLog(@"nav height = %f", self.navView.frame.size.height);
         self.navbarVC.view.frame =
         CGRectMake(self.navView.frame.origin.x,
                    self.navView.frame.origin.y,
                    self.navView.frame.size.width,
                    self.navView.frame.size.height);

         
         self.timelineVC.view.frame =
         CGRectMake(self.contentView.frame.origin.x,
                    self.contentView.frame.origin.y,
                    self.contentView.frame.size.width,
                    self.contentView.frame.size.height);
     } completion:^(BOOL finished) {
         // Nada?
     }];
}
- (IBAction)onPanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint touch = [panGestureRecognizer locationInView:self.view];
    
    
    
}
@end
