//
//  Constants.m
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/18/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@implementation Urls

static NSString *BASE_URL = @"https://api.paybox.money/";
static NSString *STATUS_URL = @"get_status.php";
static NSString *INIT_PAYMENT_URL = @"init_payment.php";
static NSString *REVOKE_URL = @"revoke.php";
static NSString *CANCEL_URL = @"cancel.php";
static NSString *CLEARING_URL = @"do_capture.php";
static NSString *RECURRING_URL = @"make_recurring_payment.php";
static NSString *CARDSTORAGE = @"/cardstorage/";
static NSString *CARD = @"/card/";
static NSString *LISTCARD_URL = @"list";
static NSString *CARDINITPAY = @"init";
static NSString *ADDCARD_URL = @"add";
static NSString *PAY = @"pay";
static NSString *REMOVECARD_URL = @"remove";

+ (NSString *)BASE_URL {
    return BASE_URL;
}

+ (NSString *)STATUS_URL {
    return [BASE_URL stringByAppendingString:STATUS_URL];
}

+ (NSString *)INIT_PAYMENT_URL {
    return [BASE_URL stringByAppendingString:INIT_PAYMENT_URL];
}

+ (NSString *)REVOKE_URL {
    return [BASE_URL stringByAppendingString:REVOKE_URL];
}

+ (NSString *)CANCEL_URL {
    return [BASE_URL stringByAppendingString:CANCEL_URL];
}

+ (NSString *)CLEARING_URL {
    return [BASE_URL stringByAppendingString:CLEARING_URL];
}

+ (NSString *)RECURRING_URL {
    return [BASE_URL stringByAppendingString:RECURRING_URL];
}

+ (NSString *)CARDSTORAGE {
    return CARDSTORAGE;
}

+ (NSString *)CARD {
    return CARD;
}

+ (NSString *)LISTCARD_URL {
    return LISTCARD_URL;
}

+ (NSString *)CARDINITPAY {
    return CARDINITPAY;
}

+ (NSString *)ADDCARD_URL {
    return ADDCARD_URL;
}

+ (NSString *)PAY {
    return PAY;
}

+ (NSString *)REMOVECARD_URL {
    return REMOVECARD_URL;
}

+ (NSString *)CARD_PAY:(NSNumber *)merchantId {
    return [NSString stringWithFormat:@"%@v1/merchant/%d%@", BASE_URL, [merchantId intValue], CARD];
}

+ (NSString *)CARD_MERCHANT:(NSNumber *)merchantId {
    return [NSString stringWithFormat:@"%@v1/merchant/%d%@", BASE_URL, [merchantId intValue], CARDSTORAGE];
}

@end


@implementation Params

static NSString *RECURRING_PROFILE_ID = @"pg_recurring_profile_id";
static NSString *CARD_CREATED_AT = @"created_at";
static NSString *RESPONSE = @"response";
static NSString *PAYMENT_FAILURE = @"Не удалось оплатить";
static NSString *UNKNOWN_ERROR = @"Неизвестная ошибка";
static NSString *CONNECTION_ERROR = @"Ошибка подключения";
static NSString *FORMAT_ERROR = @"Неправильный формат ответа";
static NSString *RECURRING_PROFILE_EXPIRY = @"pg_recurring_profile_expiry_date";
static NSString *CLEARING_AMOUNT = @"pg_clearing_amount";
static NSString *REFUND_AMOUNT = @"pg_refund_amount";
static NSString *ERROR_CODE = @"pg_error_code";
static NSString *ERROR_DESCRIPTION = @"pg_error_description";
static NSString *CAPTURED = @"pg_captured";
static NSString *CARD_PAN = @"pg_card_pan";
static NSString *CREATED_AT = @"pg_create_date";
static NSString *TRANSACTION_STATUS = @"pg_transaction_status";
static NSString *CAN_REJECT = @"pg_can_reject";
static NSString *REDIRECT_URL = @"pg_redirect_url";
static NSString *MERCHANT_ID = @"pg_merchant_id";
static NSString *SIG = @"pg_sig";
static NSString *SALT = @"pg_salt";
static NSString *STATUS = @"pg_status";
static NSString *CARD_ID = @"pg_card_id";
static NSString *CARD_HASH = @"pg_card_hash";
static NSString *TEST_MODE = @"pg_testing_mode";
static NSString *RECURRING_START = @"pg_recurring_start";
static NSString *AUTOCLEARING = @"pg_auto_clearing";
static NSString *REQUEST_METHOD = @"pg_request_method";
static NSString *CURRENCY = @"pg_currency";
static NSString *LIFETIME = @"pg_lifetime";
static NSString *ENCODING = @"pg_encoding";
static NSString *RECURRING_LIFETIME = @"pg_recurring_lifetime";
static NSString *PAYMENT_SYSTEM = @"pg_payment_system";
static NSString *SUCCESS_METHOD = @"pg_success_url_method";
static NSString *FAILURE_METHOD = @"pg_failure_url_method";
static NSString *SUCCESS_URL = @"pg_success_url";
static NSString *FAILURE_URL = @"pg_failure_url";
static NSString *BACK_LINK = @"pg_back_link";
static NSString *POST_LINK = @"pg_post_link";
static NSString *LANGUAGE = @"pg_language";
static NSString *USER_PHONE = @"pg_user_phone";
static NSString *USER_CONTACT_EMAIL = @"pg_user_contact_email";
static NSString *USER_EMAIL = @"pg_user_email";
static NSString *CAPTURE_URL = @"pg_capture_url";
static NSString *REFUND_URL = @"pg_refund_url";
static NSString *RESULT_URL = @"pg_result_url";
static NSString *CHECK_URL = @"pg_check_url";
static NSString *USER_ID = @"pg_user_id";
static NSString *ORDER_ID = @"pg_order_id";
static NSString *DESCRIPTION = @"pg_description";
static NSString *RECURRING_PROFILE = @"pg_recurring_profile";
static NSString *AMOUNT = @"pg_amount";
static NSString *PAYMENT_ID = @"pg_payment_id";


