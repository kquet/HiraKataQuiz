//
//  KQMultipleChoiceView.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KQMultipleChoiceView.h"
#import "Colour.h"
#import "KQAnswerButton.h"

@interface KQMultipleChoiceView ()


@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *clueLabel;

@property (weak, nonatomic) IBOutlet UIButton *answerButtonA;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonB;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonC;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonD;

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation KQMultipleChoiceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)configureQuestion:(NSString *)question withAnswers:(NSArray *)answers {
    UIButton *button;
    
    // TODO: Test use of IBCollection
    NSArray *answerButtons = [NSArray arrayWithObjects:
                          self.answerButtonA,
                          self.answerButtonB,
                          self.answerButtonC,
                          self.answerButtonD, nil];
    
    self.clueLabel.text = question;
    for (int i = 0; i < [answers count]; i++) {
        button = (UIButton *)answerButtons[i];
        [((KQAnswerButton *)button) setEnabled:YES];
        [button setTitle:answers[i] forState:UIControlStateNormal];
    }
}

-(void)updateClockWithTime:(NSInteger)countdownTime {
    self.timerLabel.text = [NSString stringWithFormat:@"%ld", (long)countdownTime];
}

- (void)updateScoreWithScore:(NSInteger)score withIncrease:(NSInteger)increased{
    UIColor *scoreUpdateColour = [UIColor blueColor];
    
    if (increased > 0) {
        scoreUpdateColour = [UIColor greenColor];
    } else if (increased < 0){
        scoreUpdateColour = [UIColor redColor];
    }
    
    self.scoreLabel.textColor = scoreUpdateColour;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)score];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(resetScoreTextColour) userInfo:nil repeats:YES];
}

- (void)resetScoreTextColour {
    self.scoreLabel.textColor = [UIColor blueColor];
    [self.timer invalidate];
    self.timer = nil;
}

@end
