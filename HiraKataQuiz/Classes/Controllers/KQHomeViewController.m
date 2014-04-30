//
//  KQHomeViewController.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "KQHomeViewController.h"
#import "KQMultipleChoiceViewController.h"
#import "KQCharacterSelectionViewController.h"
#import "SymbolDictionary.h"
#import "WordDictionary.h"

static NSString *const PhoneticQuizSegueIdentifier = @"PhoneticQuizSegueIdentifier";
static NSString *const KanaQuizSegueIdentifier = @"KanaQuizSegueIdentifier";
static NSString *const SettingsSegueIdentifier = @"SettingsSegueIdentifier";
static NSString *const UserDefaultsSelectionIdentifier = @"selectedSet";

@interface KQHomeViewController ()

@end

@implementation KQHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkUserDefaults];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:PhoneticQuizSegueIdentifier]) {
        KQMultipleChoiceViewController *multipleChoiceViewController = [segue destinationViewController];
        [multipleChoiceViewController setQuiz:PhoneticToCharacter];
    } else if ([[segue identifier] isEqualToString:KanaQuizSegueIdentifier]) {
        KQMultipleChoiceViewController *multipleChoiceViewController = [segue destinationViewController];
        [multipleChoiceViewController setQuiz:CharacterToPhonetic];
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
    [[SymbolDictionary sharedManager] update];
    [[WordDictionary sharedManager] update];
}

@end
