//
//  BKCurrencyFormatter.h
//  BKCurrencyTextFieldDemo
//
//  Created by Byungkook Jang on 2013. 11. 18..
//  Copyright (c) 2013년 Byungkook Jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BKCurrencyFormatterDelegate;

@interface BKCurrencyFormatter : NSObject <UITextFieldDelegate>

@property (assign, nonatomic) id<BKCurrencyFormatterDelegate>   delegate;
@property (strong, nonatomic) NSNumberFormatter                 *numberFormatter;
@property (assign, nonatomic) id<UITextFieldDelegate>           textFieldDelegate;

@end


@protocol BKCurrencyFormatterDelegate <NSObject>

- (void)currencyFormatter:(BKCurrencyFormatter *)formatter didUpdateNumber:(NSDecimalNumber *)number;

@end