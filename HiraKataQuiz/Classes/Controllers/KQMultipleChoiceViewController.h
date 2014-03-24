//
//  KQMultipleChoiceViewController.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Symbol.h"

@interface KQMultipleChoiceViewController : UIViewController

@property (nonatomic, strong) NSArray *symbolsArray;
@property (nonatomic) QuizType quizType;

@end
