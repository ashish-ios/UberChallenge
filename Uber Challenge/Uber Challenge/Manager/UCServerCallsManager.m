//
//  UCServerCallsManager.m
//  Uber Challenge
//
//  Created by Ashish on 15/08/18.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "UCServerCallsManager.h"
#import "UCPhotos.h"

@implementation UCServerCallsManager

+ (void)serverAPICalls:(NSString *)urlString
     completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))block {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:nil
                                                     delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if (data) {
                                                            block(data, response, error);
                                                        }
                                                    }];
    [postDataTask resume];
}

+ (void)imageDownload:(NSString *)urlString
      completionBlock:(void(^)(NSData *data))block {
    [self serverAPICalls:urlString
       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           block(data);
    }];
}

- (void)searchForItem:(NSString *)itemName
           pageNumber:(NSInteger)pageNumber
      completionBlock:(void(^)(NSDictionary *dictionary, UCPhotos *photos, NSError *error))block {
    NSString * urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=%d&page=%ld&format=json&nojsoncallback=1",API_KEY,itemName,NUMBER_ROWS * 3,(long)pageNumber];
    [UCServerCallsManager serverAPICalls:urlString
                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                           if (error != nil) {
                               block(nil, nil, error);
                           } else {
                               NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableLeaves
                                                                                          error:nil];
                               if ([[jsonObject valueForKey:@"code"] integerValue] == 100) {
                                    block(jsonObject, nil, nil);
                               } else {
                                   UCPhotos * photos = [[UCPhotos alloc] initWithDict:jsonObject];
                                   photos.itemName = itemName;
                                   block(jsonObject, photos, nil);
                               }
                               
                           }
                       }];
}

@end
