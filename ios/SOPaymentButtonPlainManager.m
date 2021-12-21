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

// FIXME: Doesn't work as we need to UIAppearance property on PKPaymentButton for this to work. Have two managers that init different variations of PKPaymentButton for now.
//RCT_CUSTOM_VIEW_PROPERTY(paymentButtonStyle, PKPaymentButtonStyle, SOPaymentButton) {
//    view.paymentButtonStyle = json ? [RCTConvert PKPaymentButtonStyle:json] : defaultView.paymentButtonStyle;
//}

RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

- (UIView *)view {
    SOPaymentButton *paymentButton = [[SOPaymentButton alloc] initWithPaymentButtonType:PKPaymentButtonTypePlain andStyle:PKPaymentButtonStyleWhiteOutline];
    return paymentButton;
}

@end
