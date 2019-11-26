//
//  PayBoxPaymentView.h
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/18/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol PayBoxWebDelegate <NSObject>

@optional
- (void)loadStarted;
- (void)loadFinished;
@end

@interface PayBoxPaymentView : UIView

@property (strong, nonatomic) WKWebView *webView;
@property (nonatomic, weak) id<PayBoxWebDelegate> delegate;

- (void)loadPaymentPage:(NSString *)url successOrFailure:(void (^)(BOOL))sOf;

@end
