//
//  ViewController.m
//  Calculator
//
//  Created by Brendan Coneys on 1/31/15.
//  Copyright (c) 2015 Brendan Coneys. All rights reserved.
//
// I have no clue if half of this works even because the blasted self.(labelName).text bug keeps me from
// building, so I have no good way to test any of this... I just pray that it will work for me, as I
// am still getting the hang of the new language, and have been relying heavily on google to help me
// find and understand how to manipulate the strings as needed... (unsure if commands match both my
// current, and the grader's current versions of XCode... Hope for the best there then!!!)
// Also, I was planning on making a function for the management of the input log, but was unsure how to
// go about it, making the code a good bit bigger... Anyhoo, here's to hoping this works!

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;

@property (nonatomic) BOOL decimalPointEnteredInNumber;     // Tracks if there's a decimal point in a
                                                            // number already.

@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation ViewController

@synthesize display = _display;
@synthesize inputLog = _inputLog;                           //Synthesize the input log.
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize decimalPointEnteredInNumber = _decimalPointEnteredInNumber; //synthesize the decimal BOOL.
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{

    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;

}

- (IBAction)clearPressed:(UIButton *)sender
{

    self.display.text = @"0";                       // reset digit display
    self.inputLog.text = @"C ";                     // reset input log
    self.userIsInTheMiddleOfEnteringANumber = NO;   // reset the BOOLs
    self.decimalPointEnteredInNumber = NO;
    
    [self.brain clearOperandStack];                 // clear the operand stack

}

- (IBAction)backSpacePressed:(UIButton *)sender
{

    if ([self.display.text hasSuffix:@"."])         //If we're about to delete a decimal,
    {

        self.display.text = [self.display.text substringToIndex:[self.display.text length] -1];
        // cut off the last character from the string.
        
        self.decimalPointEnteredInNumber = No;      //Reset the bool.
    }
    else                                            // else just delete the digit.
    {
        self.display.text = [self.display.text substringToIndex:[self.display.text length] -1];
        // cut off the last character from the string.
    }
    
    if (!self.display.text)                         // If the string is empty after that,
    {

        self.display.text = @"0";                   // set the string to 0,
        
        self.userIsInTheMiddleOfEnteringANumber = NO;   //and reset the bool.

    }

}

- (IBAction)negativeTogglePressed:(UIButton *)sender
{

    NSRange match;                                      //We set up to search the string on the display.

    match = [self.display.text rangeOfString: @"-"];    //Search for the negative sign

    if (match.location == NSNotFound)                   //If it's not there, add one to the front,
    {

        [self.display.text insertString: @"-" atIndex: 0];

    }
    else                                                //else we go ahead and delete it.
    {

        [self.display.text deleteCharactersInRange: [self.display.text rangeOfString: @"-"]];

    }

}

- (IBAction)digitPressed:(UIButton *)sender
{

    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        
        self.display.text = [self.display.text stringByAppendingString:digit];
        
        
      //  self.display.text = [self.display.text stringByAppendingString:digit];

    }
    else
    {
    
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    
    }
}
- (IBAction)decimalPressed:(UIButton *)sender
{

    if (self.userIsInTheMiddleOfEnteringANumber)            // If the user's already entering a number,
    {

            if (!self.decimalPointEnteredInNumber)          // and if we don't already have a decimal,
            {

                self.display.text = [self.display.text stringByAppendingString:@"."];
                    // stick the decimal in there.

            }

    }
    else                                                    // Else start with "0." and set the BOOL
                                                            //userIsInTheMiddleOfEnteringANumber to YES.
    {

        self.display.text = [self.display.text stringByAppendingString:@"0."];

        self.userIsInTheMiddleOfEnteringANumber = YES;

    }
    
}

