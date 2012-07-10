//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Kent Wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorModel.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsTypingANumber;
@property (nonatomic) BOOL decimalPointIsUsed;
@property (nonatomic, strong) CalculatorModel *model;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize verboseDisplay;
@synthesize userIsTypingANumber;
@synthesize model = _model;
@synthesize decimalPointIsUsed;

- (CalculatorModel *)model 
{
    if (!_model) _model = [[CalculatorModel alloc]init];
    return _model;
}
- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = sender.currentTitle;
    if(self.userIsTypingANumber)
        self.display.text = [self.display.text stringByAppendingString:digit];
    else {
        self.display.text = digit;
        if (self.verboseDisplay.text != @"")
            self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:@" "];
        self.userIsTypingANumber = YES;
    }
    
    self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:digit];
}

- (IBAction)enterPressed 
{
    [self.model pushOperand:[self.display.text doubleValue]];
    
    self.userIsTypingANumber = NO;
    self.decimalPointIsUsed = NO;
}

- (IBAction)dotPressed 
{
   if (!self.decimalPointIsUsed)
   {
       if(self.userIsTypingANumber)
       {
           self.display.text = [self.display.text stringByAppendingString:@"."];
        self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:@"."];
       }
       else {
           self.display.text = @"0.";
           self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:@" 0."];
           self.userIsTypingANumber = YES;
       }
 
       self.decimalPointIsUsed = YES;
       
       
   }

}
- (IBAction)clearPressed 
{
    self.verboseDisplay.text = @"";
    self.display.text = @"0";
    [self.model clearStack];
    self.userIsTypingANumber = NO;
    self.decimalPointIsUsed = NO;
}

- (IBAction)deletePressed 
{
    if (![self.display.text isEqualToString:@"0"]) 
    {
        self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
        self.verboseDisplay.text = [self.verboseDisplay.text substringToIndex:[self.verboseDisplay.text length] - 1];
        
        if ([self.display.text length] == 0) 
        {
            self.display.text = @"0";
            self.verboseDisplay.text = [self.verboseDisplay.text substringToIndex:[self.verboseDisplay.text length] - 1];
            self.userIsTypingANumber = NO;
        }
    }
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsTypingANumber) 
        [self enterPressed];
    NSString *operation = sender.currentTitle;
    
    //verboseDisplay
    self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:@" "];
    self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:operation];
    self.verboseDisplay.text = [self.verboseDisplay.text stringByAppendingString:@" ="];
    
    double result = [self.model performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (void)viewDidUnload {
    [self setVerboseDisplay:nil];
    [super viewDidUnload];
}
@end
