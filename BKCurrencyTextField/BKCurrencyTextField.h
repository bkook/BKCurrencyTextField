//
//  BKCurrencyTextField.h
//  BKCurrencyTextFieldDemo
//
//  Created by Byungkook Jang on 2013. 11. 7..
//  Copyright (c) 2013년 Byungkook Jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKCurrencyTextField : UITextField <UITextFieldDelegate>

@property (strong, nonatomic) NSDecimalNumber               *numberValue;
@property (strong, nonatomic, readonly) NSNumberFormatter   *numberFormatter;
@property (strong, nonatomic) NSLocale                      *locale;

@end
