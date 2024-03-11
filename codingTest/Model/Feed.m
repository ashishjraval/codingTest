//
//  Feed.m
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

@implementation Feed

- (instancetype)initWithTitle:(NSString *)title imageURL:(NSString *)imageURL contentURL:(NSString *)contentURL publishedDate:(NSDate *)publishedDate {
    self = [super init];
    if (self) {
        if ([self validateNewsWithTitle:title imageURL:imageURL contentURL:contentURL publishedDate:publishedDate]) {
            self.title = title;
            self.imageURL = imageURL;
            self.contentURL = contentURL;
            self.publishedDate = publishedDate;
        } else {
            return nil;
        }
    }
    return self;
}

- (Boolean)validateNewsWithTitle:(NSString *)title imageURL:(NSString *)imageURL contentURL:(NSString *)contentURL publishedDate:(NSDate *)publishedDate {
    if (![self isValidNewsTitle:title]) {
        NSLog(@"Invalid Title");
        return false;
    }
    if (![self isValidImageUrl:imageURL]) {
        NSLog(@"Invalid Image Url");
        return false;
    }
    if (![self isValidContentUrl:contentURL]) {
        NSLog(@"Invalid Content Url");
        return false;
    }
    if (![self isValidPublishedDate:publishedDate]) {
        NSLog(@"Invalid Published Date");
        return false;
    }
    return true;
}

- (Boolean)isValidNewsTitle:(NSString *)title {
    return !(title == nil || [title isEqualToString:@""]);
}

- (Boolean)isValidImageUrl:(NSString *)imageURL {
    return !(imageURL == nil || [imageURL isEqualToString:@""]);
}

- (Boolean)isValidContentUrl:(NSString *)contentURL {
    return !(contentURL == nil || [contentURL isEqualToString:@""]);
}

- (Boolean)isValidPublishedDate:(NSDate *)publishedDate {
    return (publishedDate != nil);
}

@end
