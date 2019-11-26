//
//  PayBoxPaymentView.m
//  payboxobjc
//
//  Created by Egor Bulgakov on 11/18/19.
//  Copyright © 2019 espiru. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PayBoxPaymentView.h"

@interface PayBoxPaymentView() <WKNavigationDelegate>

@property (copy) void (^successOrFailure)(BOOL);

@end

@implementation PayBoxPaymentView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initWebView];
}

- (void)initWebView {
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    self.webView.configuration.preferences.javaScriptEnabled = YES;
    self.webView.navigationDelegate = self;
    
    [super addSubview:self.webView];
    
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem: self.webView
                                 attribute: NSLayoutAttributeTop
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: self
                                 attribute: NSLayoutAttributeTop
                                multiplier: 1.0
                                  constant: 0];
    
    NSLayoutConstraint *bottomConstraint =
    [NSLayoutConstraint constraintWithItem: self.webView
                                 attribute: NSLayoutAttributeBottom
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: self
                                 attribute: NSLayoutAttributeBottom
                                multiplier: 1.0
                                  constant: 0];
    
    NSLayoutConstraint *leftConstraint =
    [NSLayoutConstraint constraintWithItem: self.webView
                                 attribute: NSLayoutAttributeLeft
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: self
                                 attribute: NSLayoutAttributeLeft
                                multiplier: 1.0
                                  constant: 0];
    
    NSLayoutConstraint *rightConstraint =
    [NSLayoutConstraint constraintWithItem: self.webView
                                 attribute: NSLayoutAttributeRight
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: self
                                 attribute: NSLayoutAttributeRight
                                multiplier: 1.0
                                  constant: 0];
    
    NSArray *constraints = @[
                             topConstraint,
                             bottomConstraint,
                             leftConstraint,
                             rightConstraint
                             ];
    
    [self addConstraints:constraints];
    
    self.webView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)loadUrl:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

- (void)loadPaymentPage:(NSString *)url successOrFailure:(void (^)(BOOL))sOf {
    if ([url hasPrefix:@"https://api.paybox.money"] || [url hasPrefix:@"https://paybox.money"] || [url hasPrefix:@"https://paybox.kz"]) {
        [self loadUrl:url];
        
        self.successOrFailure = sOf;
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    NSString *url = navigationAction.request.URL.absoluteString;
    if ([url containsString:@"success"]) {
        self.successOrFailure(YES);
        
        [self.webView loadHTMLString:@"" baseURL:nil];
    } else if ([url containsString:@"failure"]) {
        self.successOrFailure(NO);
        
        [self.webView loadHTMLString:@"" baseURL:nil];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.delegate loadFinished];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.delegate loadStarted];
}

- (void)layoutSubviews {
    return;
}

- (void)addSubview:(UIView *)view {
    return;
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index {
    return;
}

- (void)sendSubviewToBack:(UIView *)view {
    return;
}

- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2 {
    return;
}

- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview {
    return;
}

- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview {
    return;
}

- (void)didAddSubview:(UIView *)subview {
    return;
}

- (void)willRemoveSubview:(UIView *)subview {
    return;
}

- (void)bringSubviewToFront:(UIView *)view {
    return;
}

@end
