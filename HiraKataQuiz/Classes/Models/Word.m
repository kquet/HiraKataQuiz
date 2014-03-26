//
//  Word.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-25.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "Word.h"

@interface Word ()

@property (nonatomic) NSNumber *wordId;
@property (nonatomic, strong) NSArray *symbolIds;
@property (nonatomic, strong) NSString *english;
@property (nonatomic, strong) NSString *hiragana;
@property (nonatomic, strong) NSString *katakana;

@end

@implementation Word

- (id)initWithWordDictionary:(NSMutableDictionary *)dictionary {
    self = [super init];
    
    if(dictionary[@"id"] != nil) {
        if([dictionary[@"id"] isKindOfClass:[NSNumber class]]) {
            self.wordId = dictionary[@"id"];
        }
    }
    
    if(dictionary[@"symbolIds"] != nil) {
        if([dictionary[@"symbolIds"] isKindOfClass:[NSArray class]]) {
            self.wordId = dictionary[@"symbolIds"];
        }
    }
    
    if(dictionary[@"english"] != nil) {
        if([dictionary[@"english"] isKindOfClass:[NSArray class]]) {
            self.english = dictionary[@"english"];
        }
    }
    
    if(dictionary[@"hiragana"] != nil) {
        if([dictionary[@"hiragana"] isKindOfClass:[NSString class]]) {
            self.hiragana = dictionary[@"hiragana"];
        }
    }
    
    if(dictionary[@"katakana"] != nil) {
        if([dictionary[@"katakana"] isKindOfClass:[NSString class]]) {
            self.katakana = dictionary[@"katakana"];
        }
    }
    
    return self;
}

#pragma mark - Get Methods

- (NSNumber *)getWordId {
    return self.wordId;
}

- (NSString *)getEnglish {
    return self.english;
}

- (NSString *)getHiragana {
    return self.hiragana;
}

- (NSString *)getKatakana {
    return self.katakana;
}

@end
