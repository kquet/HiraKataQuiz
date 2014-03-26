//
//  Symbol.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SolutionPhoneticAnswersHiragana = 0,
    SolutionPhoneticAnswersKatakana,
    SolutionHiraganaAnswersPhonetic,
    SolutionKatakanaAnswersPhonetic
} QuizType;

@interface Symbol : NSObject

- (id)initWithSymbolDictionary:(NSMutableDictionary *)dictionary;

- (NSNumber *)getSymbolId;
- (NSString *)getPhonetic;
- (NSString *)getHiragana;
- (NSString *)getKatakana;

- (NSString *)getSolutionStringForQuizType:(QuizType)quizType;
- (NSString *)getAnswerStringForQuizType:(QuizType)quizType;

@end
