//
//  RCTConvert+SOAppleWallet.m
//  AppleWallet
//
//  Created by shanaka.gunasekara on 21/12/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <PassKit/PassKit.h>
#import "RCTConvert+SOAppleWallet.h"

@implementation RCTConvert (SOAppleWallet)

+ (PKPaymentButtonType)PKPaymentButtonType:(id)json {
  return (PKPaymentButtonType)json;
}

+ (PKPaymentButtonStyle)PKPaymentButtonStyle:(id)json {
  return (PKPaymentButtonStyle)json;
}

@end
