//
//  SearchItemViewCell.h
//  Uber Challenge
//
//  Created by Ashish on 14/08/18.
//  Copyright © 2018 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UCPhoto;

@interface SearchItemViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView * imgImage;
@property (assign, nonatomic) NSCache *cache;
- (void)populateCellWithPhoto:(UCPhoto *)photo;

@end
