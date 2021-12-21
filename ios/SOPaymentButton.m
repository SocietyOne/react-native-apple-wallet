//
//  SOPaymentButton.m
//  AppleWallet
//
//  Created by shanaka.gunasekara on 21/12/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import "SOPaymentButton.h"

@implementation SOPaymentButton

- (instancetype)initWithPaymentButtonType:(PKPaymentButtonType)type andStyle:(PKPaymentButtonStyle)style {
  if (self = [super init]) {
    self.paymentButton = [[PKPaymentButton alloc] initWithPaymentButtonType:type paymentButtonStyle:style];
    self.paymentButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.paymentButton addTarget:self
                           action:@selector(addPaymentButtonDidTouchUpInside:)
                 forControlEvents:UIControlEventTouchUpInside];
    [super setFrame:self.paymentButton.frame];
    [self addSubview:self.paymentButton];
  }
  
  return self;
}

// FIXME: Doesn't work as we need to UIAppearance property on PKPaymentButton for this to work
- (PKPaymentButtonStyle)paymentButtonStyle {
  if (self.paymentButton != nil) {
    return self.paymentButtonStyle;
  }
  return PKPaymentButtonStyleBlack;
}

- (void)addPaymentButtonDidTouchUpInside:(id)sender {
   if (self.onPress) {
     self.onPress(@{});
   }
}

@end
