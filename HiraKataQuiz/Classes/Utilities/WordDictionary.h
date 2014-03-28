//
//  WordDictionary.h
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-27.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordDictionary : NSObject

@property (nonatomic, strong) NSArray *wordArray;
@property (nonatomic, strong) NSArray *wordQuizArray;

+ (id)sharedManager;
- (void)update;

@end
