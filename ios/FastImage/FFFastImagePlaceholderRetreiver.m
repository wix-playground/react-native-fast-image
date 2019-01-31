//
//  FFFastImagePlaceholderRetreiver.m
//  FastImage
//
//  Created by Roi Berlin on 31/01/2019.
//  Copyright © 2019 vovkasm. All rights reserved.
//

#import "FFFastImagePlaceholderRetreiver.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation FFFastImagePlaceholderRetreiver

+(UIImage* ) retreivePlaceholderImageFromURL:(NSURL*) url
{
    if (url == nil)
    {
        return nil;
    }
    
    UIImage *cachedImage = [self getStoredInCachePlaceholderImageIfFound:url];
    if (cachedImage != nil)
    {
        return cachedImage;
    }
    
    UIImage *newImage = [self retreiveNewFile:url];
    if (newImage != nil)
    {
        [self cacheImage:newImage forURL:url];
    }
    
    return newImage;
}

+(UIImage*) getStoredInCachePlaceholderImageIfFound:(NSURL*) url
{
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    UIImage *lastPreviousCachedImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
    
    return lastPreviousCachedImage;
}

+(UIImage*) retreiveNewFile:(NSURL*) url
{
    NSData* data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];
}

+(void) cacheImage:(UIImage*) image forURL:(NSURL*) url
{
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    [[SDImageCache sharedImageCache] storeImage:image forKey:key completion:^(void){}];
}

@end
