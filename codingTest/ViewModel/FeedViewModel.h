//
//  FeedViewModel.h
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import <Foundation/Foundation.h>
#import "Feed.h"
#import "ParseFeed.h"

@class FeedViewModel;
@class NewFeed;

@protocol FeedViewModelDelegate <NSObject>

- (void)didFetchNewsWithSuccess;
- (void)didFailWithError:(NSError *)error;

@end

@interface FeedViewModel : NSObject

@property (nonatomic, strong) NSString *searchPredicate;
@property (nonatomic, weak) id<FeedViewModelDelegate> delegate;

// Dependency Injection
- (instancetype) initWithService:(ParseFeed *)service
                      delegate:(id<FeedViewModelDelegate>)delegate;

- (NSArray <Feed *> *)getNews;
- (Feed *)getNewsAtIndex:(NSInteger)index;
- (NSInteger)getNewsCount;
- (void)fetchNews;


@end
