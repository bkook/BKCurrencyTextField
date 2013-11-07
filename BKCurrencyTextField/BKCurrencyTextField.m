//
//  BKCurrencyTextField.m
//  BKCurrencyTextFieldDemo
//
//  Created by Byungkook Jang on 2013. 11. 7..
//  Copyright (c) 2013년 Byungkook Jang. All rights reserved.
//

#import "BKCurrencyTextField.h"
#import "NSString+BKNumberExtension.h"

@interface BKCurrencyTextField ()

@property (assign, nonatomic) id<UITextFieldDelegate>   forwardDelegate;
@property (strong, nonatomic) NSNumberFormatter         *numberFormatter;

@end

@implementation BKCurrencyTextField

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [super setDelegate:self];
    
    self.keyboardType = UIKeyboardTypeDecimalPad;
    
    _numberFormatter = [[NSNumberFormatter alloc] init];
    _numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    _forwardDelegate = delegate;
}

- (void)setLocale:(NSLocale *)locale
{
    _numberFormatter.locale = locale;
}

- (NSLocale *)locale
{
    return _numberFormatter.locale;
}

- (void)setNumberValue:(NSDecimalNumber *)numberValue
{
    if (nil == numberValue || [numberValue compare:[NSDecimalNumber zero]] == NSOrderedSame || [numberValue compare:[NSDecimalNumber notANumber]] == NSOrderedSame) {
        self.text = nil;
    } else {
        self.text = [self.numberFormatter stringFromNumber:numberValue];
    }
}

- (NSDecimalNumber *)numberValue
{
    if (self.text.length == 0) {
        return nil;
    }
    
    NSDecimal decimal = [self.numberFormatter numberFromString:self.text].decimalValue;
    return [NSDecimalNumber decimalNumberWithDecimal:decimal];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.forwardDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.forwardDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.forwardDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.forwardDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.forwardDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.forwardDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.forwardDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.forwardDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.forwardDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        if (NO == [self.forwardDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string]) {
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
    self.numberValue = decimalNumber;
    
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
    if ([self.forwardDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.forwardDelegate textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.forwardDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.forwardDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

#pragma mark - NPInputAccessoryToolbarDelegate

- (void)clearButtonPressed:(id)sender
{
    self.numberValue = nil;
}

- (void)closeButtonPressed:(id)sender
{
    [self endEditing:YES];
}

@end
