//
//  Models.m
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Models.h"

@implementation Error : NSObject

- (instancetype)initWithErrorCode:(NSNumber *)error description:(NSString *)desc {
    self = [super init];
    if (self) {
        self.errorCode = error;
        self.descriptionStr = desc;
    }
    
    return self;
}

@end;


@implementation Payment : NSObject

- (instancetype)initWithStatus:(NSString *)status paymentId:(NSNumber *)paymentId redirectUrl:(NSString *)redirectUrl {
    self = [super init];
    if (self) {
        self.status = status;
        self.paymentId = paymentId;
        self.redirectUrl = redirectUrl;
    }
    
    return self;
}

@end;


@implementation RecurringPayment : NSObject

- (instancetype)initWithStatus:(NSString *)status paymentId:(NSNumber *)paymentId currency:(NSString *)currency amount:(double)amount recurringProfile:(NSString *)recurringProfile recurringExpireDate:(NSString *)recurringExpireDate {
    self = [super init];
    if (self) {
        self.status = status;
        self.paymentId = paymentId;
        self.currency = currency;
        self.amount = amount;
        self.recurringProfile = recurringProfile;
        self.recurringExpireDate = recurringExpireDate;
    }
    
    return self;
}

@end;


@implementation Capture : NSObject

- (instancetype)initWithStatus:(NSString *)status amount:(double)amount clearingAmount:(double)clearingAmount {
    self = [super init];
    if (self) {
        self.status = status;
        self.amount = amount;
        self.clearingAmount = clearingAmount;
    }
    
    return self;
}

@end;


@implementation Card : NSObject

- (instancetype)initWithStatus:(NSString *)status merchantId:(NSString *)merchantId cardId:(NSString *)cardId recurringProfile:(NSString *)recurringProfile cardHash:(NSString *)cardHash date:(NSString *)date {
    self = [super init];
    if (self) {
        self.status = status;
        self.merchantId = merchantId;
        self.cardId = cardId;
        self.recurringProfile = recurringProfile;
        self.cardhash = cardHash;
        self.date = date;
    }
    
    return self;
}

@end;


@implementation RequestData : NSObject

- (instancetype)initWithParams:(NSArray *)params method:(NSString *)method url:(NSString *)url {
    self = [super init];
    if (self) {
        self.params = params;
        self.method = method;
        self.url = url;
    }
    
    return self;
}

@end;


@implementation ResponseData : NSObject

- (instancetype)initWithCode:(NSNumber *)code response:(NSString *)response url:(NSString *)url error:(BOOL)error {
    self = [super init];
    if (self) {
        self.code = code;
        self.response = response;
        self.url = url;
        self.error = error;
    }
    
    return self;
}

@end;


@implementation Status : NSObject

- (instancetype)initWithStatus:(NSString *)status paymentId:(NSNumber *)paymentId transactionStatus:(NSString *)transactionStatus canReject:(NSString *)canReject isCaptured:(NSString *)isCaptured cardPan:(NSString *)cardPan createDate:(NSString *)createDate {
    self = [super init];
    if (self) {
        self.status = status;
        self.paymentId = paymentId;
        self.transactionStatus = transactionStatus;
        self.canReject = canReject;
        self.isCaptured = isCaptured;
        self.cardPan = cardPan;
        self.createDate = createDate;
    }
    
    return self;
}

@end;

