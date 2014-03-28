//
//  WordDictionary.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-27.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "WordDictionary.h"
#import "Word.h"

static NSString *const WordsJsonFileName = @"Words";

@implementation WordDictionary

+ (id)sharedManager {
    static WordDictionary *sharedWordDictionary = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedWordDictionary = [[self alloc] init];
    });
    
    return sharedWordDictionary;
}

- (id)init {
    if (self = [super init]) {
        [self generateWordArray];
        [self generateQuizArray];
    }
    return  self;
}

- (void)update {
    [self generateWordArray];
    [self generateQuizArray];
}

- (NSArray *)getJsonDataArrayFromFileWithName:(NSString *)filename {
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)generateWordArray {
    NSMutableArray *wordsArray = [[NSMutableArray alloc] init];
    
    NSArray *wordsJson = [self getJsonDataArrayFromFileWithName:WordsJsonFileName];
    
    for (NSMutableDictionary *wordItem in wordsJson) {
        Word *word = [[Word alloc] initWithWordDictionary:wordItem];
        [wordsArray addObject:word];
    }
    
    self.wordArray = [wordsJson copy];
}

- (void)generateQuizArray {    NSSet *userDefaults = [NSSet setWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"selectedSet"]];
    NSSet *wordSymbolSet;
    
    NSMutableArray *wordsArray = [[NSMutableArray alloc] init];
    
    NSArray *wordsJson = [self getJsonDataArrayFromFileWithName:WordsJsonFileName];
    
    
    for (NSMutableDictionary *wordItem in wordsJson) {
        wordSymbolSet = [NSSet setWithArray:wordItem[@"symbolIds"]];
        if ([wordSymbolSet isSubsetOfSet:userDefaults]) {
            Word *word = [[Word alloc] initWithWordDictionary:wordItem];
            [wordsArray addObject:word];
        }
    }
    
    self.wordQuizArray = [wordsArray copy];
}

@end
