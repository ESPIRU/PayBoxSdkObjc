//
//  ApiHelper.m
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ApiHelper.h"
#import "ApiProtocol.h"
#import "Models.h"
#import "Constants.h"
#import "String+PayBox.h"

@implementation ApiHelper

- (instancetype)init:(NSString *)secretKey listener:(id<ApiProtocol>)listener {
    self = [super initWithSecretKey:secretKey];
    if (self) {
        self.listener = listener;
    }
    
    return self;
}

- (void)initConnection:(NSString *)url params:(NSDictionary *)params {
    [self request:^RequestData *{
        return [[RequestData alloc] initWithParams:[self signedParamsWithUrl:url array:params] method:@"POST" url:url];
    }];
}

- (void)request:(RequestData * (^)(void))requestData {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
        [self connection:requestData() connection:^(ResponseData *responseData) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self resolveResponse:responseData];
            });
        }];
    });
}

- (void)connection:(RequestData *)requestData connection:(void (^)(ResponseData *))connection {
    NSURL *urlCon = [NSURL URLWithString:requestData.url];
    if (urlCon == nil) {
        return;
    }
    
    NSArray *signedParams = requestData.params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < signedParams.count; i++) {
        NSString *key = [signedParams[i] objectForKey:@"key"];
        NSString *value = [signedParams[i] objectForKey:@"value"];
        [params setObject:value forKey:key];
    }
    
    NSData *parameters = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    if (parameters == nil) {
        return;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlCon];
    request.HTTPMethod = requestData.method;
    request.timeoutInterval = 25000;
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    request.HTTPBody = parameters;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            connection([[ResponseData alloc] initWithCode:@(522) response:error.localizedDescription url:requestData.url error:true]);
            return;
        }
        
        NSHTTPURLResponse *requestStatus = (NSHTTPURLResponse *)response;
        NSInteger statusCode = requestStatus.statusCode;
        if (statusCode == 200) {
            NSString *strResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (strResponse == nil) {
                return;
            }
            NSLog(@"%@", strResponse);
            connection([[ResponseData alloc] initWithCode:@(statusCode) response:strResponse url:requestData.url error:(statusCode != 200)]);
        }
    }];
    
    [dataTask resume];
}

- (void)resolveResponse:(ResponseData *)result {
    if (result != nil) {
        if (!result.error) {
            if ([result.response containsString:Params.RESPONSE]) {
                if ([self isSuccess:result.response]) {
                    [self apiHandler:result.url xml:result.response error:nil];
                } else {
                    NSNumber *code = [result.response getIntValue:Params.ERROR_CODE];
                    if (code == nil) {
                        code = @(520);
                    }
                    NSString *description = [result.response getStringValue:Params.ERROR_DESCRIPTION];
                    if (description == nil) {
                        description = Params.UNKNOWN_ERROR;
                    }
                    [self apiHandler:result.url xml:nil error:[[Error alloc] initWithErrorCode:code description:description]];
                }
            } else {
                [self apiHandler:result.url xml:nil error:[[Error alloc] initWithErrorCode:@(0) description:Params.FORMAT_ERROR]];
            }
        }
    }
}

- (BOOL)isSuccess:(NSString *)xml {
    NSString *status = [xml getStringValue:Params.STATUS];
    if (status == nil) {
        status = @"error";
    }
    
    return ![status isEqualToString:@"error"];
}

- (void)apiHandler:(NSString *)url xml:(NSString *)xml error:(Error *)error {
    if ([url containsString:Urls.INIT_PAYMENT_URL]) {
        [self.listener onPaymentInited:[xml getPayment] error:error];
    } else if ([url containsString:Urls.REVOKE_URL]) {
        [self.listener onPaymentRevoked:[xml getPayment] error:error];
    } else if ([url containsString:Urls.CANCEL_URL]) {
        [self.listener onPaymentCanceled:[xml getPayment] error:error];
    } else if ([url containsString:Urls.CLEARING_URL]) {
        [self.listener onCapture:[xml getCapture] error:error];
    } else if ([url containsString:Urls.STATUS_URL]) {
        [self.listener onPaymentStatus:[xml getStatus] error:error];
    } else if ([url containsString:Urls.RECURRING_URL]) {
        [self.listener onPaymentRecurring:[xml getRecurringPayment] error:error];
    } else if ([url containsString:[NSString stringWithFormat:@"%@%@", Urls.CARDSTORAGE, Urls.ADDCARD_URL]]) {
        [self.listener onCardAdding:[xml getPayment] error:error];
    } else if ([url containsString:[NSString stringWithFormat:@"%@%@", Urls.CARDSTORAGE, Urls.LISTCARD_URL]]) {
        [self.listener onCardListing:[xml getCards] error:error];
    } else if ([url containsString:[NSString stringWithFormat:@"%@%@", Urls.CARDSTORAGE, Urls.REMOVECARD_URL]]) {
        [self.listener onCardRemoved:[xml getCard] error:error];
    } else if ([url containsString:[NSString stringWithFormat:@"%@%@", Urls.CARD, Urls.CARDINITPAY]]) {
        [self.listener onCardPayInited:[xml getPayment] error:error];
    }
}

@end
