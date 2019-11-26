//
//  PayBoxSdk.m
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PayBoxSdk.h"
#import "SignHelper.h"
#import "ApiProtocol.h"
#import "ConfigurationImpl.h"
#import "ApiHelper.h"
#import "Constants.h"

@interface PayBoxSdk() <ApiProtocol>

@property (strong, nonatomic) ConfigurationImpl *configs;
@property (strong, nonatomic) ApiHelper *apiHelper;
@property (weak, nonatomic) PayBoxPaymentView *paymentView;

@property (copy) void (^paymentClearing)(Capture *, Error *);
@property (copy) void (^cardRemove)(Card *, Error *);
@property (copy) void (^paymentRecurring)(RecurringPayment *, Error *);
@property (copy) void (^paymentCancel)(Payment *, Error *);
@property (copy) void (^paymentRevoke)(Payment *, Error *);
@property (copy) void (^paymentStatus)(Status *, Error *);
@property (copy) void (^paymentPaid)(Payment *, Error *);
@property (copy) void (^cardAdded)(Payment *, Error *);
@property (copy) void (^cardList)(NSArray *, Error *);
@property (copy) void (^cardPayInited)(Payment *, Error *);

@end

@implementation PayBoxSdk

- (instancetype)initWithMerchantId:(NSNumber *)merchantId secretKey:(NSString *)secretKey {
    self = [super initWithSecretKey:secretKey];
    if (self) {
        self.apiHelper = [[ApiHelper alloc] init:secretKey listener:self];
        self.configs = [[ConfigurationImpl alloc] initWithMerchantId:merchantId];
    }
    
    return self;
}

- (PayBoxSdk *)initializeWithMerchantId:(NSNumber *)merchantId secretKey:(NSString *)secretKey {
    return [[PayBoxSdk alloc] initWithMerchantId:merchantId secretKey:secretKey];
}

- (void)setPaymentView:(PayBoxPaymentView *)paymentView {
    _paymentView = paymentView;
}

- (void)createPayment:(double)amount description:(NSString *)description orderId:(NSString *)orderId userId:(NSString *)userId extraParams:(NSDictionary *)extraParams paymentPaid:(void (^)(Payment *, Error *))paymentPaid {
    self.paymentPaid = paymentPaid;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:extraParams]];
    
    [params setObject:[NSString stringWithFormat:@"%.0f", amount] forKey:Params.AMOUNT];
    [params setObject:description forKey:Params.DESCRIPTION];
    if (orderId != nil) {
        [params setObject:orderId forKey:Params.ORDER_ID];
    }
    if (userId != nil) {
        [params setObject:userId forKey:Params.USER_ID];
    }
    [self.apiHelper initConnection:Urls.INIT_PAYMENT_URL params:params];
}

- (void)createRecurringPayment:(double)amount description:(NSString *)description recurringProfile:(NSString *)recurringProfile orderId:(NSString *)orderId extraParams:(NSDictionary *)extraParams recurringPaid:(void (^)(RecurringPayment *, Error *))recurringPaid {
    self.paymentRecurring = recurringPaid;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:extraParams]];
    
    if (orderId != nil) {
        [params setObject:orderId forKey:Params.ORDER_ID];
    }
    [params setObject:[NSString stringWithFormat:@"%.0f", amount] forKey:Params.AMOUNT];
    [params setObject:description forKey:Params.DESCRIPTION];
    [params setObject:recurringProfile forKey:Params.RECURRING_PROFILE];
    [self.apiHelper initConnection:Urls.RECURRING_URL params:params];
}

- (void)createCardPayment:(double)amount userId:(NSString *)userId cardId:(NSNumber *)cardId description:(NSString *)description orderId:(NSString *)orderId extraParams:(NSDictionary *)extraParams payInited:(void (^)(Payment *, Error *))payInited {
    self.cardPayInited = payInited;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:extraParams]];
    
    [params setObject:orderId forKey:Params.ORDER_ID];
    [params setObject:[NSString stringWithFormat:@"%.0f", amount] forKey:Params.AMOUNT];
    [params setObject:userId forKey:Params.USER_ID];
    [params setObject:cardId forKey:Params.CARD_ID];
    [params setObject:description forKey:Params.DESCRIPTION];
    [self.apiHelper initConnection:[[Urls CARD_PAY:self.configs.merchantId] stringByAppendingString:Urls.CARDINITPAY] params:params];
}

- (void)payByCard:(NSNumber *)paymentId paymentPaid:(void (^)(Payment *, Error *))paymentPaid {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs defParams]];
    
    [params setObject:paymentId forKey:Params.PAYMENT_ID];
    NSString *url = [NSString stringWithFormat:@"%@%@?", [Urls CARD_PAY:self.configs.merchantId], Urls.PAY];
    NSArray *signedParams = [self signedParamsWithUrl:Urls.PAY array:params];
    for (int i = 0; i < signedParams.count; i++) {
        NSString *key = [signedParams[i] objectForKey:@"key"];
        NSString *value = [signedParams[i] objectForKey:@"value"];
        url = [NSString stringWithFormat:@"%@%@=%@&", url, key, value];
    }
    [self.paymentView loadPaymentPage:url successOrFailure:^(BOOL isSuccess) {
        if (isSuccess) {
            self.paymentPaid([[Payment alloc] initWithStatus:@"success" paymentId:nil redirectUrl:nil], nil);
        } else {
            self.paymentPaid(nil, [[Error alloc] initWithErrorCode:@(10) description:Params.PAYMENT_FAILURE]);
        }
    }];
}

