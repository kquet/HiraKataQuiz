//
//  KQSettingsViewController.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "KQSettingsViewController.h"
#import "KQSymbolSettingsCollectionViewCell.h"
#import "SymbolDictionary.h"
#import "Symbol.h"

static NSString *const CharacterCellReuseIdentifier = @"KQSymbolSettingsCollectionViewCell";
static NSString *const CharacterSelectionHeaderIdentifier = @"CharacterSelectionHeaderIdentifier";
static NSString *const UserDefaultsSelectedSetIdentifier = @"selectedSet";

@interface KQSettingsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) SymbolDictionary *symbolDictionary;

@property (nonatomic, weak) IBOutlet UICollectionView *characterSetCollectionView;
@property (nonatomic, strong) NSArray *userSelectedCharacterDefaults;

@end

@implementation KQSettingsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.symbolDictionary = [SymbolDictionary sharedManager];
    
    [self.characterSetCollectionView registerNib:[UINib nibWithNibName:CharacterCellReuseIdentifier bundle:nil] forCellWithReuseIdentifier:CharacterCellReuseIdentifier];
    self.characterSetCollectionView.allowsMultipleSelection = YES;
    
    [self retrieveUserDefaults];
}

#pragma mark - NSUserDefaults

- (void)retrieveUserDefaults {
    self.userSelectedCharacterDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:UserDefaultsSelectedSetIdentifier];
}

- (void)saveUserDefaultsSelectionArray:(NSArray *)selection {
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    for (NSIndexPath *indexPath in selection) {
        [indexArray addObject:[[NSNumber alloc] initWithInteger:indexPath.item]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[indexArray copy] forKey:UserDefaultsSelectedSetIdentifier];
    
    [self retrieveUserDefaults];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.symbolDictionary.symbolArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

# pragma mark - UICollectionViewDelegate

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CharacterSelectionHeaderIdentifier forIndexPath:indexPath];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KQSymbolSettingsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CharacterCellReuseIdentifier forIndexPath:indexPath];
    [cell configureCellForSymbol:self.symbolDictionary.symbolArray[indexPath.item]];
    if ([self.userSelectedCharacterDefaults containsObject:[self.symbolDictionary.symbolArray[indexPath.item] getSymbolId]]) {
        [cell setSelected:YES];
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
