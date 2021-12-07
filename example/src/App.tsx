import * as React from 'react';

import { StyleSheet, View, Button } from 'react-native';
import { isAvailable, canAddCard } from 'react-native-apple-wallet';

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

  return (
    <View style={styles.container}>
      <Button title="isAvailable" onPress={isAvailableOnPress} />
      <Button
        title="canAddPaymentPassWithAccountId"
        onPress={canAddCardOnPress}
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
