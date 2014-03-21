//
//  KQHomeViewController.m
//  HiraKataQuiz
//
//  Created by Kael Quet on 2014-03-20.
//  Copyright (c) 2014 Kael Quet. All rights reserved.
//

#import "KQHomeViewController.h"
#import "KQMultipleChoiceViewController.h"
#import "SymbolDictionary.h"

static NSString *const MultipleChoiceSegueIdentifier = @"MultipleChoiceSegueIdentifier";

@interface KQHomeViewController ()

@property (nonatomic, strong) NSArray *symbolsArray;

@end

@implementation KQHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.symbolsArray = [SymbolDictionary generateSymbolsArray];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:MultipleChoiceSegueIdentifier]) {
        KQMultipleChoiceViewController *multipleChoiceViewController = [segue destinationViewController];

        [multipleChoiceViewController setSymbolsArray:self.symbolsArray];
    }
}

- (IBAction)unwindToHomeView:(UIStoryboardSegue *)unwindSegue {

}

@end
