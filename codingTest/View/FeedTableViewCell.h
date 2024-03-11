//
//  FeedTableViewCell.h
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import <UIKit/UIKit.h>
#import "Feed.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *newsTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *newsImageView;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

- (void)configureCellWithNewsFeed:(Feed *)newsFeed;

@end

NS_ASSUME_NONNULL_END
