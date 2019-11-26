//
//  ConfigurationImpl.h
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

@interface ConfigurationImpl : NSObject

@property (nonatomic, weak) NSNumber *merchantId;

- (instancetype)initWithMerchantId:(NSNumber *)merchantId;

- (NSDictionary *)defParams;

- (NSDictionary *)getParamsWithExtraParams:(NSDictionary *)extraParams;

/// Установка номера телефона клиента, будет отображаться на платежной странице. Если не указать, то будет предложено ввести на платежной странице
/// - parameters:
///     номер телефона клиента
///
/// Пример кода:
/// ----
///
///     [[sdk config] setUserPhone:"+77771231234"]
///
- (void)setUserPhone:(NSString *)userPhone;

/// Установка email клиента, будет отображаться на платежной странице. Если не указать email, то будет предложено ввести на платежной странице
/// - parameters:
///     email клиента
///
/// Пример кода:
/// ----
///
///     [[sdk config] setUserEmail:"email"]
///
- (void)setUserEmail:(NSString *)userEmail;

/// Установка тестового режима
/// - parameters:
///     YES или NO
///
/// Пример кода:
/// ----
///
///     [[sdk config] testMode:YES] // По умолчанию тестовый режим включен
///
- (void)testMode:(BOOL)enabled;

/// Установка платежной системы
/// - parameters:
///     платежная система
///
/// Пример кода:
/// ----
///
///     [[sdk config] setPaymentSystem:@"EPAYWEBKZT"]
///
- (void)setPaymentSystem:(NSString *)paymentSystem;

/// Установка метода вызова сервиса мерчанта, для обращения от системы Paybox к системе мерчанта по ссылкам checkUrl, resultUrl, refundUrl, clearingUrl
/// - parameters:
///     метод запроса
///
/// Пример кода:
/// ----
///
///     [[sdk config] setRequestMethod:@"POST"]
///
- (void)setRequestMethod:(NSString *)requestMethod;

/// Установка языка платежной страницы
/// - parameters:
///     язык
///
/// Пример кода:
/// ----
///
///     [[sdk config] setLanguage:@"ru"]
///
- (void)setLanguage:(NSString *)language;

/// Установка автоклиринга платежей
/// - parameters:
///     YES или NO
///
/// Пример кода:
/// ----
///
///     [[sdk config] autoClearing:YES]
///
- (void)autoClearing:(BOOL)enabled;

/// Установка кодировки
/// - parameters:
///     кодировка, по умолчанию UTF-8
///
/// Пример кода:
/// ----
///
///     [[sdk config] setEncoding:@"UTF-8"]
///
- (void)setEncoding:(NSString *)encoding;

/// Установка времени жизни рекурентного профиля
/// - parameters:
///     время жизни (в месяцах), по умолчанию 36 месяцев
///
/// Пример кода:
/// ----
///
///     [[sdk config] setRecurringLifetime:@(36)]
///
- (void)setRecurringLifetime:(NSNumber *)recurringLifetime;

/// Установка времени жизни платежной страницы, в течение которого платеж должен быть завершен
/// - parameters:
///     время жизни (в секундах), по умолчанию 300 секунд
///
/// Пример кода:
/// ----
///
///     [[sdk config] setPaymentLifetime:@(300)]
///
- (void)setPaymentLifetime:(NSNumber *)paymentLifetime;

/// Установка включения режима рекурентного платежа
/// - parameters:
///     YES или NO, по умолчанию NO
///
/// Пример кода:
/// ----
///
///     [[sdk config] recurringMode:NO]
///
- (void)recurringMode:(BOOL)enabled;

/// Установка ссылки на сервис мерчанта, для проверки возможности платежа. Вызывается перед платежом, если платежная система предоставляет такую возможность
/// - parameters:
///     ссылка
///
/// Пример кода:
/// ----
///
///     [[sdk config] setCheckUrl:@"url"]
///
- (void)setCheckUrl:(NSString *)checkUrl;

/// Установка ссылки на сервис мерчанта, для сообщения о результате платежа. Вызывается после платежа в случае успеха или неудачи
/// - parameters:
///     ссылка
///
/// Пример кода:
/// ----
///
///     [[sdk config] setResultUrl:@"url"]
///
- (void)setResultUrl:(NSString *)resultUrl;

/// Установка ссылки на сервис мерчанта, для сообщения о результате платежа. для сообщения об отмене платежа. Вызывается после платежа в случае отмены платежа на стороне PayBoxа или ПС
/// - parameters:
///     ссылка
///
/// Пример кода:
/// ----
///
///     [[sdk config] setRefundUrl:@"url"]
///
- (void)setRefundUrl:(NSString *)refundUrl;

/// Установка ссылки на сервис мерчанта, для сообщения о проведении клиринга платежа по банковской карте
/// - parameters:
///     ссылка
///
/// Пример кода:
/// ----
///
///     [[sdk config] setClearingUrl:@"url"]
///
- (void)setClearingUrl:(NSString *)url;

/// Установка кода валюты, в которой указана сумма
/// - parameters:
///     код вылюты, пример: KZT, USD, EUR
///
/// Пример кода:
/// ----
///
///     [[sdk config] setCurrencyCode:@"KZT"]
///
- (void)setCurrencyCode:(NSString *)currencyCode;

@end
