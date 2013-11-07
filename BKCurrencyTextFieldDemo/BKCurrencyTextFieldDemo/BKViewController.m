//
//  BKViewController.m
//  BKCurrencyTextFieldDemo
//
//  Created by Byungkook Jang on 2013. 11. 7..
//  Copyright (c) 2013년 Byungkook Jang. All rights reserved.
//

#import "BKViewController.h"

@interface BKViewController ()

@end

@implementation BKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.secondTextField.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    self.thirdTextField.locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
    self.fourthTextField.locale = [NSLocale localeWithLocaleIdentifier:@"ko_KR"];
    self.fifthTextField.locale = [NSLocale localeWithLocaleIdentifier:@"ja_JP"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
