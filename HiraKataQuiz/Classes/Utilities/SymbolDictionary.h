//
//  SymbolDictionary.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SymbolDictionary : NSObject

+ (NSArray *)generateSymbolArray;
+ (NSArray *)generateQuizArray;
+ (NSArray *)generateWordArray;

@end