- (void)getPaymentStatus:(NSNumber *)paymentId statusReceived:(void (^)(Status *, Error *))statusReceived {
    self.paymentStatus = statusReceived;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:nil]];
    
    [params setObject:paymentId forKey:Params.PAYMENT_ID];
    [self.apiHelper initConnection:Urls.STATUS_URL params:params];
}

- (void)makeRevokePayment:(NSNumber *)paymentId amount:(double)amount revoked:(void (^)(Payment *, Error *))revoked {
    self.paymentRevoke = revoked;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:nil]];
    
    [params setObject:paymentId forKey:Params.PAYMENT_ID];
    [params setObject:[NSNumber numberWithDouble:amount] forKey:Params.REFUND_AMOUNT];
    [self.apiHelper initConnection:Urls.REVOKE_URL params:params];
}

- (void)makeClearingPayment:(NSNumber *)paymentId amount:(double)amount cleared:(void (^)(Capture *, Error *))cleared {
    self.paymentClearing = cleared;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:nil]];
    
    [params setObject:paymentId forKey:Params.PAYMENT_ID];
    if (amount != 0) {
        [params setObject:[NSNumber numberWithDouble:amount] forKey:Params.CLEARING_AMOUNT];
    }
    [self.apiHelper initConnection:Urls.CLEARING_URL params:params];
}

- (void)makeCancelPayment:(NSNumber *)paymentId canceled:(void (^)(Payment *, Error *))canceled {
    self.paymentCancel = canceled;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:nil]];
    
    [params setObject:paymentId forKey:Params.PAYMENT_ID];
    [self.apiHelper initConnection:Urls.CANCEL_URL params:params];
}

- (void)addNewCard:(NSString *)postLink userId:(NSString *)userId cardAdded:(void (^)(Payment *, Error *))cardAdded {
    self.cardAdded = cardAdded;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:nil]];
    
    [params setObject:userId forKey:Params.USER_ID];
    if (postLink != nil) {
        [params setObject:postLink forKey:Params.POST_LINK];
    }
    [self.apiHelper initConnection:[[Urls CARD_MERCHANT:self.configs.merchantId] stringByAppendingString:Urls.ADDCARD_URL] params:params];
}

- (void)removeAddedCard:(NSNumber *)cardId userId:(NSString *)userId removed:(void (^)(Card *, Error *))removed {
    self.cardRemove = removed;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:nil]];
    
    [params setObject:cardId forKey:Params.CARD_ID];
    [params setObject:userId forKey:Params.USER_ID];
    [self.apiHelper initConnection:[[Urls CARD_MERCHANT:self.configs.merchantId] stringByAppendingString:Urls.REMOVECARD_URL] params:params];
}

- (void)getAddedCards:(NSString *)userId cardList:(void (^)(NSArray *, Error *))cardList {
    self.cardList = cardList;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self.configs getParamsWithExtraParams:nil]];
    
    [params setObject:userId forKey:Params.USER_ID];
    [self.apiHelper initConnection:[[Urls CARD_MERCHANT:self.configs.merchantId] stringByAppendingString:Urls.LISTCARD_URL] params:params];
}

- (ConfigurationImpl *)config {
    return _configs;
}

- (void)onPaymentInited:(Payment *)payment error:(Error *)error {
    if (payment.redirectUrl != nil) {
        [self.paymentView loadPaymentPage:payment.redirectUrl successOrFailure:^(BOOL isSuccess) {
            if (isSuccess) {
                self.paymentPaid(payment, nil);
            } else {
                self.paymentPaid(nil, [[Error alloc] initWithErrorCode:@(10) description:Params.PAYMENT_FAILURE]);
            }
        }];
    }
}

- (void)onPaymentRevoked:(Payment *)payment error:(Error *)error {
    self.paymentRevoke(payment, error);
}

- (void)onPaymentCanceled:(Payment *)payment error:(Error *)error {
    self.paymentCancel(payment, error);
}

- (void)onCapture:(Capture *)capture error:(Error *)error {
    self.paymentClearing(capture, error);
}

- (void)onPaymentStatus:(Status *)status error:(Error *)error {
    self.paymentStatus(status, error);
}

- (void)onPaymentRecurring:(RecurringPayment *)recurringPayment error:(Error *)error {
    self.paymentRecurring(recurringPayment, error);
}

- (void)onCardAdding:(Payment *)payment error:(Error *)error {
    if (payment.redirectUrl != nil) {
        [self.paymentView loadPaymentPage:payment.redirectUrl successOrFailure:^(BOOL isSuccess) {
            if (isSuccess) {
                self.cardAdded(payment, nil);
            } else {
                self.cardAdded(nil, [[Error alloc] initWithErrorCode:@(10) description:Params.PAYMENT_FAILURE]);
            }
        }];
    }
}

- (void)onCardListing:(NSArray *)cards error:(Error *)error {
    self.cardList(cards, error);
}

- (void)onCardRemoved:(Card *)card error:(Error *)error {
    self.cardRemove(card, error);
}

- (void)onCardPayInited:(Payment *)payment error:(Error *)error {
    self.cardPayInited(payment, error);
}

@end
