//
//  SignHelper.m
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SignHelper.h"
#import "String+PayBox.h"

@implementation SignHelper : NSObject

- (instancetype)initWithSecretKey:(NSString *)secretKey {
    self = [super init];
    if (self) {
        self.secretKey = secretKey;
    }
    
    return self;
}

- (NSString *)randomSalt {
    NSUInteger len = 16;
    NSString *a = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    NSMutableString *s = [NSMutableString stringWithCapacity: len];
    
    for (int i = 0; i < len; i++) {
        u_int32_t r = arc4random() % [a length];
        unichar c = [a characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return s;
}

- (NSString *)sigWithSecretKey:(NSString *)secretKey url:(NSString *)url param:(NSArray *)param {
    NSString *sig = [NSString stringWithString:url];
    NSUInteger size = param.count;
    
    for (int i = 0; i < param.count; i++) {
        sig = [sig stringByAppendingString:@";"];
        NSDictionary *item = [param objectAtIndex:i];
        sig = [sig stringByAppendingString:[item objectForKey:@"value"]];
        size -= 1;
        
        if (size == 0) {
            sig = [sig stringByAppendingString:@";"];
            sig = [sig stringByAppendingString:secretKey];
        }
    }
    
    return sig.md5;
}

- (NSArray *)signedParamsWithUrl:(NSString *)url array:(NSDictionary *)dictionary {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    NSArray *urlPath = [url componentsSeparatedByString:@"/"];
    [params setValue:self.secretKey forKey:@"pg_salt"];
    
    NSArray *sortedKeys = [[params allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray *sortedParams = [NSMutableArray array];
    for (NSString *key in sortedKeys) {
        [sortedParams addObject:@{@"key": key, @"value": [params objectForKey:key]}];
    }
    [sortedParams addObject:@{@"key": @"pg_sig", @"value": [self sigWithSecretKey:self.secretKey url:urlPath[urlPath.count - 1] param:sortedParams]}];
    
    return sortedParams;
}

@end;
