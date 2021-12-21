//
//  SOPaymentButton.h
//  AppleWallet
//
//  Created by shanaka.gunasekara on 21/12/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <PassKit/PassKit.h>
#import <React/RCTComponent.h>

@interface SOPaymentButton : UIView

- (instancetype)initWithPaymentButtonType:(PKPaymentButtonType)type andStyle:(PKPaymentButtonStyle)style;

@property (nonatomic, retain) PKPaymentButton *paymentButton;
@property (nonatomic, copy) RCTBubblingEventBlock onPress;
@property (nonatomic, assign) PKPaymentButtonType paymentButtonType;
@property (nonatomic, assign) PKPaymentButtonStyle paymentButtonStyle;

@end
