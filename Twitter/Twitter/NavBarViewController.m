//
//  NavBarViewController.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/14/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "NavBarViewController.h"
#import "TimelineViewController.h"
#import "MenuViewController.h"
#import "ComposeViewController.h"

@interface NavBarViewController ()

@property (nonatomic, strong) TimelineViewController *timelineVC;
@property (nonatomic, strong) MenuViewController *menuVC;

@end

@implementation NavBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.timelineVC = [[TimelineViewController alloc] init];
//        self.menuVC = [[MenuViewController alloc] init];
//        
//        self.timelineVC.signout_delegate = self.signout_delegate;
//        self.menuVC.signout_delegate = self.signout_delegate;
        self.menuShowing = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self addMenuView];
//    [self addTimeline];
//    [self addMenuView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushNewButton:(id)sender {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    [self presentViewController:cvc animated:YES completion:nil];
}

- (IBAction)pushBurgerButton:(id)sender {
    // Slide the top (nav+content) view over to the menuVC's "contentView" frame
    if (! self.menuShowing) {
        [self.mainView showMenu];
        self.menuShowing = YES;
//        self.view.userInteractionEnabled = NO;
    } else {
        [self.mainView hideMenu];
        self.menuShowing = NO;
        // hide menu?
    }
}

//- (void)addMenuView {
//    [self addChildViewController:self.menuVC];
//    // This is not needed in this case, but we do need it to nil on remove
//    [self.menuVC willMoveToParentViewController:self];
//    [self.view insertSubview:self.menuVC.view belowSubview:self.fullView];
//    [self.menuVC didMoveToParentViewController:self];
////    [UIView animateWithDuration:2.0 animations:
////     ^{
////         [self.view addSubview:self.menuVC.view];
////     } completion:^(BOOL finished) {
////         [self.menuVC didMoveToParentViewController:self];
////     }];
//    
//}
//
//- (void)addTimeline {
//    self.timelineVC.view.frame = self.contentView.frame;
//    [self addChildViewController:self.timelineVC];
//    // This is not needed in this case, but we do need it to nil on remove
//    [self.timelineVC willMoveToParentViewController:self];
//    [self.view addSubview:self.timelineVC.view];
//    [self.timelineVC didMoveToParentViewController:self];
//}
@end
