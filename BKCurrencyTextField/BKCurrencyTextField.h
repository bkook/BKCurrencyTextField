//
//  BKCurrencyTextField.h
//  BKCurrencyTextFieldDemo
//
//  Created by Byungkook Jang on 2013. 11. 7..
//  Copyright (c) 2013년 Byungkook Jang. All rights reserved.
//

#warning This library is deprecated and no longer maintained. Please use BKMoneyKit ( https://github.com/bkook/BKMoneyKit )

#import <UIKit/UIKit.h>
#import "BKCurrencyFormatter.h"

@interface BKCurrencyTextField : UITextField <UITextFieldDelegate, BKCurrencyFormatterDelegate>

@property (strong, nonatomic) NSDecimalNumber               *numberValue;
@property (strong, nonatomic) NSLocale                      *locale;

@end
