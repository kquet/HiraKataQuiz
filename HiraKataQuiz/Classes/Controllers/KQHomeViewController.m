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

@interface KQHomeViewController ()

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
    NSArray *userDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:@"selectedSet"];
    if (userDefaults == nil) {
        NSLog(@"null defaults");
        NSArray *defaultSelection = [NSArray arrayWithObjects: @(1), @(2), @(3), @(4), nil];
        [[NSUserDefaults standardUserDefaults] setObject:defaultSelection forKey:@"selectedSet"];
    } else {
        NSLog(@"defaults: %@", userDefaults);
    }
}

#pragma mark - rewind segue

- (IBAction)unwindToHomeView:(UIStoryboardSegue *)unwindSegue {
    self.quizSelectSymbolsArray = [SymbolDictionary generateQuizArray];
}

@end
