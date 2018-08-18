//
//  UCPhotos.m
//  Uber Challenge
//
//  Created by Ashish on 15/08/18.
//  Copyright © 2018 Uber. All rights reserved.
//

/*
 Example JSON for future referance
 {
    "photos": {
        "page": 1,
        "pages": 636073,
        "perpage": 1,
 
        "total": "636073",
 
        "photo": [<Photo Details>] // Refer UCPhoto.m
    },
    "stat": "ok"
 }
 
 */

#import "UCPhotos.h"

@implementation UCPhotos
- (instancetype)initWithDict:(NSDictionary *)response {
    if (self = [super init]) {
        if ([response valueForKey:@"photos"]) {
            NSDictionary * dictPhotos = [response valueForKey:@"photos"];

            if ([dictPhotos valueForKey:@"page"]) {
                self.currentPage = [NSNumber numberWithInteger:[[dictPhotos valueForKey:@"page"] integerValue]];
            }

            if ([dictPhotos valueForKey:@"pages"]) {
                self.pages = [NSNumber numberWithInteger:[[dictPhotos valueForKey:@"pages"] integerValue]];
            }

            if ([dictPhotos valueForKey:@"total"]) {
                self.total = [NSNumber numberWithInteger:[[dictPhotos valueForKey:@"total"] integerValue]];
            }

            if ([dictPhotos valueForKey:@"photo"]) {
                NSMutableArray * marray = [NSMutableArray array];
                for (NSDictionary * dictPhoto in [dictPhotos objectForKey:@"photo"]) {
                    UCPhoto * photo = [[UCPhoto alloc] initWithDict:dictPhoto];
                    [marray addObject:photo];
                }
                self.arrPhotos = [NSArray arrayWithArray:marray];
            }
        }
    }
    return self;
}

- (NSInteger)nextPage {
    if (self.currentPage.integerValue < self.pages.integerValue) {
        return self.currentPage.integerValue + 1;
    }
    return self.currentPage.integerValue;
}

@end
