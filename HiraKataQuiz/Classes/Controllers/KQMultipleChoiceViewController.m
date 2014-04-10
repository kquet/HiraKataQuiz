//
//  KQMultipleChoiceViewController.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "KQMultipleChoiceViewController.h"
#import "KQMultipleChoiceView.h"
#import "SymbolDictionary.h"
#import "KQAnswerButton.h"

// TODO: Implement score/timer class for reuse
static NSTimeInterval const countdownTimeInterval = 1;
static NSInteger const countdownTime = 10;
static NSString *const SpeechUtteranceVoiceLanguageJapanese = @"ja-JP";

@interface KQMultipleChoiceViewController ()

@property (nonatomic, weak) SymbolDictionary *symbolDictionary;

// View
@property (nonatomic, weak) IBOutlet KQMultipleChoiceView *multipleChoiceView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *kanaTypeSegmentedControl;

// Speech
@property (nonatomic, strong) NSString *solutionSpeechString;
@property (nonatomic, strong) AVSpeechUtterance *speechUtterance;
@property (nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;

// Answer
@property (nonatomic) NSInteger answerIndex;
@property (nonatomic, strong) NSArray *answerStrings;
@property (nonatomic, strong) NSArray *answerButtons;
@property (nonatomic, weak) IBOutlet UIButton *answerButtonA;
@property (nonatomic, weak) IBOutlet UIButton *answerButtonB;
@property (nonatomic, weak) IBOutlet UIButton *answerButtonC;
@property (nonatomic, weak) IBOutlet UIButton *answerButtonD;

// Score
@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic) NSInteger countdownTime;
@property (nonatomic) NSInteger quizScore;

@end

@implementation KQMultipleChoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.symbolDictionary = [SymbolDictionary sharedManager];

    self.speechUtterance = [[AVSpeechUtterance alloc] init];
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    
    [self.kanaTypeSegmentedControl setSelectedSegmentIndex:0];
    self.quizScore = 0;
    self.answerStrings = [[NSArray alloc] init];
    self.answerButtons = [[NSArray alloc] initWithObjects:self.answerButtonA,
                          self.answerButtonB,
                          self.answerButtonC,
                          self.answerButtonD, nil];
    
    [self generateQuestion];
}

#pragma mark - Question Flow

// TODO: Refactor out reset
- (void)generateQuestion {
    [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
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
                self.solutionSpeechString = answerString;
            }
            [answerArray addObject:answerString];
        }
    }
    
    self.answerStrings = [answerArray copy];
    [self.multipleChoiceView configureSymbolQuestion:solutionString withAnswers:self.answerStrings forQuizType:QuizViewTypeSymbols];
    [self speechSynthesizerWithString:self.solutionSpeechString andLanguage:SpeechUtteranceVoiceLanguageJapanese];
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

#pragma mark - AVSpeechSynthesizer

- (void)speechSynthesizerWithString:(NSString *)string andLanguage:(NSString *)language {
    switch (self.quizType) {
        case SolutionPhoneticAnswersHiragana:
        case SolutionPhoneticAnswersKatakana:
            self.speechUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
            self.speechUtterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:language];
            self.speechUtterance.rate = AVSpeechUtteranceMinimumSpeechRate;
            [self.speechSynthesizer speakUtterance:self.speechUtterance];
            break;
        default:
            break;
    }
}

# pragma mark - Buttons Tapped

- (IBAction)answerButtonTapped:(id)sender {
    NSUInteger tappedButtonIndex = [self.answerButtons indexOfObject:sender];
    
    if (tappedButtonIndex == self.answerIndex) {
        [self generateQuestion];
    } else {
        [((UIButton *)sender) setEnabled:NO];
        [self updateScoreWithPoints:-5];
        [self speechSynthesizerWithString:[self.answerStrings objectAtIndex:tappedButtonIndex] andLanguage:SpeechUtteranceVoiceLanguageJapanese];
    }
}

- (IBAction)nextQuestionButtonTapped:(id)sender {
    self.countdownTime = 0;
    [self generateQuestion];
}

- (IBAction)backButtonTapped:(id)sender {
    [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
}

- (IBAction)speechClueTapped:(id)sender {
    if (!self.speechSynthesizer.speaking) {
        [self speechSynthesizerWithString:self.solutionSpeechString andLanguage:SpeechUtteranceVoiceLanguageJapanese];
    }
}

# pragma mark - Segmentation Control

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

@end
