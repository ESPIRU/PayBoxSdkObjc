//
//  String+PayBox.m
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

#import "String+PayBox.h"
#import "Models.h"
#import "Constants.h"

@implementation NSString (PayBox)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (int)strlen(cStr), digest );

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;
}


- (NSString *)getStringValue:(NSString *)key {
    NSString *value = nil;
    
    NSArray *argSt = [self componentsSeparatedByString:[NSString stringWithFormat:@"<%@>", key]];
    if (argSt.count > 1) {
        value = [argSt[1] componentsSeparatedByString:[NSString stringWithFormat:@"</%@>", key]][0];
    }
    
    return value;
}

- (double)getFloatValue:(NSString *)key {
    double value = 0;
    
    NSArray *argSt = [self componentsSeparatedByString:[NSString stringWithFormat:@"<%@>", key]];
    if (argSt.count > 1) {
        NSString *string = [argSt[1] componentsSeparatedByString:[NSString stringWithFormat:@"</%@>", key]][0];
        value = [string doubleValue];
    }
    
    return value;
}

- (NSNumber *)getIntValue:(NSString *)key {
    NSNumber *value;
    
    NSArray *argSt = [self componentsSeparatedByString:[NSString stringWithFormat:@"<%@>", key]];
    if (argSt.count > 1) {
        NSString *string = [argSt[1] componentsSeparatedByString:[NSString stringWithFormat:@"</%@>", key]][0];
        value = @([string intValue]);
    }
    
    return value;
}

- (Payment *)getPayment {
    return [[Payment alloc] initWithStatus:[self getStringValue:Params.STATUS]
                                 paymentId:[self getIntValue:Params.PAYMENT_ID]
                               redirectUrl:[self getStringValue:Params.REDIRECT_URL]];
}

- (RecurringPayment *)getRecurringPayment {
    return [[RecurringPayment alloc] initWithStatus:[self getStringValue:Params.STATUS]
                                          paymentId:[self getIntValue:Params.PAYMENT_ID]
                                           currency:[self getStringValue:Params.CURRENCY]
                                             amount:[self getFloatValue:Params.AMOUNT]
                                   recurringProfile:[self getStringValue:Params.RECURRING_PROFILE]
                                recurringExpireDate:[self getStringValue:Params.RECURRING_PROFILE_EXPIRY]];
}

- (Card *)getCard {
    return [[Card alloc] initWithStatus:[self getStringValue:Params.STATUS]
                             merchantId:[self getStringValue:Params.MERCHANT_ID]
                                 cardId:[self getStringValue:Params.CARD_ID]
                       recurringProfile:[self getStringValue:Params.RECURRING_PROFILE_ID]
                               cardHash:[self getStringValue:Params.CARD_HASH]
                                   date:[self getStringValue:Params.CARD_CREATED_AT]];
}

- (NSArray *)getCards {
    NSMutableArray *cards = [NSMutableArray array];
    
    NSArray *arraySt = [self componentsSeparatedByString:@"<card>"];
    if (arraySt.count > 1) {
        for (int i = 0; i < arraySt.count; i++) {
            NSString *arrayF = [arraySt[(i)] componentsSeparatedByString:@"</card>"][0];
            [cards addObject:[arrayF getCard]];
        }
    }
    
    return cards;
}

- (Status *)getStatus {
    return [[Status alloc] initWithStatus:[self getStringValue:Params.STATUS]
                                paymentId:[self getIntValue:Params.PAYMENT_ID]
                        transactionStatus:[self getStringValue:Params.TRANSACTION_STATUS]
                                canReject:[self getStringValue:Params.CAN_REJECT]
                               isCaptured:[self getStringValue:Params.CAPTURED]
                                  cardPan:[self getStringValue:Params.CARD_PAN]
                               createDate:[self getStringValue:Params.CREATED_AT]];
}

- (Capture *)getCapture {
    return [[Capture alloc] initWithStatus:[self getStringValue:Params.STATUS]
                                    amount:[self getFloatValue:Params.AMOUNT]
                            clearingAmount:[self getFloatValue:Params.CLEARING_AMOUNT]];
}

@end
