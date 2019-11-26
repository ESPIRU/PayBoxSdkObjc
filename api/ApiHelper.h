//
//  ApiHelper.h
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/19/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignHelper.h"
#import "ApiProtocol.h"

@interface ApiHelper : SignHelper

@property (nonatomic, weak) id<ApiProtocol> listener;

- (instancetype)init:(NSString *)secretKey listener:(id<ApiProtocol>)listener;
- (void)initConnection:(NSString *)url params:(NSDictionary *)params;

@end
