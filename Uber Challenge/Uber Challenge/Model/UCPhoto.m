//
//  UCPhoto.m
//  Uber Challenge
//
//  Created by Ashish on 15/08/18.
//  Copyright © 2018 Uber. All rights reserved.
//

/*Example JSON for future referance
 {
    "id": "30178918428",
    "owner": "143412606@N02",
    "secret": "66bd5e9c78",
    "server": "1772",
    "title": "HOT WHEELS MONSTER JAM \"IRONMAN\" 12\/19 Recrushable Car (LW-11) https:\/\/t.co\/n7m7GBgj0g https:\/\/t.co\/1RmR7zOmGn",
 
 <void diff between string and number values>
 
    "farm": 2,
    "ispublic": 1,
    "isfriend": 0,
    "isfamily": 0
 }
 */

#import "UCPhoto.h"

@implementation UCPhoto

- (instancetype)initWithDict:(NSDictionary *)response {
    if (self = [super init]) {
        if ([response valueForKey:@"id"]) {
            self.photoId = [response valueForKey:@"id"];
        }

        if ([response valueForKey:@"owner"]) {
            self.owner = [response valueForKey:@"owner"];
        }

        if ([response valueForKey:@"secret"]) {
            self.secret = [response valueForKey:@"secret"];
        }

        if ([response valueForKey:@"server"]) {
            self.server = [response valueForKey:@"server"];
        }

        if ([response valueForKey:@"title"]) {
            self.title = [response valueForKey:@"title"];
        }

        if ([response valueForKey:@"farm"]) {
            self.farm = [NSNumber numberWithInteger:[[response valueForKey:@"farm"] integerValue]];
        }
        
        if ([response valueForKey:@"ispublic"]) {
            self.ispublic = [NSNumber numberWithBool:[[response valueForKey:@"ispublic"] boolValue]];
        }

        if ([response valueForKey:@"isfriend"]) {
            self.isfriend = [NSNumber numberWithBool:[[response valueForKey:@"isfriend"] boolValue]];
        }

        if ([response valueForKey:@"isfamily"]) {
            self.isfamily = [NSNumber numberWithBool:[[response valueForKey:@"isfamily"] boolValue]];
        }
    }
    return self;
}

//http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
- (NSString *)photoURLString {
    NSString * urlString = [NSString stringWithFormat:@"http://farm%ld.static.flickr.com/%@/%@_%@.jpg",(long)self.farm.integerValue,self.server,self.photoId,self.secret];
    return urlString;
}

@end
