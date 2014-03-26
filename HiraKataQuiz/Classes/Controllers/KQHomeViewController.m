//
//  KQHomeViewController.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "KQHomeViewController.h"
#import "KQMultipleChoiceViewController.h"
#import "KQSettingsViewController.h"
#import "SymbolDictionary.h"
#import "Symbol.h"

static NSString *const PhoneticQuizSegueIdentifier = @"PhoneticQuizSegueIdentifier";
static NSString *const KanaQuizSegueIdentifier = @"KanaQuizSegueIdentifier";
static NSString *const SettingsSegueIdentifier = @"SettingsSegueIdentifier";
static NSString *const UserDefaultsSelectionIdentifier = @"selectedSet";

@interface KQHomeViewController ()

// TODO: Refactor these to their own controllers
@property (nonatomic, strong) NSArray *symbolsArray;
@property (nonatomic, strong) NSArray *wordsArray;
@property (nonatomic, strong) NSArray *quizSelectSymbolsArray;

@end

@implementation KQHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkUserDefaults];
    
    self.symbolsArray = [SymbolDictionary generateSymbolArray];
    self.wordsArray = [SymbolDictionary generateWordArray];
    self.quizSelectSymbolsArray = [SymbolDictionary generateQuizArray];
}


// TODO: Refactor, will no longer need prepare after the move of arrays to respective controllers
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:PhoneticQuizSegueIdentifier]) {
        KQMultipleChoiceViewController *multipleChoiceViewController = [segue destinationViewController];
        [multipleChoiceViewController setSymbolsArray:self.quizSelectSymbolsArray];
        [multipleChoiceViewController setQuizType:SolutionPhoneticAnswersHiragana];
    } else if ([[segue identifier] isEqualToString:KanaQuizSegueIdentifier]) {
        KQMultipleChoiceViewController *multipleChoiceViewController = [segue destinationViewController];
        [multipleChoiceViewController setSymbolsArray:self.quizSelectSymbolsArray];
        [multipleChoiceViewController setQuizType:SolutionHiraganaAnswersPhonetic];
    } else if ([[segue identifier] isEqualToString:SettingsSegueIdentifier]) {
        KQSettingsViewController *settingsViewController = [segue destinationViewController];
        
        [settingsViewController setSymbolsArray:self.symbolsArray];
    }
}

#pragma mark - NSUserDefaults

- (void)checkUserDefaults {
    NSArray *userDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:UserDefaultsSelectionIdentifier];
    if (userDefaults == nil) {
        NSArray *defaultSelection = [NSArray arrayWithObjects: @(1), @(2), @(3), @(4), nil];
        [[NSUserDefaults standardUserDefaults] setObject:defaultSelection forKey:UserDefaultsSelectionIdentifier];
    }
}

#pragma mark - rewind segue

- (IBAction)unwindToHomeView:(UIStoryboardSegue *)unwindSegue {
    // TODO: Only do if coming back from settings
    self.quizSelectSymbolsArray = [SymbolDictionary generateQuizArray];
}

@end
