import * as React from 'react';

import { StyleSheet, View, Text, Button } from 'react-native';
import AppleWallet, { canAddPaymentPass } from 'react-native-apple-wallet';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>();

  React.useEffect(() => {
    // AppleWallet.multiply(3, 7).then(setResult);
  }, []);

  const onPress = async () => {
    // const result = await AppleWallet.multiply(3, 7).then(setResult);
    // console.log('RESULT JS : ', result);
    // AppleWallet.createCalendarEvent('Event name', 'Event Location');
    const res = await AppleWallet.canAddPaymentPass();
    console.log('RESULT JS : ', res);
  };

  return (
    <View style={styles.container}>
      {/*<Text>Test text</Text>*/}
      <Text>Result: {result}</Text>

      <Button
        title="Click to invoke your native module!"
        color="#841584"
        onPress={onPress}
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
