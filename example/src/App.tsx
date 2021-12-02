import * as React from 'react';

import { StyleSheet, View, Button } from 'react-native';
import AppleWallet from 'react-native-apple-wallet';

export default function App() {
  const canAddPaymentPassOnPress = async () => {
    const canAddPaymentPassResult = await AppleWallet.canAddPaymentPass();
    console.log('AppleWallet.canAddPaymentPass JS : ', canAddPaymentPassResult);
  };

  const canAddPaymentPassWithPrimaryAccountIdentifierOnPress = async () => {
    const canAddPaymentPassResult = await AppleWallet.canAddPaymentPass();
    console.log('AppleWallet.canAddPaymentPass JS : ', canAddPaymentPassResult);
  };

  return (
    <View style={styles.container}>
      <Button title="canAddPaymentPass" onPress={canAddPaymentPassOnPress} />
      <Button
        title="canAddPaymentPassWithPrimaryAccountIdentifier"
        onPress={canAddPaymentPassWithPrimaryAccountIdentifierOnPress}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
