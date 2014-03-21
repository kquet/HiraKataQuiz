//
//  Symbol.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Symbol : NSObject

@property (nonatomic, strong) NSString *phonetic;
@property (nonatomic, strong) NSString *hiragana;
@property (nonatomic, strong) NSString *katakana;

- (id)initWithSymbolDictionary:(NSMutableDictionary *)dictionary;

@end
