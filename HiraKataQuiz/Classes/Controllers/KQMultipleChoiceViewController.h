//
//  KQMultipleChoiceViewController.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Symbol.h"

typedef enum {
    PhoneticToCharacter = 0,
    CharacterToPhonetic
} Quiz;

@interface KQMultipleChoiceViewController : UIViewController

@property (nonatomic) Quiz quiz;

@end
