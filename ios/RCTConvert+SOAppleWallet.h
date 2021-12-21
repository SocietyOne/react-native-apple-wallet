//
//  RCTConvert+SOAppleWallet.h
//  AppleWallet
//
//  Created by shanaka.gunasekara on 21/12/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <React/RCTConvert.h>

@interface RCTConvert (SOAppleWallet)

+ (PKPaymentButtonType)PKPaymentButtonType:(id)json;
+ (PKPaymentButtonStyle)PKPaymentButtonStyle:(id)json;

@end
