//
//  UIImage+DispatchLoad.m
//  DreamChannel
//
//  Created by Slava on 3/28/11.
//  Copyright 2011 Alterplay. All rights reserved.
//

#import "UIImageView+DispatchLoad.h"

@implementation UIImageView (DispatchLoad)

- (void) setImageFromUrl:(NSString *)urlString {
    [self setImageFromUrl:urlString completion:NULL];
}

- (void) setImageFromUrl:(NSString*)urlString 
              completion:(void (^)(void))completion {
    
    self.image = nil;
    
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        

        UIImage *avatarImage = nil;
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        avatarImage = [UIImage imageWithData:responseData];

        
        if (avatarImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = avatarImage;
            });

        }
        else {
        }
	});
    
}

@end