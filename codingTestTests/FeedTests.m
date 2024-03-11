//
//  FeedTests.m
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import <XCTest/XCTest.h>
#import "Feed.h"

@interface FeedTests : XCTestCase

@end

@implementation FeedTests

- (void)setUp {
        // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
}
- (void)testInitWithValidData {
    
    // Sample correct data
    NSString *title = @"SEC approves bitcoin ETFs (for real this time)";
    NSString *imageURLString = @"https://www.engadget.com/sec-approves-bitcoin-etfs-for-real-this-time-224125584.html";
    NSString *contentURLString = @"https://www.engadget.com/sec-approves-bitcoin-etfs-for-real-this-time-224125584.html";
    NSString *publishedDateString = @"2024-01-10T22:41:25Z";
    
    // Convert published date string to NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *publishedDate = [dateFormatter dateFromString:publishedDateString];
    
    // Create Feed object
    Feed *newsFeed = [[Feed alloc] initWithTitle:title imageURL:imageURLString contentURL:contentURLString publishedDate:publishedDate];
    
    XCTAssertNotNil(newsFeed,
                    @"Feed not be nil");
    
    XCTAssertEqualObjects(newsFeed.title,
                          title,
                          @"Match Title");
    
    XCTAssertEqualObjects(newsFeed.publishedDate,
                          publishedDate,
                          @"Match Date");
    
    XCTAssertEqualObjects(newsFeed.imageURL,
                          imageURLString,
                          @"Match URL");
    
    XCTAssertEqualObjects(newsFeed.contentURL,
                          contentURLString,
                          @"Match Content URL");
}

- (void)testInitWithEmptyTitle {
    // Sample correct data
    NSString *title = @"";
    NSString *imageURLString = @"https://www.engadget.com/sec-approves-bitcoin-etfs-for-real-this-time-224125584.html";
    NSString *contentURLString = @"https://www.engadget.com/sec-approves-bitcoin-etfs-for-real-this-time-224125584.html";
    NSString *publishedDateString = @"2024-01-10T22:41:25Z";
    
    // Convert published date string to NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *publishedDate = [dateFormatter dateFromString:publishedDateString];
    
    // Create Feed object
    Feed *newsFeed = [[Feed alloc] initWithTitle:title imageURL:imageURLString contentURL:contentURLString publishedDate:publishedDate];
    
    XCTAssertNil(newsFeed,
                    @"Feed should be nil");
}

- (void)testInitWithEmptyDate {
    // Sample correct data
    NSString *title = @"SEC approves bitcoin ETFs (for real this time)";
    NSString *imageURLString = @"https://www.engadget.com/sec-approves-bitcoin-etfs-for-real-this-time-224125584.html";
    NSString *contentURLString = @"https://www.engadget.com/sec-approves-bitcoin-etfs-for-real-this-time-224125584.html";
    NSString *publishedDateString = @"";
    
    // Convert date String to NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *publishedDate = [dateFormatter dateFromString:publishedDateString];
    
    
    Feed *newsFeed = [[Feed alloc] initWithTitle:title imageURL:imageURLString contentURL:contentURLString publishedDate:publishedDate];
    
    XCTAssertNil(newsFeed,
                    @"Feed should be nil");
}

- (void)testInitWithInvalidDate {
    // Sample correct data
    NSString *title = @"SEC approves bitcoin ETFs (for real this time)";
    NSString *imageURLString = @"https://www.engadget.com/sec-approves-bitcoin-etfs-for-real-this-time-224125584.html";
    NSString *contentURLString = @"https://www.engadget.com/sec-approves-bitcoin-etfs-for-real-this-time-224125584.html";
    NSString *publishedDateString = @"2024-01-10-Invalid-22:41:25Z";
    
    // Convert date String to NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *publishedDate = [dateFormatter dateFromString:publishedDateString];
    
    // Create Feed object
    Feed *newsFeed = [[Feed alloc] initWithTitle:title imageURL:imageURLString contentURL:contentURLString publishedDate:publishedDate];
    
    XCTAssertNil(newsFeed,
                    @"Feed should be nil");
}

@end
