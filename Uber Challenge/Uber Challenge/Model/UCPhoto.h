//
//  UCPhoto.h
//  Uber Challenge
//
//  Created by Ashish on 15/08/18.
//  Copyright © 2018 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCPhoto : NSObject

@property (strong, nonatomic) NSString * photoId;
@property (strong, nonatomic) NSString * owner;
@property (strong, nonatomic) NSString * secret;
@property (strong, nonatomic) NSString * server;
@property (strong, nonatomic) NSString * title;

@property (strong, nonatomic) NSNumber * farm;
@property (strong, nonatomic) NSNumber * ispublic;
@property (strong, nonatomic) NSNumber * isfriend;
@property (strong, nonatomic) NSNumber * isfamily;

- (instancetype)initWithDict:(NSDictionary *)response;
- (NSString *)photoURLString;

@end
