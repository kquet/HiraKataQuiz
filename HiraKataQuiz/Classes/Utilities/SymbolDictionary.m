//
//  SymbolDictionary.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "SymbolDictionary.h"
#import "Symbol.h"

@implementation SymbolDictionary

+ (NSArray *)generateSymbolsArray {
    NSMutableArray *symbolsArray = [[NSMutableArray alloc] init];
    
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"Symbols" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
    NSArray *symbolsJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    for (NSMutableDictionary *symbolItem in symbolsJson) {
        Symbol *symbol = [[Symbol alloc] initWithSymbolDictionary:symbolItem];
        [symbolsArray addObject:symbol];
    }
    
    return [symbolsArray copy];
}

@end
