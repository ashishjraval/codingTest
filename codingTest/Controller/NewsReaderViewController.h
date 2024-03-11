//
//  ViewController.h
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import <UIKit/UIKit.h>
#import "FeedViewModel.h"

@interface NewsReaderViewController : UIViewController<FeedViewModelDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) FeedViewModel *feedviewmodel;

@end
