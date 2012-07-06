//
//  CalculatorModel.m
//  Calculator
//
//  Created by Kent Wang on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorModel.h"

@interface CalculatorModel()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorModel

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (!_operandStack) 
    {
        _operandStack = [[NSMutableArray alloc]init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double temp = [self popOperand];
        result = [self popOperand] - temp;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand]/divisor;
    } else if ([operation isEqualToString:@"sin"]) {
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"cos"]) {
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"sqrt"]) {
        result = sqrt([self popOperand]);
    }
    
    [self pushOperand:result];
    
    return result;
}

- (void)clearStack
{
    [self.operandStack removeAllObjects];
    self.operandStack = nil;
}

@end
