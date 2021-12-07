#import "AppleWallet.h"
#import <React/RCTLog.h>
#import <PassKit/PassKit.h>
#import "AppleWalletDefinitions.h"

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

RCT_REMAP_METHOD(isAvailable,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    resolve(@([self canAddPaymentPass]));
}

-(BOOL)canAddPaymentPassWithPrimaryAccountIdentifier:(NSString *)cardId
{
    PKPassLibrary *library = [[PKPassLibrary alloc] init];
    return [library canAddPaymentPassWithPrimaryAccountIdentifier:cardId];
}

RCT_EXPORT_METHOD(canAddCard:(NSString *)cardId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    resolve(@([self canAddPaymentPassWithPrimaryAccountIdentifier:cardId]));
}

RCT_EXPORT_METHOD(isCardInWallet:(NSString *)card
    resolve:(RCTPromiseResolveBlock)resolve
    reject:(RCTPromiseRejectBlock)reject) {

    PKPassLibrary *library = [[PKPassLibrary alloc] init];
    if (![library canAddPaymentPassWithPrimaryAccountIdentifier:card]) {
        // If the card cannot be added to the wallet, there is no way we can find it there.
        resolve(@NO);
        return;
    }
    
    NSArray* passes = [library passesOfType:PKPassTypePayment];
    for (int i=0; i < [passes count]; i++) {
        PKPaymentPass* pass = [passes objectAtIndex:i];
        NSString* suffix = pass.primaryAccountNumberSuffix;
        if ([suffix isEqualToString:card]) {
            resolve(@YES);
            return;
        }
    }
    resolve(@NO);
}

@end
