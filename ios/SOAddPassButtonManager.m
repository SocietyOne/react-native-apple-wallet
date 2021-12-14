//
//  SOAddPassButtonManager.m
//  AppleWallet
//
//  Created by shanaka.gunasekara on 8/12/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <PassKit/Passkit.h>
#import "SOAddPassButtonManager.h"
#import "SOAddPassButtonContainer.h"

@implementation SOAddPassButtonManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

- (UIView *)view {
    SOAddPassButtonContainer *addPassButtonContainer = [[SOAddPassButtonContainer alloc] init];
    return addPassButtonContainer;
}

@end
