//
//  KQMultipleChoiceView.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KQMultipleChoiceView : UIView

- (void)configureQuestion:(NSString *)question withAnswers:(NSArray *)answers;
- (void)updateClockWithTime:(NSInteger)countdownTime;
- (void)updateScoreWithScore:(NSInteger)score withIncrease:(NSInteger)increased;

@end
