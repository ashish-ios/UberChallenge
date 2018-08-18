//
//  SerachListViewController.m
//  Uber Challenge
//
//  Created by Ashish on 10/08/18.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SerachListViewController.h"
#import "SearchItemViewCell.h"
#import "UCServerCallsManager.h"
#import "UCLoadingViewController.h"
#import "UCPhotos.h"
#import "UCCollectionReusableView.h"

@interface SerachListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate> {
    __weak IBOutlet UISearchBar *searchBar;
    UCServerCallsManager * serverManager;
    UIView * footerView;
    NSString * lastString;
}
@property (strong, nonatomic) UCLoadingViewController * loadingView;
@property (weak, nonatomic) IBOutlet UICollectionView * collectioViewPhotos;
@property (strong, nonatomic) NSMutableArray * arrItems;
@property (strong, nonatomic) UCPhotos * photos;;

@end

@implementation SerachListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [searchBar becomeFirstResponder];
    self.arrItems = [NSMutableArray array];
    serverManager = [[UCServerCallsManager alloc] init];
    self.loadingView = [self.storyboard instantiateViewControllerWithIdentifier:@"loadingView"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.loadingView.view.frame = [[UIScreen mainScreen] bounds];
}

#pragma mark - Server Calls
- (void)serachItem:(NSString *)itemName
              page:(NSInteger)pageNumber {
    __weak typeof(self) weakSelf = self;
    [serverManager searchForItem:itemName
                      pageNumber:pageNumber
                 completionBlock:^(NSDictionary *dictionary, UCPhotos *photos, NSError *error) {
                     if (error != nil) {
                         [self showLoading:false];
                         [self showAlertWithTitle:@"Error" message:error.localizedDescription];
                     } else if (photos != nil){
                         weakSelf.photos = photos;
                         [weakSelf.arrItems addObjectsFromArray:weakSelf.photos.arrPhotos];
                         [weakSelf reloadData];
                     } else {
                         [self showLoading:false];
                         [self showAlertWithTitle:[dictionary valueForKey:@"message"] message:@"Please generate new api-key and update it in API_KEY in UCServerCallsManager class."];
                     }
                 }];
}

- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showLoading:(BOOL)show {
    __weak typeof(self) weakSelf = self;
    if (show) {
        self.loadingView.view.alpha = 0.0;
        [self.view addSubview:self.loadingView.view];
        [UIView animateWithDuration:0.33
                         animations:^{
                             weakSelf.loadingView.view.alpha = 1.0;
        }];
    } else {
        [UIView animateWithDuration:0.33
                         animations:^{
                             weakSelf.loadingView.view.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [weakSelf.loadingView.view removeFromSuperview];
                         }];
    }
}

#pragma mark - UISearchBar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self showLoading:true];
    [self.arrItems removeAllObjects];
    [self serachItem:searchBar.text
                page:1];
    [searchBar resignFirstResponder];
}

#pragma mark - UICollectionView
- (void)reloadData {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self showLoading:false];
        [self.collectioViewPhotos reloadData];
    });
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SearchItemViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchCell"
                                                                          forIndexPath:indexPath];
    [cell populateCellWithPhoto:self.arrItems[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrItems.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width/3.2 , collectionView.frame.size.width/3.2);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UCCollectionReusableView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                           withReuseIdentifier:@"footer"
                                                                                  forIndexPath:indexPath];
    if (!self.arrItems.count) {
        [footer.activity stopAnimating];
    }
    return footer;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (self.photos.itemName.length) {
        [self serachItem:self.photos.itemName
                    page:[self.photos nextPage]];
    }
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
