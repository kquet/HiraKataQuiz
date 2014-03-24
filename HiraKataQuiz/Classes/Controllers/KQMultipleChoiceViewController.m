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

@interface KQMultipleChoiceViewController ()

@property (strong, nonatomic) IBOutlet KQMultipleChoiceView *multipleChoiceView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *kanaTypeSegmentedControl;

@property (nonatomic, strong) NSArray *answerButtons;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonA;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonB;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonC;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonD;

@property (nonatomic) NSInteger answerIndex;

@end

@implementation KQMultipleChoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.kanaTypeSegmentedControl setSelectedSegmentIndex:0];
    [self generateQuestion];
    
    self.answerButtons = [[NSArray alloc] initWithObjects:self.answerButtonA,
                          self.answerButtonB,
                          self.answerButtonC,
                          self.answerButtonD, nil];
}

- (void)generateQuestion {
    // TODO: Refactor for better error handling
    if ([self.symbolsArray count] < 1) {
        return;
    }
    
    self.answerIndex = arc4random() % 4;
    NSString *solutionString;
    NSString *answerString;
    NSMutableArray *answerArray = [[NSMutableArray alloc] init];
    
    while ([answerArray count] < 4) {
        Symbol *symbol = [self.symbolsArray objectAtIndex:(arc4random() % [self.symbolsArray count])];
        answerString = [symbol getAnswerStringForQuizType:self.quizType];
        
        if(![answerArray containsObject:answerString]) {
            if ([answerArray count] == self.answerIndex) {
                solutionString = [symbol getSolutionStringForQuizType:self.quizType];
            }
            [answerArray addObject:answerString];
        }
    }
    
    [self.multipleChoiceView configureQuestion:solutionString withAnswers:[answerArray copy]];
}

- (IBAction)answerButtonTapped:(id)sender {
    if ([self.answerButtons indexOfObject:sender] == self.answerIndex) {
        [self generateQuestion];
    } else {
        [((UIButton *)sender) setEnabled:NO];
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
    
    [self generateQuestion];
}

- (IBAction)nextQuestionButtonTapped:(id)sender {
    [self generateQuestion];
}

@end
