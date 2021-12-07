import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-apple-wallet' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

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

export function multiply(a: number, b: number): Promise<number> {
  return AppleWallet.multiply(a, b);
}

export function createCalendarEvent(
  name: string,
  location: string
): Promise<number> {
  return AppleWallet.createCalendarEvent(name, location);
}

export function isAvailable(): Promise<boolean> {
  return AppleWallet.isAvailable();
}

export function canAddCard(cardId: string): Promise<boolean> {
  return AppleWallet.canAddCard(cardId);
}

export default AppleWallet;
