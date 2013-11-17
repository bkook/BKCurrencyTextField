//
//  BKCurrencyFormatter.m
//  BKCurrencyTextFieldDemo
//
//  Created by Byungkook Jang on 2013. 11. 18..
//  Copyright (c) 2013년 Byungkook Jang. All rights reserved.
//

#import "BKCurrencyFormatter.h"
#import "NSString+BKNumberExtension.h"

@implementation BKCurrencyFormatter

- (id)init
{
    self = [super init];
    if (self) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        _numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.textFieldDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.textFieldDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.textFieldDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.textFieldDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.textFieldDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        if (NO == [self.textFieldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string]) {
            return NO;
        }
    }
    
    NSString *oldString = textField.text;
    NSString *newString = [oldString stringByReplacingCharactersInRange:range withString:string];
    
    NSString *digits = [newString stringByRemovingNonNumericCharacters];
    
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:digits];
    
    if (self.numberFormatter.maximumFractionDigits > 0) {
        decimalNumber = [decimalNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithMantissa:1 exponent:self.numberFormatter.maximumFractionDigits isNegative:NO]];
    }
    
    // get current cursor position
    UITextRange* selectedRange = [textField selectedTextRange];
    UITextPosition* start = textField.beginningOfDocument;
    NSInteger cursorOffset = [textField offsetFromPosition:start toPosition:selectedRange.start];
    NSUInteger currentLength = oldString.length;
    
    // update text field
    [self.delegate currencyFormatter:self didUpdateNumber:decimalNumber];
    
    // if the cursor was not at the end of the string being entered, restore cursor position
    if (cursorOffset != currentLength) {
        NSInteger lengthDelta = newString.length - currentLength;
        NSInteger newCursorOffset = MAX(0, MIN(newString.length, cursorOffset + lengthDelta));
        UITextPosition* newPosition = [textField positionFromPosition:textField.beginningOfDocument offset:newCursorOffset];
        UITextRange* newRange = [textField textRangeFromPosition:newPosition toPosition:newPosition];
        [textField setSelectedTextRange:newRange];
    }
    
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.textFieldDelegate textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.textFieldDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

@end
