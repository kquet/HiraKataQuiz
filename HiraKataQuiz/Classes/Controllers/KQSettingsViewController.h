//
//  KQSettingsViewController.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-04-29.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Hiragana = 0,
    Katakana
} SyllabryType;

@interface KQSettingsViewController : UIViewController

- (BOOL)isAudioClueEnabled;
- (BOOL)isVisualClueEnabled;
- (SyllabryType)getSyllabryType;

@end
