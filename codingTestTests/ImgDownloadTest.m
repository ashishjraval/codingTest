//
//  ImgDownloadTest.m
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import <XCTest/XCTest.h>
#import "ImgDownlod.h"

@interface ImgDownloadTest : XCTestCase

@end

@implementation ImgDownloadTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [ImgDownlod clearCache]; // Clear the cache after executing the test
}

- (void)testImageDownload {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *expectation = [self expectationWithDescription:@"Image download"];

        NSURL *testImageURL = [NSURL URLWithString:@"https://s.yimg.com/ny/api/res/1.2/n6iLNJ_9dtK.fT6WAXK1sA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD03OTU-/https://s.yimg.com/os/creatr-uploaded-images/2024-01/3edf5140-afdd-11ee-bf7c-7918e1b9d963"];
    
        [ImgDownlod downloadImageWithURL:testImageURL completion:^(UIImage *image) {
            XCTAssertNotNil(image, @"Image should not be nil");
            [expectation fulfill];
        }];
        
        [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
            if (error) {
                XCTFail(@"Timeout error: %@", error);
            }
        }];
}

- (void)testImageCache {
    // Test caching functionality
    XCTestExpectation *expectation = [self expectationWithDescription:@"Image download"];
    
        NSURL *testImageURL = [NSURL URLWithString:@"https://s.yimg.com/ny/api/res/1.2/n6iLNJ_9dtK.fT6WAXK1sA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD03OTU-/https://s.yimg.com/os/creatr-uploaded-images/2024-01/3edf5140-afdd-11ee-bf7c-7918e1b9d963"];
        
        [ImgDownlod downloadImageWithURL:testImageURL completion:^(UIImage *image) {
            XCTAssertNotNil(image, @"Image should not be nil");
            [expectation fulfill];
            
            // Get the img from cache
            UIImage *cachedImage = [ImgDownlod cachedImageForURL:testImageURL];
            
            // Check if cached image matches the original image
            XCTAssertEqualObjects(cachedImage, image, @"Cached image should match original image");
            
        }];
        
        [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
            if (error) {
                XCTFail(@"Timeout error: %@", error);
            }
        }];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
