//
//  TimelineViewController.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "TwitterCommon.h"
#import "TimelineViewController.h"

#import "ComposeViewController.h"
#import "TweetViewController.h"
#import "TweetCell.h"
#import "TwitterClient.h"
#import "Tweet.h"

#import "EGORefreshTableHeaderView.h"


@interface TimelineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) NSDictionary *userInfo;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) TweetCell *layoutCell;


- (void)pushSignOutButton;
- (void)pushNewButton;
- (void)setupNavBar;
- (void)loadData;

@end

@implementation TimelineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Do something...
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavBar];
    [self loadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];

    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];

    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // static, for now
    //self.tableView.rowHeight = 145;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushSignOutButton {
    [self.signout_delegate onSignOut];
}

- (void)pushNewButton {
    [self.navigationController pushViewController:[[ComposeViewController alloc] init] animated:YES];
}

- (void)pushBurgerButton {
    // stub - will bring out menu
    //    [self.navigationController pushViewController:[[ComposeViewController alloc] init] animated:YES];
}

- (void)setupNavBar {
    UINavigationBar *nb = self.navigationController.navigationBar;
    nb.tintColor = [UIColor whiteColor];
    nb.barTintColor = UIColorFromRGB(0x77b6e9);
    nb.barStyle = UIBarStyleBlack;
    
    id barButtonAppearance = [UIBarButtonItem appearance];
    NSMutableDictionary *barButtonTextAttributes = [NSMutableDictionary dictionaryWithCapacity:1];
    //    [barButtonTextAttributes setObject:[UIFont fontWithName:@"HelveticaNeue" size:14.0f] forKey:NSFontAttributeName];
    //    [barButtonTextAttributes setObject:[UIFont systemFontOfSize:13.0f] forKey:NSFontAttributeName];
    [barButtonTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName ];
    
    [barButtonAppearance setTitleTextAttributes:barButtonTextAttributes
                                       forState:UIControlStateNormal];
    [barButtonAppearance setTitleTextAttributes:barButtonTextAttributes
                                       forState:UIControlStateHighlighted];
  
    self.title = @"Home";
//    UIBarButtonItem *twitterButton = [[UIBarButtonItem alloc]
//                                      initWithImage:[UIImage imageNamed:@"Twitter"]
//                                      style:UIBarButtonItemStylePlain target:self
//                                      action:@selector(pushTwitterButton)];
//    twitterButton.enabled = NO;

    UIImageView *twitterIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Twitter"]];
    [twitterIV setTintColor: [UIColor whiteColor]];
    
    
    UIBarButtonItem *burgerButton =  [[UIBarButtonItem alloc]
                                      initWithImage:[UIImage imageNamed:@"Burger"]
                                      style:UIBarButtonItemStylePlain target:self
                                      action:@selector(pushBurgerButton)];

    UIBarButtonItem *newButton =  [[UIBarButtonItem alloc]
                                      initWithImage:[UIImage imageNamed:@"Quill"]
                                      style:UIBarButtonItemStylePlain target:self
                                      action:@selector(pushNewButton)];
    
    
//    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]
//                                      initWithTitle:@"Sign Out"
//                                      style:UIBarButtonItemStylePlain
//                                      target:self
//                                      action:@selector(pushSignOutButton)];
    
    
    self.navigationItem.leftBarButtonItem = burgerButton;
    self.navigationItem.rightBarButtonItem = newButton;
    self.navigationItem.titleView = twitterIV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"cell for row at index path: %d", indexPath.row);
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];

    cell.navController = self.navigationController; // hack?!?!?
    cell.userInfo = self.userInfo; // so much hack

    [cell setupWithTweet: self.tweets[indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self searchBarCancelButtonClicked:self.searchBar];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetViewController *tvc = [[TweetViewController alloc] init];
    tvc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:tvc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.layoutCell) {
        self.layoutCell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    }
    
    [self.layoutCell setupWithTweet: self.tweets[indexPath.row]];
    [self.layoutCell.bodyLabel sizeToFit];
    [self.layoutCell layoutIfNeeded];
    [self.layoutCell.canvasView sizeToFit];
    return self.layoutCell.canvasView.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}



- (void)loadData {
    [[TwitterClient instance] homeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tweets = [Tweet tweetsFromRawResponse:responseObject];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.navigationItem.prompt = @"Unable to fetch tweets";
        NSLog(@"Error getting home timeline: %@", error);
    }];

    if (self.userInfo == nil) {
        [[TwitterClient instance] getUserInfoWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.userInfo = responseObject;
            NSLog(@"%@", self.userInfo);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.navigationItem.prompt = @"Unable to fetch user profile";
            NSLog(@"Failed to get user info");
        }];
    }
}

// EGOTableViewPullRefresh
- (void)reloadTableViewDataSource{
    
    [self loadData];
    
}

- (void)doneLoadingTableViewData{
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading; // should return if data source model is reloading
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
    
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date]; // should return date data source was last changed
}

@end
