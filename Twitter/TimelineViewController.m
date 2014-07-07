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

#import "EGORefreshTableHeaderView.h"


@interface TimelineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UIRefreshControl *refreshControl;

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
        self.title = @"Home";
        UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Sign Out"
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(pushSignOutButton)];
        
        UIBarButtonItem *newButton = [[UIBarButtonItem alloc]
                                        initWithTitle:@"New"
                                        style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(pushNewButton)];
        
        self.navigationItem.leftBarButtonItem = signOutButton;
        self.navigationItem.rightBarButtonItem = newButton;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    self.tableView.rowHeight = 145;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushSignOutButton {
    // stub
}

- (void)pushNewButton {
    [self.navigationController pushViewController:[[ComposeViewController alloc] init] animated:YES];
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
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.businesses.count;
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"cell for row at index path: %d", indexPath.row);
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];

    cell.replyImage.image = [UIImage imageNamed:@"Reply"];
    cell.retweetImage.image = [UIImage imageNamed:@"Retweet"];
    cell.favoriteImage.image = [UIImage imageNamed:@"Favorite"];
    
    [cell.tweetContentsLabel sizeToFit];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self searchBarCancelButtonClicked:self.searchBar];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Here we would pass selected tweet info
    // self.tweet = foo;
    TweetViewController *tvc = [[TweetViewController alloc] init];
    
    [self.navigationController pushViewController:tvc animated:YES];
    
    
}


- (void)loadData {
    // load some data YO
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
