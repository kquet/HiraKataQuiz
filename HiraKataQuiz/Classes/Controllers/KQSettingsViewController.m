//
//  KQSettingsViewController.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-04-29.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "KQSettingsViewController.h"

static NSString *const UserDefaultsAudioClueEnabledIdentifier = @"settingsAudioClueEnabled";
static NSString *const UserDefaultsVisualClueEnabledIdentifier = @"settingsVisualClueEnabled";
static NSString *const UserDefaultsSelectedSyllabryIdentifier = @"selectedSyllabry";

@interface KQSettingsViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *audioClueSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *visualClueSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *syllabrySegmentedControl;

@end

@implementation KQSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureSettingsForUserDefaults];
}

- (void)configureSettingsForUserDefaults {
    BOOL isAudioEnabled = [self isAudioClueEnabled];
    BOOL isVisualEnabled = [self isVisualClueEnabled];
    
    if(!isAudioEnabled) {
        isVisualEnabled = YES;
        [self.visualClueSwitch setEnabled:NO];
    }
    
    [self.audioClueSwitch setOn:isAudioEnabled];
    [self.visualClueSwitch setOn:isVisualEnabled];
    
    [self.syllabrySegmentedControl setSelectedSegmentIndex:[self getSyllabryType]];
}

- (IBAction)audioClueSwitched:(id)sender {
    if (self.audioClueSwitch.on) {
        [self.visualClueSwitch setEnabled:YES];
    } else {
        [self.visualClueSwitch setEnabled:NO];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:self.audioClueSwitch.on forKey:UserDefaultsAudioClueEnabledIdentifier];
}

- (IBAction)visualClueSwitched:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:self.visualClueSwitch.on forKey:UserDefaultsVisualClueEnabledIdentifier];

    if (self.visualClueSwitch.on) {
        [self.audioClueSwitch setEnabled:YES];
    } else {
        [self.audioClueSwitch setEnabled:NO];
    }
}

- (IBAction)syllabrySegmentedControlChanged:(id)sender {
    SyllabryType syllabryType;
    
    if ([sender selectedSegmentIndex] == 0) {
        syllabryType = Hiragana;
    } else {
        syllabryType = Katakana;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@(syllabryType) forKey:UserDefaultsSelectedSyllabryIdentifier];
}

-(BOOL)isAudioClueEnabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:UserDefaultsAudioClueEnabledIdentifier];
}

- (BOOL)isVisualClueEnabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:UserDefaultsVisualClueEnabledIdentifier];
}

- (SyllabryType)getSyllabryType {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsSelectedSyllabryIdentifier] integerValue];
}

@end
