// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// BlocProviderGenerator
// **************************************************************************

class $Provider extends Provider {
  static T of<T extends Bloc>() {
    switch (T) {
      case MobileMoneyBloc:
        {
          return BlocCache.getBlocInstance(
              'MobileMoneyBloc', () => MobileMoneyBloc.instance()) as T;
        }
    }
    return null;
  }

  static void dispose<T extends Bloc>() {
    switch (T) {
      case MobileMoneyBloc:
        {
          BlocCache.dispose('MobileMoneyBloc');
          break;
        }
    }
  }
}