+ (NSString *)RECURRING_PROFILE_ID {
    return RECURRING_PROFILE_ID;
}

+ (NSString *)CARD_CREATED_AT {
    return CARD_CREATED_AT;
}

+ (NSString *)RESPONSE {
    return RESPONSE;
}

+ (NSString *)PAYMENT_FAILURE {
    return PAYMENT_FAILURE;
}

+ (NSString *)UNKNOWN_ERROR {
    return UNKNOWN_ERROR;
}

+ (NSString *)CONNECTION_ERROR {
    return CONNECTION_ERROR;
}

+ (NSString *)FORMAT_ERROR {
    return FORMAT_ERROR;
}

+ (NSString *)RECURRING_PROFILE_EXPIRY {
    return RECURRING_PROFILE_EXPIRY;
}

+ (NSString *)CLEARING_AMOUNT {
    return CLEARING_AMOUNT;
}

+ (NSString *)REFUND_AMOUNT {
    return REFUND_AMOUNT;
}

+ (NSString *)ERROR_CODE {
    return ERROR_CODE;
}

+ (NSString *)ERROR_DESCRIPTION {
    return ERROR_DESCRIPTION;
}

+ (NSString *)CAPTURED {
    return CAPTURED;
}

+ (NSString *)CARD_PAN {
    return CARD_PAN;
}

+ (NSString *)CREATED_AT {
    return CREATED_AT;
}

+ (NSString *)TRANSACTION_STATUS {
    return TRANSACTION_STATUS;
}

+ (NSString *)CAN_REJECT {
    return CAN_REJECT;
}

+ (NSString *)REDIRECT_URL {
    return REDIRECT_URL;
}

+ (NSString *)MERCHANT_ID {
    return MERCHANT_ID;
}

+ (NSString *)SIG {
    return SIG;
}

+ (NSString *)SALT {
    return SALT;
}

+ (NSString *)STATUS {
    return STATUS;
}

+ (NSString *)CARD_ID {
    return CARD_ID;
}

+ (NSString *)CARD_HASH {
    return CARD_HASH;
}

+ (NSString *)TEST_MODE {
    return TEST_MODE;
}

+ (NSString *)RECURRING_START {
    return RECURRING_START;
}

+ (NSString *)AUTOCLEARING {
    return AUTOCLEARING;
}

+ (NSString *)REQUEST_METHOD {
    return REQUEST_METHOD;
}

+ (NSString *)CURRENCY {
    return CURRENCY;
}

+ (NSString *)LIFETIME {
    return LIFETIME;
}

+ (NSString *)ENCODING {
    return ENCODING;
}

+ (NSString *)RECURRING_LIFETIME {
    return RECURRING_LIFETIME;
}

+ (NSString *)PAYMENT_SYSTEM {
    return PAYMENT_SYSTEM;
}

+ (NSString *)SUCCESS_METHOD {
    return SUCCESS_METHOD;
}

+ (NSString *)FAILURE_METHOD {
    return FAILURE_METHOD;
}

+ (NSString *)SUCCESS_URL {
    return SUCCESS_URL;
}

+ (NSString *)FAILURE_URL {
    return FAILURE_URL;
}

+ (NSString *)BACK_LINK {
    return BACK_LINK;
}

+ (NSString *)POST_LINK {
    return POST_LINK;
}

+ (NSString *)LANGUAGE {
    return LANGUAGE;
}

+ (NSString *)USER_PHONE {
    return USER_PHONE;
}

+ (NSString *)USER_CONTACT_EMAIL {
    return USER_CONTACT_EMAIL;
}

+ (NSString *)USER_EMAIL {
    return USER_EMAIL;
}

+ (NSString *)CAPTURE_URL {
    return CAPTURE_URL;
}

+ (NSString *)REFUND_URL {
    return REFUND_URL;
}

+ (NSString *)RESULT_URL {
    return RESULT_URL;
}

+ (NSString *)CHECK_URL {
    return CHECK_URL;
}

+ (NSString *)USER_ID {
    return USER_ID;
}

+ (NSString *)ORDER_ID {
    return ORDER_ID;
}

+ (NSString *)DESCRIPTION {
    return DESCRIPTION;
}

+ (NSString *)RECURRING_PROFILE {
    return RECURRING_PROFILE;
}

+ (NSString *)AMOUNT {
    return AMOUNT;
}

+ (NSString *)PAYMENT_ID {
    return PAYMENT_ID;
}

@end
