//
//  NewsService.m
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import "ParseFeed.h"

@interface ParseFeed ()

@property (nonatomic, strong) NSString *fileName;

@end


@implementation ParseFeed

- (instancetype) initWithFileName:(NSString *)jsonFileName {
    self = [super init];
    if (self) {
        self.fileName = jsonFileName;
    }
    return self;
}

- (NSArray<Feed *> *)loadNewsFromJSONFile {
    NSMutableArray<Feed *> *newsFeeds = [NSMutableArray array];
    @try {
        // Load news from the JSON file
        NSString *filePath = [[NSBundle mainBundle] pathForResource:self.fileName ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        if (data) {
            NSError *error;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error) {
                NSLog(@"Error parsing JSON: %@", error.localizedDescription);
                return newsFeeds; // Return empty array on error
            }
            
            NSArray *articles = jsonDict[@"articles"];
            
            for (NSDictionary *articleDict in articles) {
                NSString *title = articleDict[@"title"];
                NSString *publishedDateString = articleDict[@"publishedAt"];
                NSString *imageURLString = articleDict[@"urlToImage"];
                NSString *contentURLString = articleDict[@"url"];
                
                // Convert published date string to NSDate
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
                NSDate *publishedDate = [dateFormatter dateFromString:publishedDateString];
                
                // Create NewsFeed object
                Feed *newsFeed = [[Feed alloc] initWithTitle:title imageURL:imageURLString contentURL:contentURLString publishedDate:publishedDate];
                // Added a failsafe here
                if (newsFeed != nil) {
                    [newsFeeds addObject:newsFeed];
                }
            }
        } else {
            NSLog(@"Failed to load data");
        }
    } @catch (NSException *exception) {
        NSLog(@"Exception loading news: %@", exception.reason);
    } @finally {
        // Sorting items by dates
        [newsFeeds sortUsingComparator:^NSComparisonResult(Feed *obj1, Feed *obj2) {
            return [obj2.publishedDate compare:obj1.publishedDate];
        }];
        
        return newsFeeds;
    }
}

@end
