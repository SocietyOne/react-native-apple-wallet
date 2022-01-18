//
//  SOPaymentButtonManager.m
//  AppleWallet
//
//  Created by shanaka.gunasekara on 21/12/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <PassKit/Passkit.h>
#import "SOPaymentButtonPlainManager.h"
#import "SOPaymentButton.h"
#import "RCTConvert+SOAppleWallet.h"

@implementation SOPaymentButtonPlainManager

RCT_EXPORT_MODULE()

// NOTE: We can't use UIAppearance property on PKPaymentButton (like we do AddPassButton).
// Have to have two managers that init different variations of PKPaymentButton for now.

RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

- (UIView *)view {
    SOPaymentButton *paymentButton = [[SOPaymentButton alloc] initWithPaymentButtonType:PKPaymentButtonTypePlain andStyle:PKPaymentButtonStyleWhiteOutline];
    return paymentButton;
}

@end
