#import "AppleWallet.h"
#import <React/RCTLog.h>
#import <PassKit/PassKit.h>
#import "AppleWalletDefinitions.h"

@implementation AppleWallet

// To export a module named AppleWallet
RCT_EXPORT_MODULE()

- (BOOL)canAddPaymentPass
{
    if (@available(iOS 9.0, *)) {
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
    if (@available(iOS 13.4, *)) {
        return [library canAddSecureElementPassWithPrimaryAccountIdentifier:cardId];
    }
    if (@available(iOS 9.0, *)) {
        return [library canAddPaymentPassWithPrimaryAccountIdentifier:cardId];
    } else {
        return false;
    }
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

- (NSDictionary *)constantsToExport {
    PKAddPassButton *addPassButton = [[PKAddPassButton alloc] initWithAddPassButtonStyle:PKAddPassButtonStyleBlack];
    [addPassButton layoutIfNeeded];
    
    return @{
        @"AddToWalletButtonWidth": @(CGRectGetWidth(addPassButton.frame)),
        @"AddToWalletButtonHeight": @(CGRectGetHeight(addPassButton.frame)),
    };
}

@end
