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

@property (weak, nonatomic) IBOutlet UILabel *clueLabel;

@property (weak, nonatomic) IBOutlet UIButton *answerButtonA;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonB;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonC;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonD;

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

@end
