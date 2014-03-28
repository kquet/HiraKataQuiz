//
//  SymbolDictionary.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "SymbolDictionary.h"
#import "Symbol.h"

static NSString *const SymbolsJsonFileName = @"Symbols";

@implementation SymbolDictionary

+ (id)sharedManager {
    static SymbolDictionary *sharedSymbolDictionary = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedSymbolDictionary = [[self alloc] init];
    });
    
    return sharedSymbolDictionary;
}

- (id)init {
    if (self = [super init]) {
        [self generateSymbolArray];
        [self generateQuizArray];
    }
    return  self;
}

- (void)update {
    [self generateSymbolArray];
    [self generateQuizArray];
}

- (NSArray *)getJsonDataArrayFromFileWithName:(NSString *)filename {
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)generateSymbolArray {
    NSMutableArray *symbolsArray = [[NSMutableArray alloc] init];
    
    NSArray *symbolsJson = [self getJsonDataArrayFromFileWithName:SymbolsJsonFileName];
    
    for (NSMutableDictionary *symbolItem in symbolsJson) {
        Symbol *symbol = [[Symbol alloc] initWithSymbolDictionary:symbolItem];
        [symbolsArray addObject:symbol];
    }
    
    self.symbolArray =  [symbolsArray copy];
}

- (void)generateQuizArray {
    NSArray *userDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:@"selectedSet"];
    NSMutableArray *symbolsArray = [[NSMutableArray alloc] init];
    
    NSArray *symbolsJson = [self getJsonDataArrayFromFileWithName:SymbolsJsonFileName];
    
    for (NSMutableDictionary *symbolItem in symbolsJson) {
        if ([userDefaults containsObject:symbolItem[@"id"]]) {
            Symbol *symbol = [[Symbol alloc] initWithSymbolDictionary:symbolItem];
            [symbolsArray addObject:symbol];
        }
    }
    
    self.symbolQuizArray = [symbolsArray copy];
}

@end
