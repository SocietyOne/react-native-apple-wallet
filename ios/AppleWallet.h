#import <PassKit/PassKit.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>
#import <React/RCTUtils.h>

// Reference : https://reactnative.dev/docs/native-modules-ios#sending-events-to-javascript
@interface AppleWallet : RCTEventEmitter <RCTBridgeModule, PKAddPaymentPassViewControllerDelegate>

@property (nonatomic, retain) NSString *cardholderName;
@property (nonatomic, retain) NSString *localizedDescription;
@property (nonatomic, retain) NSString *paymentNetwork;
@property (nonatomic, retain) NSString *primaryAccountIdentifier;
@property (nonatomic, retain) NSString *primaryAccountSuffix;
@property (nonatomic, retain) NSString *apiEndpoint;
@property (nonatomic, retain) NSString *authorization;

@end
