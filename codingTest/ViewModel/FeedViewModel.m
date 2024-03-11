//
//  FeedViewModel.m
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import "FeedViewModel.h"

@interface FeedViewModel ()
@property (nonatomic, strong) ParseFeed *parseFeed;
@property (nonatomic, strong) NSArray<Feed *> *newsFeeds;
@end

@implementation FeedViewModel

- (instancetype) initWithService:(ParseFeed *)service
                      delegate:(id<FeedViewModelDelegate>)delegate {
    self = [super init];
    if (self) {
        self.parseFeed = service;
        self.delegate = delegate;
    }
    return self;
}

- (NSArray <Feed *> *)getNews {
    if (self.searchPredicate.length == 0) {
            return self.newsFeeds;
        } else {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@", self.searchPredicate];
            return [self.newsFeeds filteredArrayUsingPredicate:predicate];
        }
}

- (Feed *)getNewsAtIndex:(NSInteger)index {
    return [self getNews][index];
}

- (NSInteger)getNewsCount {
    return [self getNews].count;
}

- (void)fetchNews {
    self.newsFeeds = [self.parseFeed loadNewsFromJSONFile];
    
    if (self.newsFeeds.count > 0) {
        [self.delegate didFetchNewsWithSuccess];
    } else {
        NSError *error = [NSError errorWithDomain:@"com.codingTest" code:1001 userInfo:@{NSLocalizedDescriptionKey: @"No news found."}];
        [self.delegate didFailWithError:error];
    }
}




@end