- (IBAction)piPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
            // Clears the way so that pi can be entered without being attatched to the end of
            // other numbers.

    }
    
    self.display.text = @"π";
        // Print the π symbol to the screen, so that users know that pi was entered.

    if (self.inputLog.text > 25)    //If the input log is crowded, clear some room and append π
    {

        BOOL result;
        
        result = [self.inputLog.text hasPrefix: @" "];  //check if the first character is a space.

        while (!self.result)             // while the first character isn't a space, delete it.
        {

            self.inputlog.text = [self.inputLog.text substringFromIndex:1];

        }

        self.inputLog.text = [self.inputLog.text substringFromIndex:1]; //delete that space after so we
                                                                        //start with a real number/input
        
        self.inputLog.text = [self.display.text stringByAppendingString:@"π "];
        // Append the π symbol to the input log.
    }
    else                            //else we just append π to the input display.
    {
    
        self.inputLog.text = [self.display.text stringByAppendingString:@"π "];
            // Append the π symbol to the input log.
    }

    [self.brain pushOperand:3.14159265359];
        // Push a portion of the value for pi onto the operand stack.
        // This ought to be more detail than the calculator even displays...
    
        // This portion of the code mimics enterpressed. the Bool that says we
        // are entering a number should already be at NO, because of the enterPressed we called
        // before adding pi to the operand stack, and it enters π to the input log.

}

- (IBAction)enterPressed
{

    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;

    if (self.inputLog.text > 25)    //If the input log is crowded, clear some room and append the number
    {
        
        BOOL result;
        
        result = [self.inputLog.text hasPrefix: @" "];  //check if the first character is a space.
        
        while (!self.result)             // while the first character isn't a space, delete it.
        {
            
            self.inputlog.text = [self.inputLog.text substringFromIndex:1];
            
        }
        
        self.inputLog.text = [self.inputLog.text substringFromIndex:1]; //delete that space so we
        //start with a real number/input
        
        self.inputLog.text = [self.display.text stringByAppendingString:self.display.text];
        // Append the number to the input log.
        
        self.inputLog.text = [self.inputLog.text stringByAppendString:@" "];
        // Add a space to the end to keep things seperate.
    }
    else                            //else we just append to the input display.
    {
        
        self.inputLog.text = [self.display.text stringByAppendingString:self.display.text];
        // Append the number to the input log.

        self.inputLog.text = [self.inputLog.text stringByAppendString:@" "];
        // Add a space to the end to keep things seperate.
    
    }

}

- (IBAction)opperationPressed:(UIButton *)sender
{

    if (self.userIsInTheMiddleOfEnteringANumber)
    {

        [self enterPressed];
    
    }
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];

    if (self.inputLog.text > 25)    //If the input log is crowded, clear some room and append the number
    {
        
        BOOL result;
        
        result = [self.inputLog.text hasPrefix: @" "];  //check if the first character is a space.
        
        while (!self.result)             // while the first character isn't a space, delete it.
        {
            
            self.inputlog.text = [self.inputLog.text substringFromIndex:1];
            
        }
        
        self.inputLog.text = [self.inputLog.text substringFromIndex:1]; //delete that space so we
        //start with a real number/input
        
        self.inputLog.text = [self.display.text stringByAppendingString:operation];
        // Append the operation to the input log.
        
        self.inputLog.text = [self.inputLog.text stringByAppendString:@" = "];
        // Add a space, and an enter sign to show the next number was calculated.

        self.inputLog.text = [self.display.text stringByAppendingString:result];
        // append the operation's result.
        
        self.inputLog.text = [self.inputLog.text stringByAppendString:@" "];
        // append a space to seperate from the next thing entered.
        
    }
    else                            //else we just append to the input display.
    {
        
        self.inputLog.text = [self.display.text stringByAppendingString:operation];
        // Append the operation to the input log.
        
        self.inputLog.text = [self.inputLog.text stringByAppendString:@" = "];
        // Add a space, and an enter sign to show the next number was calculated.
        
        self.inputLog.text = [self.display.text stringByAppendingString:result];
        // append the operation's result.
        
        self.inputLog.text = [self.inputLog.text stringByAppendString:@" "];
        // append a space to seperate from the next thing entered.

    }
    
}

@end
