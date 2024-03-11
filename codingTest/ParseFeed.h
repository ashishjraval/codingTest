//
//  ParseFeed.h
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseFeed : NSObject

- (instancetype) initWithFileName:(NSString *)jsonFileName;

- (NSArray<Feed *> *)loadNewsFromJSONFile;

@end

NS_ASSUME_NONNULL_END
