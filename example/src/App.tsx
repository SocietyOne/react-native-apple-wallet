import * as React from 'react';

import { StyleSheet, View, Button } from 'react-native';
import AppleWallet, {
  isAvailable,
  canAddCard,
  AddPassButton,
  isCardInWallet,
} from 'react-native-apple-wallet';

export default function App() {
  const isAvailableOnPress = async () => {
    const isAvailableResult = await isAvailable();
    console.log('isAvailable :', isAvailableResult);
  };

  const canAddCardOnPress = async () => {
    const canAddPaymentPassWithAccountIdResult = await canAddCard(
      'test-card-id'
    );
    console.log(
      'canAddPaymentPassWithAccountId :',
      canAddPaymentPassWithAccountIdResult
    );
  };

  const isCardInWalletOnPress = async () => {
    const isCardInWalletResult = await isCardInWallet('test-card-id');
    console.log('isCardInWallet :', isCardInWalletResult);
  };

  return (
    <>
      <View style={styles.container}>
        <Button title="isAvailable" onPress={isAvailableOnPress} />
        <Button
          title="canAddPaymentPassWithAccountId"
          onPress={canAddCardOnPress}
        />
        <Button title="isCardInWallet" onPress={isCardInWalletOnPress} />
      </View>
      <View style={styles.addToWallet}>
        <AddPassButton
          style={{
            height: AppleWallet.AddToWalletButtonHeight,
            width: AppleWallet.AddToWalletButtonWidth,
          }}
          onPress={() => {
            AppleWallet.presentAddPaymentPassViewController({
              apiEndpoint:
                'https://e2e.venus.tenx-platform.com/v3/cards/fcde0f94-d599-4945-8df9-0d5dd9e16ec9/wallets/applePay/requests',
              cardholderName: 'Happy Trails',
              localizedDescription: 'Something here',
              primaryAccountSuffix: '5435',
              primaryAccountIdentifier: '',
              authorization:
                'Bearer ffSG7YiItxVU03DmuwuBLdSxCIQ.92OeF3kvoU3xzJKXnBl2u-BIwaE',
              xApiKey: 'ZfAyosUQIUosKeJAb04HSjeGoLjPEf5a',
            });
          }}
        />
      </View>
    </>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'cyan',
  },
  addToWallet: {
    alignItems: 'center',
    justifyContent: 'center',
    marginVertical: 20,
  },
});
