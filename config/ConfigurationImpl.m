//
//  ConfigurationImpl.m
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ConfigurationImpl.h"
#import "Constants.h"

@interface ConfigurationImpl()

@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, assign) BOOL testMode;
@property (nonatomic, strong) NSString *paymentSystem;
@property (nonatomic, strong) NSString *requestMethod;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, assign) BOOL autoClearing;
@property (nonatomic, strong) NSString *encoding;
@property (nonatomic, strong) NSNumber *paymentLifetime;
@property (nonatomic, strong) NSNumber *recurringLifetime;
@property (nonatomic, assign) BOOL recurringMode;
@property (nonatomic, strong) NSString *checkUrl;
@property (nonatomic, strong) NSString *resultUrl;
@property (nonatomic, strong) NSString *refundUrl;
@property (nonatomic, strong) NSString *captureUrl;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSString *successUrl;
@property (nonatomic, strong) NSString *failureUrl;

@end

@implementation ConfigurationImpl

- (instancetype)initWithMerchantId:(NSNumber *)merchantId {
    self = [super init];
    if (self) {
        self.merchantId = merchantId;
        self.testMode = YES;
        self.paymentSystem = @"EPAYWEBKZT";
        self.requestMethod = @"POST";
        self.language = @"ru";
        self.autoClearing = NO;
        self.encoding = @"UTF-8";
        self.paymentLifetime = [NSNumber numberWithInt:300];
        self.recurringLifetime = [NSNumber numberWithInt:36];
        self.recurringMode = NO;
        self.resultUrl = @"https://paybox.kz";
        self.currencyCode = @"KZT";
        self.successUrl = [NSString stringWithFormat:@"%@success", Urls.BASE_URL];
        self.failureUrl = [NSString stringWithFormat:@"%@failure", Urls.BASE_URL];
    }
    
    return self;
}

- (void)setUserPhone:(NSString *)userPhone {
    _userPhone = userPhone;
}

- (void)setUserEmail:(NSString *)userEmail {
    _userEmail = userEmail;
}

- (void)testMode:(BOOL)enabled {
    _testMode = enabled;
}

- (void)setPaymentSystem:(NSString *)paymentSystem {
    _paymentSystem = paymentSystem;
}

- (void)setRequestMethod:(NSString *)requestMethod {
    _requestMethod = requestMethod;
}

- (void)setLanguage:(NSString *)language {
    _language = language;
}

- (void)autoClearing:(BOOL)enabled {
    _autoClearing = enabled;
}

- (void)setEncoding:(NSString *)encoding {
    _encoding = encoding;
}

- (void)setRecurringLifetime:(NSNumber *)recurringLifetime {
    _recurringLifetime = recurringLifetime;
}

- (void)setPaymentLifetime:(NSNumber *)paymentLifetime {
    _paymentLifetime = paymentLifetime;
}

- (void)recurringMode:(BOOL)enabled {
    _recurringMode = enabled;
}

- (void)setCheckUrl:(NSString *)checkUrl {
    _checkUrl = checkUrl;
}

- (void)setResultUrl:(NSString *)resultUrl {
    _resultUrl = resultUrl;
}


- (void)setRefundUrl:(NSString *)refundUrl {
    _refundUrl = refundUrl;
}

- (void)setClearingUrl:(NSString *)url {
    _captureUrl = url;
}

- (void)setCurrencyCode:(NSString *)currencyCode {
    _currencyCode = currencyCode;
}

- (NSDictionary *)defParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[self.merchantId stringValue] forKey:Params.MERCHANT_ID];
    [params setObject:(self.testMode ? @"1" : @"0") forKey:Params.TEST_MODE];
    [params setObject:self.paymentSystem forKey:Params.PAYMENT_SYSTEM];
    
    return params;
}

- (NSDictionary *)getParamsWithExtraParams:(NSDictionary *)extraParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (extraParams != nil) {
        params = [NSMutableDictionary dictionaryWithDictionary:extraParams];
    }
    
    [params setObject:[self.merchantId stringValue] forKey:Params.MERCHANT_ID];
    [params setObject:(self.testMode ? @"1" : @"0") forKey:Params.TEST_MODE];
    [params setObject:(self.recurringMode ? @"1" : @"0") forKey:Params.RECURRING_START];
    [params setObject:(self.autoClearing ? @"1" : @"0") forKey:Params.AUTOCLEARING];
    [params setObject:self.requestMethod forKey:Params.REQUEST_METHOD];
    [params setObject:self.currencyCode forKey:Params.CURRENCY];
    [params setObject:[self.paymentLifetime stringValue] forKey:Params.LIFETIME];
    [params setObject:self.encoding forKey:Params.ENCODING];
    [params setObject:[self.recurringLifetime stringValue] forKey:Params.RECURRING_LIFETIME];
    [params setObject:self.paymentSystem forKey:Params.PAYMENT_SYSTEM];
    [params setObject:@"GET" forKey:Params.SUCCESS_METHOD];
    [params setObject:@"GET" forKey:Params.FAILURE_METHOD];
    [params setObject:self.successUrl forKey:Params.SUCCESS_URL];
    [params setObject:self.failureUrl forKey:Params.FAILURE_URL];
    [params setObject:self.successUrl forKey:Params.BACK_LINK];
    [params setObject:self.successUrl forKey:Params.POST_LINK];
    [params setObject:self.language forKey:Params.LANGUAGE];
    
    if (self.userPhone != nil) {
        [params setObject:self.userPhone forKey:Params.USER_PHONE];
    }
    
    if (self.userEmail != nil) {
        [params setObject:self.userEmail forKey:Params.USER_EMAIL];
        [params setObject:self.userEmail forKey:Params.USER_CONTACT_EMAIL];
    }
    
    if (self.captureUrl != nil) {
        [params setObject:self.captureUrl forKey:Params.CAPTURE_URL];
    }
    
    if (self.refundUrl != nil) {
        [params setObject:self.refundUrl forKey:Params.REFUND_URL];
    }
    
    if (self.resultUrl != nil) {
        [params setObject:self.resultUrl forKey:Params.RESULT_URL];
    }
    
    if (self.checkUrl != nil) {
        [params setObject:self.checkUrl forKey:Params.CHECK_URL];
    }
        
    return params;
}

@end
