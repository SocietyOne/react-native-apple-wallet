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
            console.log('onPress pressed');
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
