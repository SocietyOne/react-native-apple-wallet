//
//  AppleWalletDefinitions.h
//  AppleWallet
//
//  Created by shanaka.gunasekara on 7/12/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#ifndef AppleWalletDefinitions_h
#define AppleWalletDefinitions_h

typedef enum {
    kPKEncryptionSchemeECC_V2 = 0,
} EncryptionScheme;

typedef enum {
    kPKPaymentNetworkAmex = 0,
    kPKPaymentNetworkDiscover,
    kPKPaymentNetworkMasterCard,
    kPKPaymentNetworkPrivateLabel,
    kPKPaymentNetworkVisa,
} PaymentNetwork;

#endif /* AppleWalletDefinitions_h */
