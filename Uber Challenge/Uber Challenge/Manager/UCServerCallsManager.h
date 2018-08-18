//
//  UCServerCallsManager.h
//  Uber Challenge
//
//  Created by Ashish on 15/08/18.
//  Copyright © 2018 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 API Documentation
 
 API: https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=daf692bbf1d90eaacee1c1ef3395dad5&text=cars&per_page=20&page=1&format=json&nojsoncallback=1

 API Method: GET
 text: <item to serach>
 per_page: <number of items per page>
 page: <page number>
 format:<json>
 */

#define REST_API @"https://api.flickr.com/services/rest/"
#define API_KEY @"3da4f2c9803ecff50ace1d70cdd9574e"
#define NUMBER_ROWS 10

@class UCPhotos;
@interface UCServerCallsManager : NSObject

- (void)searchForItem:(NSString *)itemName
           pageNumber:(NSInteger)pageNumber
      completionBlock:(void(^)(NSDictionary *dictionary, UCPhotos *photos, NSError *error))block;

+ (void)imageDownload:(NSString *)urlString
      completionBlock:(void(^)(NSData *data))block;

@end
