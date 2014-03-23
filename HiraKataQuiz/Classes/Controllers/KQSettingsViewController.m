//
//  KQSettingsViewController.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "KQSettingsViewController.h"
#import "KQSymbolSettingsCollectionViewCell.h"
#import "Symbol.h";

static NSString *const CharacterCellReuseIdentifier = @"KQSymbolSettingsCollectionViewCell";

@interface KQSettingsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *characterSetCollectionView;
@property (nonatomic, strong) NSArray *userSelectedCharacterDefaults;

@end

@implementation KQSettingsViewController

-(void)viewDidLoad {
    [self.characterSetCollectionView registerNib:[UINib nibWithNibName:CharacterCellReuseIdentifier bundle:nil] forCellWithReuseIdentifier:CharacterCellReuseIdentifier];
    self.characterSetCollectionView.allowsMultipleSelection = YES;
    
    [self retrieveUserDefaults];
}

#pragma mark - NSUserDefaults

- (void)retrieveUserDefaults {
    self.userSelectedCharacterDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:@"selectedSet"];
}

- (void)saveUserDefaultsSelectionArray:(NSArray *)selection {
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    for (NSIndexPath *indexPath in selection) {
        [indexArray addObject:[[NSNumber alloc] initWithInteger:indexPath.item]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[indexArray copy] forKey:@"selectedSet"];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.symbolsArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

# pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KQSymbolSettingsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CharacterCellReuseIdentifier forIndexPath:indexPath];
    [cell configureCellForSymbol:self.symbolsArray[indexPath.item]];
    
    // TODO: Issues where the selected items do not appear as selected without collectionview being scrolled by user
    if ([self.userSelectedCharacterDefaults containsObject:[self.symbolsArray[indexPath.item] getSymbolId]]) {
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self saveUserDefaultsSelectionArray:[collectionView indexPathsForSelectedItems]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self saveUserDefaultsSelectionArray:[collectionView indexPathsForSelectedItems]];
}

@end
