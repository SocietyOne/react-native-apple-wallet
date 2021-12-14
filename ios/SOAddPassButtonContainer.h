//
//  SOAddPassButton.h
//  AppleWallet
//
//  Created by shanaka.gunasekara on 8/12/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <PassKit/PassKit.h>
#import <React/RCTComponent.h>

@interface SOAddPassButtonContainer : UIView

- (instancetype)init;

@property (nonatomic, retain) PKAddPassButton *addPassButton;
@property (nonatomic, copy) RCTBubblingEventBlock onPress;

@end
