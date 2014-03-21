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
#import "Symbol.h"

typedef enum {
    KanaTypeHiragana,
    KanaTypeKatakana
} KanaType;

@interface KQMultipleChoiceViewController ()

@property (strong, nonatomic) IBOutlet KQMultipleChoiceView *multipleChoiceView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *kanaTypeSegmentedControl;

@property (weak, nonatomic) IBOutlet UIButton *answerButtonA;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonB;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonC;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonD;

@property (nonatomic) KanaType quizKanaType;
@property (nonatomic) NSInteger answerIndex;

@end

@implementation KQMultipleChoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.quizKanaType = KanaTypeHiragana;
    [self.kanaTypeSegmentedControl setSelectedSegmentIndex:0];
    [self generateQuestion];
}

- (void)generateQuestion {
    if ([self.symbolsArray count] < 1) {
        return;
    }
    
    self.answerIndex = arc4random() % 4;
    NSMutableArray *answerArray = [[NSMutableArray alloc] init];
    NSString *answerString;
    
    while ([answerArray count] < 4) {
        Symbol *symbol = [self.symbolsArray objectAtIndex:(arc4random() % [self.symbolsArray count])];
        
        if(![answerArray containsObject:symbol.hiragana] && ![answerArray containsObject:symbol.katakana]) {
            
            if ([answerArray count] == self.answerIndex) {
                answerString = symbol.phonetic;
            }
            
            switch (self.quizKanaType) {
                case KanaTypeKatakana:
                    [answerArray addObject:symbol.katakana];
                    break;
                case KanaTypeHiragana:
                default:
                    [answerArray addObject:symbol.hiragana];
                    break;
            }
        }
    }
    
    [self.multipleChoiceView configureQuestion:answerString withAnswers:[answerArray copy]];
}

- (IBAction)answerButtonTapped:(id)sender {
    BOOL isCorrect;
    
    if (sender == self.answerButtonA) {
        isCorrect = self.answerIndex == 0;
    } else if (sender == self.answerButtonB) {
        isCorrect = self.answerIndex == 1;
    } else if (sender == self.answerButtonC) {
        isCorrect = self.answerIndex == 2;
    } else if (sender == self.answerButtonD) {
        isCorrect = self.answerIndex == 3;
    }
    
    if (isCorrect) {
        [self generateQuestion];
    } else {
        [((UIButton*)sender) setEnabled:NO];
        [[[UIAlertView alloc] initWithTitle:@"Wrong"
                                    message:@"Try Again"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (IBAction)kanaTypeSegmentedControlTapped:(id)sender {
    if ([self.kanaTypeSegmentedControl selectedSegmentIndex] == 0) {
        self.quizKanaType = KanaTypeHiragana;
    } else {
        self.quizKanaType = KanaTypeKatakana;
    }
    [self generateQuestion];
}

- (IBAction)nextQuestionButtonTapped:(id)sender {
    [self generateQuestion];
}

@end
