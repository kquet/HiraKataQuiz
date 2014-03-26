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
@property (nonatomic, strong) NSString *phonetic;
@property (nonatomic, strong) NSString *hiragana;
@property (nonatomic, strong) NSString *katakana;

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

#pragma mark - Get Methods

- (NSNumber *)getSymbolId {
    return self.symbolId;
}

- (NSString *)getPhonetic {
    return self.phonetic;
}

- (NSString *)getHiragana {
    return self.hiragana;
}

- (NSString *)getKatakana {
    return self.katakana;
}

#pragma mark - Quiz Methods

-(NSString *)getSolutionStringForQuizType:(QuizType)quizType {
    NSString *solutionString;
    
    switch (quizType) {
        case SolutionHiraganaAnswersPhonetic:
            solutionString = self.hiragana;
            break;
        case SolutionKatakanaAnswersPhonetic:
            solutionString = self.katakana;
            break;
        case SolutionPhoneticAnswersHiragana:
        case SolutionPhoneticAnswersKatakana:
        default:
            solutionString = self.phonetic;
            break;
    }
    
    return solutionString;
}

- (NSString *)getAnswerStringForQuizType:(QuizType)quizType {
    NSString *answerString;
    
    switch (quizType) {
        case SolutionPhoneticAnswersHiragana:
            answerString = self.hiragana;
            break;
        case SolutionPhoneticAnswersKatakana:
            answerString = self.katakana;
            break;
        case SolutionHiraganaAnswersPhonetic:
        case SolutionKatakanaAnswersPhonetic:
        default:
            answerString = self.phonetic;
            break;
    }
    
    return answerString;
}

@end
