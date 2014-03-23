//
//  Symbol.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "Symbol.h"

@interface Symbol ()

@property (nonatomic) NSNumber *symbolId;

@end

@implementation Symbol

- (id)initWithSymbolDictionary:(NSMutableDictionary *)dictionary {
    self = [super init];
    
    if(dictionary[@"id"] != nil) {
        if([dictionary[@"id"] isKindOfClass:[NSNumber class]]) {
            self.symbolId = dictionary[@"id"];
        }
    }
    
    if(dictionary[@"phonetic"] != nil) {
        if([dictionary[@"phonetic"] isKindOfClass:[NSString class]]) {
            self.phonetic = dictionary[@"phonetic"];
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

- (NSNumber *)getSymbolId {
    return self.symbolId;
}

@end
