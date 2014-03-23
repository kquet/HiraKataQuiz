//
//  KQSymbolSettingsCollectionViewCell.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-22.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Symbol;

@interface KQSymbolSettingsCollectionViewCell : UICollectionViewCell

- (void)configureCellForSymbol:(Symbol *)symbol;

@end
