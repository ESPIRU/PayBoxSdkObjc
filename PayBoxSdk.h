//
//  PayBoxSdk.h
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import "SignHelper.h"
#import "PayBoxPaymentView.h"
#import "ConfigurationImpl.h"
#import "Models.h"

@interface PayBoxSdk : SignHelper

- (instancetype)initWithMerchantId:(NSNumber *)merchantId secretKey:(NSString *)secretKey;

/// Передайте сюда paymentView добавленный в ваш viewController
/// - parameters:
///     webView на котором будет открываться платежнвя страница
///
- (void)setPaymentView:(PayBoxPaymentView *)paymentView;

/// Настройки Sdk
///
- (ConfigurationImpl *)config;

/// Создание нового платежа
/// - parameters:
///     - amount: сумма платежа
///     - description: комментарии, описание платежа
///     - orderId: ID заказа платежа
///     - userId: ID пользователя в системе мерчанта
///     - extraParams: доп. параметры мерчанта
///     - paymentPaid: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk createPayment:100 description:@"description" orderId:@"01234" userId:@"229" extraParams:nil paymentPaid:^(Payment
///      *payment, Error *error) { // Вызовется после оплаты
///     }];
///
- (void)createPayment:(double)amount
          description:(NSString *)description
              orderId:(NSString *)orderId
               userId:(NSString *)userId
          extraParams:(NSDictionary *)extraParams
          paymentPaid:(void (^)(Payment *, Error *))paymentPaid;

/// Создание рекурентного платежа
/// - parameters:
///     - amount: сумма платежа
///     - description: комментарий, описание платежа
///     - orderId: ID заказа платежа
///     - recurringProfile: рекурентный профиль в системе Paybox
///     - extraParams: доп. параметры мерчанта
///     - recurringPaid: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk createRecurringPayment:100 description:@"description" recurringProfile:@"223123" orderId:@"01234" userId:@"229" extraParams:nil paymentPaid:^(RecurringPayment
///      *payment, Error *error) { // Вызовется после оплаты
///     }];
///
- (void)createRecurringPayment:(double)amount
                   description:(NSString *)description
              recurringProfile:(NSString *)recurringProfile
                       orderId:(NSString *)orderId
                   extraParams:(NSDictionary *)extraParams
                 recurringPaid:(void (^)(RecurringPayment *, Error *))recurringPaid;

/// Создание платежа добавленной картой
/// - parameters:
///     - amount: сумма платежа
///     - description: комментарии, описание платежа
///     - orderId: ID заказа платежа
///     - userId: ID пользователя в системе мерчанта
///     - cardId: ID сохраненной карты в системе Paybox
///     - extraParams: доп. параметры мерчанта
///     - payInited: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk createCardPayment:100 userId:@"229" cardId:@(123123) description:@"description" orderId:@"01234" extraParams:nil payInited:^(Payment
///      *payment, Error *error) { // Вызовется после создания
///     }];
///
- (void)createCardPayment:(double)amount
                   userId:(NSString *)userId
                   cardId:(NSNumber *)cardId
              description:(NSString *)description
                  orderId:(NSString *)orderId
              extraParams:(NSDictionary *)extraParams
                payInited:(void (^)(Payment *, Error *))payInited;

/// Оплата созданного платежа, добавленной картой
/// - parameters:
///     - paymentId: ID платежа в системе Paybox
///     - paymentPaid: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk payByCard:@(2331231) paymentPaid:^(Payment
///      *payment, Error *error) { // Вызовется после оплаты
///     }];
///
- (void)payByCard:(NSNumber *)paymentId
      paymentPaid:(void (^)(Payment *, Error *))paymentPaid;

/// Получить статус платежа
/// - parameters:
///     - paymentId: ID платежа в системе Paybox
///     - statusReceived: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk getPaymentStatus:@(2331231) statusReceived:^(Status
///      *status, Error *error) { // Вызовется после получения ответа
///     }];
///
- (void)getPaymentStatus:(NSNumber *)paymentId
          statusReceived:(void (^)(Status *, Error *))statusReceived;

/// Провести возврат платежа
/// - parameters:
///     - paymentId: ID платежа в системе Paybox
///     - amount: сумма платежа
///     - revoked: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk makeRevokePayment:@(2331231) revoked:^(Payment
///      *payment, Error *error) { // Вызовется после возврата
///     }];
///
- (void)makeRevokePayment:(NSNumber *)paymentId
                   amount:(double)amount
                  revoked:(void (^)(Payment *, Error *))revoked;

/// Провести клиринг платежа
/// - parameters:
///     - paymentId: ID платежа в системе Paybox
///     - amount: сумма платежа
///     - cleared: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     Если указать nil вместо суммы клиринга, то клиринг пройдет на всю сумму платежа
///
///     [sdk makeClearingPayment:@(2331231) amount:100 cleared:^(Capture
///      *capture, Error *error) { // Вызовется после клиринга
///     }];
///
- (void)makeClearingPayment:(NSNumber *)paymentId
                     amount:(double)amount
                    cleared:(void (^)(Capture *, Error *))cleared;

/// Провести отмену платежа
/// - parameters:
///     - paymentId: ID платежа в системе Paybox
///     - canceled: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk makeCancelPayment:@(2331231) canceled:^(Payment
///      *payment, Error *error) { // Вызовется после отмены
///     }];
///
- (void)makeCancelPayment:(NSNumber *)paymentId
                 canceled:(void (^)(Payment *, Error *))canceled;

/// Сохранение новой карты в системе Paybox
/// - parameters:
///     - userId: ID пользователя в системе мерчанта
///     - postLink: ссылка на сервис мерчанта, будет вызван после сохранения карты
///     - cardAdded: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk addNewCard:@"url" userId:@"229" cardAdded:^(Payment
///      *payment, Error *error) { // Вызовется после сохранения
///     }];
///
- (void)addNewCard:(NSString *)postLink
            userId:(NSString *)userId
         cardAdded:(void (^)(Payment *, Error *))cardAdded;

/// Удаление сохраненой карты
/// - parameters:
///     - cardId: ID сохраненной карты в системе Paybox
///     - userId: ID пользователя в системе мерчанта
///     - removed: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk removeAddedCard:@(123123) userId:@"229" removed:^(Payment
///      *payment, Error *error) { // Вызовется после ответа
///     }];
///
- (void)removeAddedCard:(NSNumber *)cardId
                 userId:(NSString *)userId
                removed:(void (^)(Card *, Error *))removed;

/// Получить список сохраненых карт
/// - parameters:
///     - userId: ID пользователя в системе мерчанта
///     - cardList: callback от Api Paybox
///
/// Пример кода:
/// ----
///
///     [sdk getAddedCards:@"229" cardList:^(NSArray
///      *cards, Error *error) { // Вызовется после получения ответа
///     }];
///
- (void)getAddedCards:(NSString *)userId
             cardList:(void (^)(NSArray *, Error *))cardList;

@end
