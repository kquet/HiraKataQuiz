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
static NSString *const SpeechUtteranceVoiceLanguageJapanese = @"ja-JP";
static NSTimeInterval const CountdownTimeInterval = 1;
static NSInteger const CountdownTime = 10;
static NSInteger const ScorePenalty = 5;

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
    
    [self resetTimer];
    [self generateQuestion];
}

#pragma mark - Question Flow

// TODO: Refactor out reset
- (void)generateQuestion {
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
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:CountdownTimeInterval target:self selector:@selector(countdownTick) userInfo:nil repeats:YES];
}

- (void)resetTimer {
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
    self.countdownTime = CountdownTime;
    [self.multipleChoiceView updateClockWithTime:self.countdownTime];
}

- (void)updateScoreWithCorrectAnswer:(BOOL)isCorrect {
    if (isCorrect) {
        self.quizScore += self.countdownTime;
    } else {
        self.quizScore -= ScorePenalty;
    }
    [self.multipleChoiceView updateScoreWithScore:self.quizScore withCorrectAnswer:isCorrect];
}

- (void)countdownTick {
    if(self.countdownTime > 0) {
        self.countdownTime -= 1;
        [self.multipleChoiceView updateClockWithTime:self.countdownTime];
    } else {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        [self updateScoreWithCorrectAnswer:NO];
        [self resetTimer];
        [self generateQuestion];
    }
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
        [self updateScoreWithCorrectAnswer:YES];
        [self resetTimer];
        [self generateQuestion];
    } else {
        [((UIButton *)sender) setEnabled:NO];
        [self updateScoreWithCorrectAnswer:NO];
        [self speechSynthesizerWithString:[self.answerStrings objectAtIndex:tappedButtonIndex] andLanguage:SpeechUtteranceVoiceLanguageJapanese];
    }
}

- (IBAction)nextQuestionButtonTapped:(id)sender {
    [self resetTimer];
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
