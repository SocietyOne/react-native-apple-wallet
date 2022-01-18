import React from 'react';
import {
  NativeModules,
  Platform,
  requireNativeComponent,
  ViewStyle,
  NativeEventEmitter,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-apple-wallet' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';
const UNSUPPORTED_PLATFORM_ERROR =
  'Unsupported platform. Only supported on iOS';

const AppleWallet = NativeModules.AppleWallet
  ? NativeModules.AppleWallet
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );
const nativeEventEmitter = new NativeEventEmitter(AppleWallet);

/*
  requireNativeComponent automatically resolves 'SOAddPassButton' to 'SOAddPassButtonManager'
  Reference : https://reactnative.dev/docs/native-components-ios
 */
const SOAddPassButton = requireNativeComponent('SOAddPassButton');

export class AddPassButton extends React.Component<{
  style: ViewStyle;
  onPress: () => void;
}> {
  render() {
    return <SOAddPassButton {...this.props} />;
  }
}

const SOPaymentButtonPlain = requireNativeComponent('SOPaymentButtonPlain');
export class PaymentButtonPlain extends React.Component<{
  style: ViewStyle;
  onPress?: () => void;
}> {
  render() {
    return <SOPaymentButtonPlain {...this.props} />;
  }
}

const SOPaymentButtonBuy = requireNativeComponent('SOPaymentButtonBuy');
export class PaymentButtonBuy extends React.Component<{
  style: ViewStyle;
  onPress?: () => void;
}> {
  render() {
    return <SOPaymentButtonBuy {...this.props} />;
  }
}

export interface GetPaymentPassInfo {
  leafCertificate: string;
  subCACertificate: string;
  nonce: string;
  nonceSignature: string;
}

function isIos() {
  return Platform.OS === 'ios';
}

export function createCalendarEvent(
  name: string,
  location: string
): Promise<number> {
  if (isIos()) {
    return AppleWallet.createCalendarEvent(name, location);
  }

  return Promise.reject(UNSUPPORTED_PLATFORM_ERROR);
}

export function isAvailable(): Promise<boolean> {
  if (isIos()) {
    return AppleWallet.isAvailable();
  }

  return Promise.reject(UNSUPPORTED_PLATFORM_ERROR);
}

export function canAddCard(cardId: string): Promise<boolean> {
  if (isIos()) {
    return AppleWallet.canAddCard(cardId);
  }

  return Promise.reject(UNSUPPORTED_PLATFORM_ERROR);
}

export function isCardInWallet(cardId: string): Promise<boolean> {
  if (isIos()) {
    return AppleWallet.isCardInWallet(cardId);
  }

  return Promise.reject(UNSUPPORTED_PLATFORM_ERROR);
}

export function sendPaymentPassRequest(
  activationData: string,
  ephemeralPublicKey: string,
  encryptedPassData: string
): Promise<boolean> {
  if (isIos()) {
    return AppleWallet.callAddPaymentPassRequestHandler({
      activationData: activationData,
      ephemeralPublicKey: ephemeralPublicKey,
      encryptedPassData: encryptedPassData,
    });
  }

  return Promise.reject(UNSUPPORTED_PLATFORM_ERROR);
}

export function showAddPaymentPassUI(
  cardholderName: string,
  localizedDescription: string,
  primaryAccountSuffix: string,
  cardId: string
): Promise<boolean> {
  if (isIos()) {
    return AppleWallet.presentAddPaymentPassViewController({
      cardholderName: cardholderName,
      localizedDescription: localizedDescription,
      primaryAccountSuffix: primaryAccountSuffix,
      primaryAccountIdentifier: cardId,
    });
  }

  return Promise.reject(UNSUPPORTED_PLATFORM_ERROR);
}

export default {
  ...AppleWallet,

  addEventListener: (eventType: string, listener: (...args: any[]) => void) =>
    nativeEventEmitter.addListener(eventType, listener, null),

  removeEventListener: (
    eventType: string,
    listener: (...args: any[]) => void
  ): void => {
    nativeEventEmitter.removeListener(eventType, listener);
  },
};
