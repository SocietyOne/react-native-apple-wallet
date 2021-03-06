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
@property (nonatomic, retain) NSString *leafCertificate;
@property (nonatomic, retain) NSString *subCACertificate;
@property (nonatomic, retain) NSString *nonce;
@property (nonatomic, retain) NSString *nonceSignature;

// Reference : https://stackoverflow.com/questions/19171206/save-a-completion-handler-as-an-object
@property (nonatomic, copy) void (^addPaymentPassRequestCompletionHandler)(PKAddPaymentPassRequest *addPaymentPassRequest);

@end
