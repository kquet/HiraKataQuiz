//
//  Colour.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "Colour.h"

@implementation Colour

+ (UIColor *)appBlueColor {
    return [UIColor colorWithRed:0/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}

+ (UIColor *)selectionGreenColor {
    return [UIColor colorWithRed:102.0f/255.0f green:255.0f/255.0f blue:204.0f/255.0f alpha:1.0f];
}

+ (UIColor *)falseAnswerRedColor {
    return [UIColor colorWithRed:255.0f/255.0f green:120.0f/255.0f blue:120.0f/255.0f alpha:1.0f];
}

@end
