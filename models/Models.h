//
//  Models.h
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Error : NSObject

@property (strong, nonatomic) NSNumber *errorCode;
@property (strong, nonatomic) NSString *descriptionStr;

- (instancetype)initWithErrorCode:(NSNumber *)error description:(NSString *)desc;

@end;


@interface Payment : NSObject

@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSNumber *paymentId;
@property (strong, nonatomic) NSString *redirectUrl;

- (instancetype)initWithStatus:(NSString *)status paymentId:(NSNumber *)paymentId redirectUrl:(NSString *)redirectUrl;

@end;


@interface RecurringPayment : NSObject

@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSNumber *paymentId;
@property (strong, nonatomic) NSString *currency;
@property (assign, nonatomic) double amount;
@property (strong, nonatomic) NSString *recurringProfile;
@property (strong, nonatomic) NSString *recurringExpireDate;

- (instancetype)initWithStatus:(NSString *)status paymentId:(NSNumber *)paymentId currency:(NSString *)currency amount:(double)amount recurringProfile:(NSString *)recurringProfile recurringExpireDate:(NSString *)recurringExpireDate;

@end;


@interface Capture : NSObject

@property (strong, nonatomic) NSString *status;
@property (assign, nonatomic) double amount;
@property (assign, nonatomic) double clearingAmount;

- (instancetype)initWithStatus:(NSString *)status amount:(double)amount clearingAmount:(double)clearingAmount;

@end;


@interface Card : NSObject

@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *merchantId;
@property (strong, nonatomic) NSString *cardId;
@property (strong, nonatomic) NSString *recurringProfile;
@property (strong, nonatomic) NSString *cardhash;
@property (strong, nonatomic) NSString *date;

- (instancetype)initWithStatus:(NSString *)status merchantId:(NSString *)merchantId cardId:(NSString *)cardId recurringProfile:(NSString *)recurringProfile cardHash:(NSString *)cardHash date:(NSString *)date;

@end;


@interface RequestData : NSObject

@property (strong, nonatomic) NSArray *params;
@property (strong, nonatomic) NSString *method;
@property (strong, nonatomic) NSString *url;

- (instancetype)initWithParams:(NSArray *)params method:(NSString *)method url:(NSString *)url;

@end;


@interface ResponseData : NSObject

@property (strong, nonatomic) NSNumber *code;
@property (strong, nonatomic) NSString *response;
@property (strong, nonatomic) NSString *url;
@property (assign, nonatomic) BOOL error;

- (instancetype)initWithCode:(NSNumber *)code response:(NSString *)response url:(NSString *)url error:(BOOL)error;

@end;


@interface Status : NSObject

@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSNumber *paymentId;
@property (strong, nonatomic) NSString *transactionStatus;
@property (strong, nonatomic) NSString *canReject;
@property (strong, nonatomic) NSString *isCaptured;
@property (strong, nonatomic) NSString *cardPan;
@property (strong, nonatomic) NSString *createDate;

- (instancetype)initWithStatus:(NSString *)status paymentId:(NSNumber *)paymentId transactionStatus:(NSString *)transactionStatus canReject:(NSString *)canReject isCaptured:(NSString *)isCaptured cardPan:(NSString *)cardPan createDate:(NSString *)createDate;

@end;
