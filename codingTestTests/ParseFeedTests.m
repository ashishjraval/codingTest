//
//  ParseFeedTests.m
//  codingTest
//
//  Created by Ashish Raval on 11/03/24.
//

#import <XCTest/XCTest.h>
#import "ParseFeed.h"
#import "Feed.h"

@interface NewsServiceTests : XCTestCase

@property (nonatomic, strong) ParseFeed *newsService;
@property (nonatomic, strong) ParseFeed *newsServiceWithInvalidJSON;

@end

@implementation NewsServiceTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.newsService = [[ParseFeed alloc] initWithFileName:@"validFeed"];
    self.newsServiceWithInvalidJSON = [[ParseFeed alloc] initWithFileName:@"invalidFeed"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.newsService = nil;
    self.newsServiceWithInvalidJSON = nil;
}

- (void)testLoadNewsFromJSONFile {
    @try {
        NSArray<Feed *> *newsFeeds = [self.newsService loadNewsFromJSONFile];
        XCTAssertNotNil(newsFeeds, @"Feed items should not be nil");
        XCTAssertGreaterThan(newsFeeds.count, 0, @"Feed items count should be greater than 0");
        
        // Check if news items are correctly loaded
        Feed *firstItem = [newsFeeds firstObject];
        XCTAssertNotNil(firstItem.title, @"Feed item title should not be nil");
        XCTAssertNotNil(firstItem.publishedDate, @"Feed item published date should not be nil");
        XCTAssertNotNil(firstItem.imageURL, @"Feed item image URL should not be nil");
    } @catch (NSException *exception) {
        XCTFail(@"Exception Error occurred: %@", exception);
    }
}

- (void)testLoadNewsFromInvalidJSONFile {
    @try {
        NSArray<Feed *> *newsFeeds = [self.newsServiceWithInvalidJSON loadNewsFromJSONFile];
        XCTAssertNotNil(newsFeeds, @"Feed items should not be nil");
        XCTAssertEqual(newsFeeds.count, 0, @"Feed items count should be zero");
    } @catch (NSException *exception) {
        XCTFail(@"Exception Error occurred: %@", exception);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
