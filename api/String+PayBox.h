//
//  String+PayBox.h
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import "Models.h"

@interface NSString (PayBox)

- (NSString *)md5;

- (NSString *)getStringValue:(NSString *)key;

- (double)getFloatValue:(NSString *)key;

- (NSNumber *)getIntValue:(NSString *)key;

- (Payment *)getPayment;

- (RecurringPayment *)getRecurringPayment;

- (Card *)getCard;

- (NSArray *)getCards;

- (Status *)getStatus;

- (Capture *)getCapture;

@end
