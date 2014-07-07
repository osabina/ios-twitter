//
//  TimelineViewController.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"


@interface TimelineViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate> {
        EGORefreshTableHeaderView *_refreshHeaderView;
        BOOL _reloading;
}


- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
