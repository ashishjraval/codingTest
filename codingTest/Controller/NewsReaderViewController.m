//
//  ViewController.m
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import "NewsReaderViewController.h"
#import "Feed.h"
#import "FeedTableViewCell.h"
#import <SafariServices/SafariServices.h>

@interface NewsReaderViewController ()<SFSafariViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@end

@implementation NewsReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // News service is being injected here making it unit test friendly
    ParseFeed *newsService = [[ParseFeed alloc] initWithFileName:@"newReader"];
    self.feedviewmodel = [[FeedViewModel alloc] initWithService:newsService delegate:self];
    [self setupNewsTable];
    [self fetchNews];
}

- (void)fetchNews {
        // Show Activity Indicator
    [self.feedviewmodel fetchNews];
}

- (void)setupNewsTable {
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"FeedTableViewCell"];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedviewmodel getNewsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedTableViewCell" forIndexPath:indexPath];
    [cell configureCellWithNewsFeed:[self.feedviewmodel getNewsAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *contentUrl = [[NSURL alloc] initWithString: [self.feedviewmodel getNewsAtIndex:indexPath.row].contentURL];
    SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:contentUrl];
    svc.delegate = self;
    [self presentViewController:svc animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark - Safari View Delegate Delegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Search Bar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.feedviewmodel.searchPredicate = searchText;
    [self.tableView reloadData];
}

#pragma mark - NewsViewModelDelegate
- (void)didFailWithError:(NSError *)error {
        // hide activity indicator
    NSLog(@"Error fetching : %@", error.localizedDescription);
}

- (void)didFetchNewsWithSuccess {
        // hide activity indicator here
    [self.tableView reloadData];
}

@end
