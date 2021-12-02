#import <React/RCTBridgeModule.h>
@import PassKit;

@interface AppleWallet : NSObject <RCTBridgeModule>

- (BOOL)canAddPaymentPass;

@end
