//
//  BKCurrencyTextField.m
//  BKCurrencyTextFieldDemo
//
//  Created by Byungkook Jang on 2013. 11. 7..
//  Copyright (c) 2013년 Byungkook Jang. All rights reserved.
//

#import "BKCurrencyTextField.h"

@interface BKCurrencyTextField ()

@property (strong, nonatomic) BKCurrencyFormatter         *currencyFormatter;

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
    self.currencyFormatter = [[BKCurrencyFormatter alloc] init];
    self.currencyFormatter.delegate = self;
    
    [super setDelegate:self.currencyFormatter];
    
    self.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    self.currencyFormatter.textFieldDelegate = delegate;
}

- (void)setLocale:(NSLocale *)locale
{
    self.currencyFormatter.numberFormatter.locale = locale;
}

- (NSLocale *)locale
{
    return self.currencyFormatter.numberFormatter.locale;
}

- (void)setNumberValue:(NSDecimalNumber *)numberValue
{
    if (nil == numberValue || [numberValue compare:[NSDecimalNumber zero]] == NSOrderedSame || [numberValue compare:[NSDecimalNumber notANumber]] == NSOrderedSame) {
        self.text = nil;
    } else {
        self.text = [self.currencyFormatter.numberFormatter stringFromNumber:numberValue];
    }
}

- (NSDecimalNumber *)numberValue
{
    if (self.text.length == 0) {
        return nil;
    }
    
    NSDecimal decimal = [self.currencyFormatter.numberFormatter numberFromString:self.text].decimalValue;
    return [NSDecimalNumber decimalNumberWithDecimal:decimal];
}

- (void)currencyFormatter:(BKCurrencyFormatter *)formatter didUpdateNumber:(NSDecimalNumber *)number
{
    self.numberValue = number;
}

@end
