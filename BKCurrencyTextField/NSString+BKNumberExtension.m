//
//  NSString+BKNumberExtension.m
//  BKCurrencyTextFieldDemo
//
//  Created by Byungkook Jang on 2013. 11. 7..
//  Copyright (c) 2013년 Byungkook Jang. All rights reserved.
//

#import "NSString+BKNumberExtension.h"

static NSRegularExpression *_nonNumberRegularExpression;

@implementation NSString (BKNumberExtension)

+ (NSRegularExpression *)nonNumberRegularExpression
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nonNumberRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"[^0-9]" options:0 error:nil];
    });
    return _nonNumberRegularExpression;
}

- (NSString *)stringByRemovingNonNumericCharacters
{
    return [[[self class] nonNumberRegularExpression] stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
}

@end
