#import "AppleWallet.h"
#import <React/RCTLog.h>
#import <PassKit/PassKit.h>

@implementation AppleWallet

// To export a module named AppleWallet
RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(nonnull NSNumber*)a withB:(nonnull NSNumber*)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    NSNumber *result = @([a floatValue] * [b floatValue]);
    RCTLogInfo(@"multiply call from ObjC a:%@ b:%@", a, b);
    
    //    if ([result isEqualToNumber:[NSNumber numberWithInt:10]]) {
    resolve(result);
    //    }
    //    else {
    //        reject(@"error in multiply.", nil, nil);
    //    }
}

RCT_EXPORT_METHOD(test:(NSString *)name)
{
    RCTLogInfo(@"Testing call from ObjC %@", name);
}

RCT_EXPORT_METHOD(createCalendarEvent:(NSString *)name location:(NSString *)location)
{
    RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

/*
 create a synchronous native method (if you really want to). But this is strongly discouraged
 Reference : https://reactnative.dev/docs/native-modules-ios#synchronous-methods
 
 The return type of this method must be of object type (id) and should be serializable to JSON.
 This means that the hook can only return nil or JSON values (e.g. NSNumber, NSString, NSArray, NSDictionary).
 */
RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getName)
{
    return [[UIDevice currentDevice] name];
}

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

@end
