//
//  KQMultipleChoiceView.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Word;

typedef enum {
    QuizViewTypeSymbols,
    QuizViewTypeWords,
} QuizViewType;

@interface KQMultipleChoiceView : UIView

- (void)configureSymbolQuestion:(NSString *)question withAnswers:(NSArray *)answers forQuizType:(QuizViewType)quizType;

- (void)updateClockWithTime:(NSInteger)countdownTime;
- (void)updateScoreWithScore:(NSInteger)score withCorrectAnswer:(BOOL)isCorrect;

@end
