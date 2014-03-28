//
//  KQMultipleChoiceViewController.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "KQMultipleChoiceViewController.h"
#import "KQMultipleChoiceView.h"
#import "SymbolDictionary.h"
#import "KQAnswerButton.h"

// TODO: Implement score/timer class for reuse
static NSTimeInterval const countdownTimeInterval = 1;
static NSInteger const countdownTime = 10;

@interface KQMultipleChoiceViewController ()

@property (nonatomic, weak) SymbolDictionary *symbolDictionary;

@property (nonatomic, strong) IBOutlet KQMultipleChoiceView *multipleChoiceView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *kanaTypeSegmentedControl;

@property (nonatomic) NSInteger answerIndex;
@property (nonatomic, strong) NSArray *answerButtons;

@property (nonatomic, weak) IBOutlet UIButton *answerButtonA;
@property (nonatomic, weak) IBOutlet UIButton *answerButtonB;
@property (nonatomic, weak) IBOutlet UIButton *answerButtonC;
@property (nonatomic, weak) IBOutlet UIButton *answerButtonD;

@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic) NSInteger countdownTime;

@property (nonatomic) NSInteger quizScore;

@end

@implementation KQMultipleChoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.symbolDictionary = [SymbolDictionary sharedManager];
    
    [self.kanaTypeSegmentedControl setSelectedSegmentIndex:0];
    self.quizScore = 0;
    [self generateQuestion];
    self.answerButtons = [[NSArray alloc] initWithObjects:self.answerButtonA,
                          self.answerButtonB,
                          self.answerButtonC,
                          self.answerButtonD, nil];
}

- (void)generateQuestion {
    [self resetTimer];
    
    self.answerIndex = arc4random() % 4;
    NSString *solutionString;
    NSString *answerString;
    NSMutableArray *answerArray = [[NSMutableArray alloc] init];
    
    while ([answerArray count] < 4) {
        Symbol *symbol = [self.symbolDictionary.symbolQuizArray objectAtIndex:(arc4random() % [self.symbolDictionary.symbolQuizArray count])];
        answerString = [symbol getAnswerStringForQuizType:self.quizType];
        
        if(![answerArray containsObject:answerString]) {
            if ([answerArray count] == self.answerIndex) {
                solutionString = [symbol getSolutionStringForQuizType:self.quizType];
            }
            [answerArray addObject:answerString];
        }
    }
    
    [self.multipleChoiceView configureSymbolQuestion:solutionString withAnswers:[answerArray copy] forQuizType:QuizViewTypeSymbols];
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:countdownTimeInterval target:self selector:@selector(countdownTick) userInfo:nil repeats:YES];
}

- (void)resetTimer {
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
    
    [self updateScoreWithPoints:self.countdownTime];
    
    self.countdownTime = countdownTime;
    [self.multipleChoiceView updateClockWithTime:self.countdownTime];
}

- (void)countdownTick {
    if(self.countdownTime > 0) {
        self.countdownTime -= 1;
        [self.multipleChoiceView updateClockWithTime:self.countdownTime];
    } else {
        [self updateScoreWithPoints:-5];
        [self generateQuestion];
    }
}

- (void)updateScoreWithPoints:(NSInteger)points {
    self.quizScore += points;
    [self.multipleChoiceView updateScoreWithScore:self.quizScore withIncrease:points];
}

- (IBAction)answerButtonTapped:(id)sender {
    if ([self.answerButtons indexOfObject:sender] == self.answerIndex) {
        [self.countdownTimer invalidate];
        [self generateQuestion];
    } else {
        [((UIButton *)sender) setEnabled:NO];
        [self updateScoreWithPoints:-5];
    }
}

- (IBAction)kanaTypeSegmentedControlTapped:(id)sender {
    if ([self.kanaTypeSegmentedControl selectedSegmentIndex] == 0) {
        switch (self.quizType) {
            case SolutionPhoneticAnswersKatakana:
                self.quizType = SolutionPhoneticAnswersHiragana;
                break;
            case SolutionKatakanaAnswersPhonetic:
                self.quizType = SolutionHiraganaAnswersPhonetic;
            default:
                break;
        }
    } else {
        switch (self.quizType) {
            case SolutionPhoneticAnswersHiragana:
                self.quizType = SolutionPhoneticAnswersKatakana;
                break;
            case SolutionHiraganaAnswersPhonetic:
                self.quizType = SolutionKatakanaAnswersPhonetic;
            default:
                break;
        }
    }
    
    self.countdownTime = 0;
    [self generateQuestion];
}

- (IBAction)nextQuestionButtonTapped:(id)sender {
    [self generateQuestion];
}

@end
