//
//  KQSymbolSettingsCollectionViewCell.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-22.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "KQSymbolSettingsCollectionViewCell.h"
#import "Symbol.h"
#import "Colour.h"

@interface KQSymbolSettingsCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *phoneticLabel;
@property (weak, nonatomic) IBOutlet UILabel *hiraganaLabel;
@property (weak, nonatomic) IBOutlet UILabel *katakanaLabel;

@end

@implementation KQSymbolSettingsCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.selected = NO;
    self.backgroundColor = [UIColor whiteColor];
    
    self.phoneticLabel.text = nil;
    self.hiraganaLabel.text = nil;
    self.katakanaLabel.text = nil;
}

-(void)configureCellForSymbol:(Symbol *)symbol {
    self.backgroundColor = [UIColor whiteColor];
    
    self.phoneticLabel.text = symbol.phonetic;
    self.hiraganaLabel.text = symbol.hiragana;
    self.katakanaLabel.text = symbol.katakana;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (self.selected) {
        self.backgroundColor = [Colour selectionGreenColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
