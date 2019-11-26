//
//  Constants.h
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/18/19.
//  Copyright © 2019 espiru. All rights reserved.
//

@interface Urls : NSObject

@property (class, nonatomic, assign, readonly) NSString *BASE_URL;
@property (class, nonatomic, assign, readonly) NSString *STATUS_URL;
@property (class, nonatomic, assign, readonly) NSString *INIT_PAYMENT_URL;
@property (class, nonatomic, assign, readonly) NSString *REVOKE_URL;
@property (class, nonatomic, assign, readonly) NSString *CANCEL_URL;
@property (class, nonatomic, assign, readonly) NSString *CLEARING_URL;
@property (class, nonatomic, assign, readonly) NSString *RECURRING_URL;
@property (class, nonatomic, assign, readonly) NSString *CARDSTORAGE;
@property (class, nonatomic, assign, readonly) NSString *CARD;
@property (class, nonatomic, assign, readonly) NSString *LISTCARD_URL;
@property (class, nonatomic, assign, readonly) NSString *CARDINITPAY;
@property (class, nonatomic, assign, readonly) NSString *ADDCARD_URL;
@property (class, nonatomic, assign, readonly) NSString *PAY;
@property (class, nonatomic, assign, readonly) NSString *REMOVECARD_URL;

+ (NSString *)CARD_PAY:(NSNumber *)merchantId;
+ (NSString *)CARD_MERCHANT:(NSNumber *)merchantId;

@end


@interface Params : NSObject

@property (class, nonatomic, assign, readonly) NSString *RECURRING_PROFILE_ID;
@property (class, nonatomic, assign, readonly) NSString *CARD_CREATED_AT;
@property (class, nonatomic, assign, readonly) NSString *RESPONSE;
@property (class, nonatomic, assign, readonly) NSString *PAYMENT_FAILURE;
@property (class, nonatomic, assign, readonly) NSString *UNKNOWN_ERROR;
@property (class, nonatomic, assign, readonly) NSString *CONNECTION_ERROR;
@property (class, nonatomic, assign, readonly) NSString *FORMAT_ERROR;
@property (class, nonatomic, assign, readonly) NSString *RECURRING_PROFILE_EXPIRY;
@property (class, nonatomic, assign, readonly) NSString *CLEARING_AMOUNT;
@property (class, nonatomic, assign, readonly) NSString *REFUND_AMOUNT;
@property (class, nonatomic, assign, readonly) NSString *ERROR_CODE;
@property (class, nonatomic, assign, readonly) NSString *ERROR_DESCRIPTION;
@property (class, nonatomic, assign, readonly) NSString *CAPTURED;
@property (class, nonatomic, assign, readonly) NSString *CARD_PAN;
@property (class, nonatomic, assign, readonly) NSString *CREATED_AT;
@property (class, nonatomic, assign, readonly) NSString *TRANSACTION_STATUS;
@property (class, nonatomic, assign, readonly) NSString *CAN_REJECT;
@property (class, nonatomic, assign, readonly) NSString *REDIRECT_URL;
@property (class, nonatomic, assign, readonly) NSString *MERCHANT_ID;
@property (class, nonatomic, assign, readonly) NSString *SIG;
@property (class, nonatomic, assign, readonly) NSString *SALT;
@property (class, nonatomic, assign, readonly) NSString *STATUS;
@property (class, nonatomic, assign, readonly) NSString *CARD_ID;
@property (class, nonatomic, assign, readonly) NSString *CARD_HASH;
@property (class, nonatomic, assign, readonly) NSString *TEST_MODE;
@property (class, nonatomic, assign, readonly) NSString *RECURRING_START;
@property (class, nonatomic, assign, readonly) NSString *AUTOCLEARING;
@property (class, nonatomic, assign, readonly) NSString *REQUEST_METHOD;
@property (class, nonatomic, assign, readonly) NSString *CURRENCY;
@property (class, nonatomic, assign, readonly) NSString *LIFETIME;
@property (class, nonatomic, assign, readonly) NSString *ENCODING;
@property (class, nonatomic, assign, readonly) NSString *RECURRING_LIFETIME;
@property (class, nonatomic, assign, readonly) NSString *PAYMENT_SYSTEM;
@property (class, nonatomic, assign, readonly) NSString *SUCCESS_METHOD;
@property (class, nonatomic, assign, readonly) NSString *FAILURE_METHOD;
@property (class, nonatomic, assign, readonly) NSString *SUCCESS_URL;
@property (class, nonatomic, assign, readonly) NSString *FAILURE_URL;
@property (class, nonatomic, assign, readonly) NSString *BACK_LINK;
@property (class, nonatomic, assign, readonly) NSString *POST_LINK;
@property (class, nonatomic, assign, readonly) NSString *LANGUAGE;
@property (class, nonatomic, assign, readonly) NSString *USER_PHONE;
@property (class, nonatomic, assign, readonly) NSString *USER_CONTACT_EMAIL;
@property (class, nonatomic, assign, readonly) NSString *USER_EMAIL;
@property (class, nonatomic, assign, readonly) NSString *CAPTURE_URL;
@property (class, nonatomic, assign, readonly) NSString *REFUND_URL;
@property (class, nonatomic, assign, readonly) NSString *RESULT_URL;
@property (class, nonatomic, assign, readonly) NSString *CHECK_URL;
@property (class, nonatomic, assign, readonly) NSString *USER_ID;
@property (class, nonatomic, assign, readonly) NSString *ORDER_ID;
@property (class, nonatomic, assign, readonly) NSString *DESCRIPTION;
@property (class, nonatomic, assign, readonly) NSString *RECURRING_PROFILE;
@property (class, nonatomic, assign, readonly) NSString *AMOUNT;
@property (class, nonatomic, assign, readonly) NSString *PAYMENT_ID;

@end
