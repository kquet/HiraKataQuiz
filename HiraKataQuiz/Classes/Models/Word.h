//
//  Word.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-25.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject

- (id)initWithWordDictionary:(NSMutableDictionary *)dictionary;

- (NSNumber *)getWordId;
- (NSArray *)getSymbolIds;
- (NSArray *)getEnglish;
- (NSString *)getHiragana;
- (NSString *)getKatakana;

@end
