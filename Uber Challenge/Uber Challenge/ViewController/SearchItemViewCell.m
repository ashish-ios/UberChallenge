//
//  SearchItemViewCell.m
//  Uber Challenge
//
//  Created by Ashish on 14/08/18.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SearchItemViewCell.h"
#import "UCPhoto.h"
#import "UCServerCallsManager.h"

@implementation SearchItemViewCell

- (void)populateCellWithPhoto:(UCPhoto *)photo {
    self.imgImage.image = nil;
    [UCServerCallsManager imageDownload:[photo photoURLString]
                        completionBlock:^(NSData *data) {
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                self.imgImage.image = [[UIImage alloc] initWithData:data];
                            });
    }];
}

@end
