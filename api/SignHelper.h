//
//  SignHelper.h
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

@interface SignHelper : NSObject

@property (strong, nonatomic) NSString *secretKey;

- (instancetype)initWithSecretKey:(NSString *)secretKey;

- (NSArray *)signedParamsWithUrl:(NSString *)url array:(NSDictionary *)dictionary;

@end;
