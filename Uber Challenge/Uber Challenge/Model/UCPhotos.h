//
//  UCPhotos.h
//  Uber Challenge
//
//  Created by Ashish on 15/08/18.
//  Copyright © 2018 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCPhoto.h"

@interface UCPhotos : NSObject

@property (strong, nonatomic) NSString * itemName; //Currect page in display
@property (strong, nonatomic) NSNumber * currentPage; //Current page in display
@property (strong, nonatomic) NSNumber * pages; //Total number of pages exist
@property (strong, nonatomic) NSNumber * total; //Total number of records
@property (strong, nonatomic) NSArray <UCPhoto *> *arrPhotos; // Array of records

- (instancetype)initWithDict:(NSDictionary *)response;
- (NSInteger)nextPage;

@end
