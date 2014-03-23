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

static NSString *const MultipleChoiceSegueIdentifier = @"MultipleChoiceSegueIdentifier";
static NSString *const SettingsSegueIdentifier = @"SettingsSegueIdentifier";
static NSString *const UserDefaultsSelectionIdentifier = @"selectedSet";

@interface KQHomeViewController ()

// TODO: Refactor these to their own controllers
@property (nonatomic, strong) NSArray *symbolsArray;
@property (nonatomic, strong) NSArray *quizSelectSymbolsArray;

@end

@implementation KQHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkUserDefaults];
    
    self.symbolsArray = [SymbolDictionary generateSymbolsArray];
    self.quizSelectSymbolsArray = [SymbolDictionary generateQuizArray];
}


// TODO: Refactor, will no longer need prepare after the move of arrays to respective controllers
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:MultipleChoiceSegueIdentifier]) {
        KQMultipleChoiceViewController *multipleChoiceViewController = [segue destinationViewController];

        [multipleChoiceViewController setSymbolsArray:self.quizSelectSymbolsArray];
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
