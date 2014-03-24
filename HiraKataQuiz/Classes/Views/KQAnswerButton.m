//
//  KQAnswerButton.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-23.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "KQAnswerButton.h"
#import "Colour.h"

@implementation KQAnswerButton

-(void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if(enabled) {
        self.backgroundColor = [Colour appBlueColor];
    } else {
        self.backgroundColor = [Colour falseAnswerRedColor];
    }
}

@end
