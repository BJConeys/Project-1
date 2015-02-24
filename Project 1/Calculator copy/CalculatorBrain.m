//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Brendan Coneys on 1/31/15.
//  Copyright (c) 2015 Brendan Coneys. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ( )
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{

    if (!_operandStack)
    {
    
        _operandStack = [[NSMutableArray alloc] init];
    
    }
    return _operandStack;
    
}

-(void)clearOperandStack                    // operation to clear the opperand stack
{

    _operandStack = nil;                    // set the stack to nil so it is deleted, and must
                                            // reinitiate.
    
    NSNumber *operandObject = [NSNumber numberWithDouble: 0 ];

    [self.operandStack addObject:operandObject];    // call new stack, push a zero on the new stack.
    
}

- (void)pushOperand:(double)operand
{

    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];

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

    }
    else if ([@"*" isEqualToString:operation])
    {

        result = [self popOperand] * [self popOperand];
    
    }
    else if ([@"-" isEqualToString:operation])
    {

        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;

    }
    else if ([@"/" isEqualToString:operation])
    {

        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;

    }
    else if ([@"sin" isEqualToString:operation])        // implement Sine.
    {
	
        result = sin([self popOperand]);

    }
    else if ([@"cos" isEqualToString:operation])        // implement Cosine.
    {

        result = cos([self popOperand]);

    }else if ([@"sqrt" isEqualToString:operation])      // implement Square root
    {

        double square = [self popOperand];              // set the first number in the stack as the
                                                        // value of the variable square.

        if (square >= 0)                                // If square is positive then the function
                                                        // works as normal.
        {
        
        result = sqrt(square);

        }
        else                                            // Else we return 0, because there are no
                                                        // real square roots of negative numbers.
        {

            result = 0;

        }
    }
    
    [self pushOperand:result];
    
    return result;

}

@end