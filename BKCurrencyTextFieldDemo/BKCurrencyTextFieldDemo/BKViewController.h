//
//  BKViewController.h
//  BKCurrencyTextFieldDemo
//
//  Created by Byungkook Jang on 2013. 11. 7..
//  Copyright (c) 2013년 Byungkook Jang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKCurrencyTextField.h"

@interface BKViewController : UIViewController

@property (weak, nonatomic) IBOutlet BKCurrencyTextField *firstTextField;
@property (weak, nonatomic) IBOutlet BKCurrencyTextField *secondTextField;
@property (weak, nonatomic) IBOutlet BKCurrencyTextField *thirdTextField;
@property (weak, nonatomic) IBOutlet BKCurrencyTextField *fourthTextField;
@property (weak, nonatomic) IBOutlet BKCurrencyTextField *fifthTextField;

@end
