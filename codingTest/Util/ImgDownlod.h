//
//  ImgDownlod.h
//  codingTest
//
//  Created by Ashish Raval on 10/03/24.
//

#import <UIKit/UIKit.h>

@interface ImgDownlod : NSObject

+ (void)downloadImageWithURL:(NSURL *)url completion:(void (^)(UIImage *image))completion;
+ (void)clearCache;
+ (UIImage *)cachedImageForURL:(NSURL *)url;

@end

