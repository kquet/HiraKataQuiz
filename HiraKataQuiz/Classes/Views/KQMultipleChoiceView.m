//
//  KQMultipleChoiceView.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KQMultipleChoiceView.h"

@interface KQMultipleChoiceView ()

@property (weak, nonatomic) IBOutlet UILabel *clueLabel;

@property (weak, nonatomic) IBOutlet UIButton *answerButtonA;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonB;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonC;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonD;

@end

@implementation KQMultipleChoiceView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [[self.answerButtonA layer] setBorderWidth:1.0f];
        [[self.answerButtonA layer] setBorderColor:[UIColor whiteColor].CGColor];
        
        [[self.answerButtonB layer] setBorderWidth:1.0f];
        [[self.answerButtonB layer] setBorderColor:[UIColor whiteColor].CGColor];
        
        [[self.answerButtonC layer] setBorderWidth:1.0f];
        [[self.answerButtonC layer] setBorderColor:[UIColor whiteColor].CGColor];
        
        [[self.answerButtonD layer] setBorderWidth:1.0f];
        [[self.answerButtonD layer] setBorderColor:[UIColor whiteColor].CGColor];
    }
    return self;
}

- (void)configureQuestion:(NSString *)question withAnswers:(NSArray *)answers {
    UIButton *button;
    NSArray *answerButtons = [NSArray arrayWithObjects:
                          self.answerButtonA,
                          self.answerButtonB,
                          self.answerButtonC,
                          self.answerButtonD, nil];
    
    self.clueLabel.text = question;
    for (int i = 0; i < [answers count]; i++) {
        button = (UIButton *)answerButtons[i];
        [button setEnabled:YES];
        [button setTitle:answers[i] forState:UIControlStateNormal];
    }
}

@end
