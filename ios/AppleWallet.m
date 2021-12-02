#import "AppleWallet.h"
#import <React/RCTLog.h>
#import <PassKit/PassKit.h>

@implementation AppleWallet

// To export a module named AppleWallet
RCT_EXPORT_MODULE()

/*
 S1 Apple wallet
 */

- (BOOL)canAddPaymentPass
{
    if (@available(iOS 9.0, *)) {
        //What is the required logic to do to know if the app can add cards to Apple Pay?
        return [PKAddPaymentPassViewController canAddPaymentPass];
    } else {
        return false;
    }
}

RCT_REMAP_METHOD(canAddPaymentPass,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    RCTLogInfo(@"NATIVE canAddPaymentPass");
    resolve(@([self canAddPaymentPass]));
}

-(BOOL)canAddPaymentPassWithPrimaryAccountIdentifier
{
    return false;
}

RCT_EXPORT_METHOD(canAddPaymentPassWithPrimaryAccountIdentifier:(NSString *)primaryAccountIdentifier
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    RCTLogInfo(@"NATIVE canAddPaymentPassWithPrimaryAccountIdentifier %@", primaryAccountIdentifier);
    resolve(@([self canAddPaymentPassWithPrimaryAccountIdentifier]));
}

@end
