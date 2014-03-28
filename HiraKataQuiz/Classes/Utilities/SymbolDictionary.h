//
//  SymbolDictionary.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SymbolDictionary : NSObject

@property (nonatomic, strong) NSArray *symbolArray;
@property (nonatomic, strong) NSArray *symbolQuizArray;

+ (id)sharedManager;
- (void)update;

@end
