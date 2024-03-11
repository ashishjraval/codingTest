//
//  FeedTableViewCell.h
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import "FeedTableViewCell.h"
#import "ImgDownlod.h"

@implementation FeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellWithNewsFeed:(nonnull Feed *)newsFeed {
    // Configure cell with news feeed data
    self.newsTitleLabel.text = newsFeed.title;
    self.dateLabel.text = [self formattedDateStringFromDate:newsFeed.publishedDate];
    
    self.newsImageView.image = nil;
    NSURL *url = [NSURL URLWithString:newsFeed.imageURL];
    UIImage *cachedImage = [ImgDownlod cachedImageForURL:url];
    if (cachedImage) {
        self.newsImageView.image = cachedImage;
    } else {
        [ImgDownlod downloadImageWithURL:url completion:^(UIImage *image) {
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.newsImageView.image = image;
                });
            }
        }];
    }
}

- (NSString *)formattedDateStringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy HH:mm"];
    return [formatter stringFromDate:date];
}

@end
