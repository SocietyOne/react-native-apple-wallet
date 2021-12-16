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
    // Lets not use deprecated methods shall we
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

/*
 React-native expects you to implement this method if you want to do native iOS rendering.
 This will ensure that your native module is run on the main thread
 Reference : https://stackoverflow.com/q/50773748/329054
 */
+ (BOOL)requiresMainQueueSetup {
    return YES;
}

#pragma mark - RCTEventEmitter implementation

- (NSArray<NSString *> *)supportedEvents {
    return @[@"addingPassSucceeded", @"addingPassFailed", @"addToWalletViewCreationError", @"addToWalletViewShown", @"addToWalletViewHidden"];
}

#pragma mark - PKAddPassesViewController

RCT_EXPORT_METHOD(presentAddPaymentPassViewController: (NSDictionary *)args
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {

    PKAddPaymentPassRequestConfiguration *configuration = [[PKAddPaymentPassRequestConfiguration alloc] initWithEncryptionScheme:PKEncryptionSchemeECC_V2];

    self.cardholderName = args[@"cardholderName"];
    self.localizedDescription = args[@"localizedDescription"];
    self.paymentNetwork = PKPaymentNetworkMasterCard;
    self.primaryAccountSuffix = args[@"primaryAccountSuffix"];
    self.primaryAccountIdentifier = args[@"primaryAccountIdentifier"];
    self.apiEndpoint = args[@"apiEndpoint"];
    self.authorization = args[@"authorization"];

    configuration.cardholderName = self.cardholderName;
    configuration.localizedDescription = self.localizedDescription;
    configuration.paymentNetwork = self.paymentNetwork;
    configuration.primaryAccountSuffix = self.primaryAccountSuffix;
    configuration.primaryAccountIdentifier = self.primaryAccountIdentifier;

    PKAddPaymentPassViewController *passView = [[PKAddPaymentPassViewController alloc] initWithRequestConfiguration:configuration
                                                                                                           delegate:self];
    if (passView != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIApplication *sharedApplication = RCTSharedApplication();
            UIWindow *window = sharedApplication.keyWindow;

            if (window) {
                UIViewController *rootViewController = window.rootViewController;

                if (rootViewController) {
                    [rootViewController presentViewController:passView animated:YES completion:^{
                        // Succeeded
                        [self sendEventWithName:@"addToWalletViewShown" body:@{
                            @"args" : args
                        }];
                        resolve(nil);
                        return;
                    }];

                }
            }
        });
    } else {
        [self sendEventWithName:@"addToWalletViewCreationError" body:nil];
        resolve(nil);
        return;
    }
}

#pragma mark - PKAddPaymentPassViewControllerDelegate

- (void)addPaymentPassViewController:(nonnull PKAddPaymentPassViewController *)controller generateRequestWithCertificateChain:(nonnull NSArray<NSData *> *)certificates nonce:(nonnull NSData *)nonce nonceSignature:(nonnull NSData *)nonceSignature completionHandler:(nonnull void (^)(PKAddPaymentPassRequest * _Nonnull))handler {
    NSLog(@"[INFO] addPaymentPassViewController 1");

    NSString* leafCertificate = [[certificates objectAtIndex:0] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    NSString* subCACertificate = [[certificates objectAtIndex:1] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
}

- (void)addPaymentPassViewController:(nonnull PKAddPaymentPassViewController *)controller didFinishAddingPaymentPass:(nullable PKPaymentPass *)pass error:(nullable NSError *)error {
    NSLog(@"pass: %@ | error: %@", pass, error);

    if (pass != nil) {
        [self sendEventWithName:@"addingPassSucceeded" body:nil];
    } else {
        if (error != nil) {
            [self sendEventWithName:@"addingPassFailed" body:@{
                @"code" : @([error code]),
                @"message" : [error localizedDescription],
            }];

        } else {
            [self sendEventWithName:@"addingPassFailed" body:nil];
        }
    }

    [controller dismissViewControllerAnimated:YES
                                   completion:^() {
        // should controller be released here
        [self sendEventWithName:@"addToWalletViewHidden" body:nil];
    }];
}

@end
