//
//  SOAddPassButton.m
//  AppleWallet
//
//  Created by shanaka.gunasekara on 8/12/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import "SOAddPassButtonContainer.h"

@implementation SOAddPassButtonContainer

- (instancetype)init {
  if (self = [super init]) {
    self.addPassButton = [[PKAddPassButton alloc] initWithAddPassButtonStyle:PKAddPassButtonStyleBlack];
    self.addPassButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.addPassButton addTarget:self
                           action:@selector(addPassButtonDidTouchUpInside:)
                 forControlEvents:UIControlEventTouchUpInside];
    [super setFrame:self.addPassButton.frame];
//    NSLog(@"%@", NSStringFromCGRect(self.addPassButton.frame));
    [self addSubview:self.addPassButton];
  }
  
  return self;
}

- (void)addPassButtonDidTouchUpInside:(id)sender {
   if (self.onPress) {
     self.onPress(@{});
   }
}

@end
