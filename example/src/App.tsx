import * as React from 'react';

import { StyleSheet, View, Button } from 'react-native';
import AppleWallet, {
  isAvailable,
  canAddCard,
  AddPassButton,
  isCardInWallet,
  sendPaymentPassRequest,
  PaymentButtonPlain,
  PaymentButtonBuy,
  showAddPaymentPassUI,
  GetPaymentPassInfo,
  dismissAddPaymentUI,
} from 'react-native-apple-wallet';
import { useEffect } from 'react';
import testPaymentPassRequestData from './testPaymentPassRequestData.json';

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

  useEffect(() => {
    const event = ({ args }: GetPaymentPassInfo) => {
      console.log(
        'generatedCertChainAndNonce payload : ',
        JSON.stringify(args)
      );

      console.log('Call 10x api ', testPaymentPassRequestData);

      (async () => {
        const sendPaymentPassRequestResult = await sendPaymentPassRequest(
          testPaymentPassRequestData.activationData,
          testPaymentPassRequestData.ephemeralPublicKey,
          testPaymentPassRequestData.encryptedData
        );

        console.log(
          'sendPaymentPassRequestResult ',
          sendPaymentPassRequestResult
        );
      })();
    };
    AppleWallet.addEventListener('getPaymentPassInfo', event);

    return () => {
      AppleWallet.removeEventListener('getPaymentPassInfo', event);
    };
  });

  useEffect(() => {
    setTimeout(() => {
      (async () => {
        try {
          await dismissAddPaymentUI();
        } catch (error) {
          console.log("Dismiss add payment ui reject. But we don't care");
        }
      })();
    }, 5000);
  }, []);

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
        <PaymentButtonPlain
          style={{
            height: AppleWallet.PaymentButtonHeight,
            width: AppleWallet.PaymentButtonPlainWidth,
          }}
        />
      </View>
      <View style={styles.addToWallet}>
        <PaymentButtonBuy
          style={{
            height: AppleWallet.PaymentButtonHeight,
            width: AppleWallet.PaymentButtonBuyWidth,
          }}
        />
      </View>
      <View style={styles.addToWallet}>
        <AddPassButton
          style={{
            height: AppleWallet.AddPassButtonHeight,
            width: AppleWallet.AddPassButtonWidth,
          }}
          onPress={async () => {
            await showAddPaymentPassUI(
              'Happy Trails',
              'Something here',
              '5435',
              '12312312312312'
            );
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
