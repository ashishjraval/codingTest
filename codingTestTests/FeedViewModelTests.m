//
//  FeedViewModelTests.m
//  codingTest
//
//  Created by Ashish Raval on 11/03/24.
//

#import <XCTest/XCTest.h>
#import "FeedViewModel.h"
#import "Feed.h"

@interface FeedViewModelTests : XCTestCase<FeedViewModelDelegate>

@property (nonatomic, strong) XCTestExpectation *expectation;
@property (nonatomic, strong) FeedViewModel *viewModel;

@end

@implementation FeedViewModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    ParseFeed *newsService = [[ParseFeed alloc] initWithFileName:@"validFeed"];
    self.viewModel = [[FeedViewModel alloc] initWithService:newsService delegate:self];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewModel = nil;
}



- (void)testFetchNews {
    self.expectation = [self expectationWithDescription:@"Fetching Feed"];
    [self.viewModel fetchNews];
    
    // Wait for the expectation with a timeout
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
}

#pragma mark - NewsViewModelDelegate

- (void)didFetchNewsWithSuccess {
    NSArray<Feed *> *newsFeeds = [self.viewModel getNews];
    NSInteger newsFeedCount = [self.viewModel getNewsCount];
    XCTAssertNotNil(newsFeeds, @"News items should not be nil");
    XCTAssertGreaterThan(newsFeedCount, 0, @"News items count should be greater than 0");
    [self.expectation fulfill];
}

- (void)didFailWithError:(NSError *)error {
    XCTFail(@"Fetching news failed with error: %@", error.localizedDescription);
    [self.expectation fulfill];
}

@end
