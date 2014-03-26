//
//  SymbolDictionary.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "SymbolDictionary.h"
#import "Symbol.h"
#import "Word.h"

static NSString *const SymbolsJsonFileName = @"Symbols";
static NSString *const WordsJsonFileName = @"Words";

@implementation SymbolDictionary

+ (NSArray *)getJsonDataArrayFromFileWithName:(NSString *)filename {
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

+ (NSArray *)generateSymbolArray {
    NSMutableArray *symbolsArray = [[NSMutableArray alloc] init];
    
    NSArray *symbolsJson = [[self class] getJsonDataArrayFromFileWithName:SymbolsJsonFileName];
    
    for (NSMutableDictionary *symbolItem in symbolsJson) {
        Symbol *symbol = [[Symbol alloc] initWithSymbolDictionary:symbolItem];
        [symbolsArray addObject:symbol];
    }
    
    return [symbolsArray copy];
}

+ (NSArray *)generateQuizArray {
    NSArray *userDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:@"selectedSet"];
    NSMutableArray *symbolsArray = [[NSMutableArray alloc] init];
    
    NSArray *symbolsJson = [[self class] getJsonDataArrayFromFileWithName:SymbolsJsonFileName];
    
    for (NSMutableDictionary *symbolItem in symbolsJson) {
        if ([userDefaults containsObject:symbolItem[@"id"]]) {
            Symbol *symbol = [[Symbol alloc] initWithSymbolDictionary:symbolItem];
            [symbolsArray addObject:symbol];
        }
    }
    
    return [symbolsArray copy];
}

+ (NSArray *)generateWordArray {
    NSMutableArray *wordsArray = [[NSMutableArray alloc] init];
    
    NSArray *wordsJson = [[self class] getJsonDataArrayFromFileWithName:WordsJsonFileName];
    
    for (NSMutableDictionary *wordItem in wordsJson) {
        Word *word = [[Word alloc] initWithWordDictionary:wordItem];
        [wordsArray addObject:word];
    }
    
    return [wordsJson copy];
}

@end
