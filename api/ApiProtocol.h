//
//  ApiProtocol.h
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import "Models.h"

@protocol ApiProtocol <NSObject>

@optional

- (void)onPaymentInited:(Payment *)payment error:(Error *)error;
- (void)onPaymentRevoked:(Payment *)payment error:(Error *)error;
- (void)onPaymentCanceled:(Payment *)payment error:(Error *)error;
- (void)onCapture:(Capture *)capture error:(Error *)error;
- (void)onPaymentStatus:(Status *)status error:(Error *)error;
- (void)onPaymentRecurring:(RecurringPayment *)recurringPayment error:(Error *)error;
- (void)onCardAdding:(Payment *)payment error:(Error *)error;
- (void)onCardListing:(NSArray *)cards error:(Error *)error;
- (void)onCardRemoved:(Card *)card error:(Error *)error;
- (void)onCardPayInited:(Payment *)payment error:(Error *)error;

@end
