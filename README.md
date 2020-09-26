<p align="center">
    <img title="Flutterwave" height="200" src="https://flutterwave.com/images/logo-colored.svg" width="50%"/>
</p>

# Flutterwave Flutter SDK

Flutterwave's Flutter SDK can be used to integrate the Flutterwave payment gateway into your flutter app. It comes with a ready-made Drop In UI and non-UI module, depending on your preference.

The payment methods currently supported is UG Mobile Money with Cards, USSD, Mpesa, GH Mobile Money, ZM Mobile Money, Rwanda Mobile Money, Franc Mobile Money, US ACH, UK Bank, SA Bank, Nigeria Bank Account, Nigeria Bank Transfer and Barter Mobile Wallet to be added as we progress.

## Before you begin
- Ensure you have your test (and live) [API keys](https://developer.flutterwave.com/docs/api-keys).

## Requirements
- The Flutter SDK range supported is `>=2.7.0 <3.0.0`
- Flutter version supported is `>=1.10.0`.


## Getting Started

- [Installation](#installation)
- [Basic Usage](#basic-usage)
  + [UG Mobile Money Widget](#ug-mobile-money-widget)
  + [UG Mobile Money Core](#ug-mobile-money-core)
- [Constructor](#constructor)


## Adding it to your project

**Step 1.** Add it in your root `pubsec.yaml` 

```bash

rave_flutter : ^lastest_version

```
and run

```bash
flutter packages get
```
in your project's root directory.

**Step 2.** Add the  `INTERNET` permission to your android manifest

     <uses-permission android:name="android.permission.INTERNET" /> 

## Basic Usage

Create a new project with command

```
flutter create myapp
```

### UG Mobile Money Widget
Edit `lib/main.dart` like this:

```dart

import 'package:flutter/material.dart';

import 'package:rave_flutter/rave_flutter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: UgandaMobileMoneyPay(
            "SECRET-KEY",
            "AMOUNT",
            "EMAIL",
            "TRANSACTION REFERENCE",
            fullName: "USER NAME",
            businessName: "BUSINESS NAME",
          ),
        ),
      ),
      theme: ThemeData(
        primaryColor: Colors.orange
      ),
    );
  }
}


```

Replace `SECRET-KEY`, `AMOUNT`, `EMAIL`, `TRANSACTION REFERENCE`, `USER NAME` and `BUSINESS NAME` with their appropriate values.
see:[Basic constructor for more details on each](#basic)


### Constructor


#### Basic

| Parameter  |  Required  | Type   | Description |
| :------------: | :---------------: |:---------------:| :-----|
| secretKey | True | `String` | Your Flutter Wave secret key, remember to keep this key secret through code obfuscation or store it on a secure server. If you have no key you can [generate one by following instructions on flutter wave](https://developer.flutterwave.com/docs/api-keys#obtaining-your-api-keys) |
| email | True | `String` |This is the email address of the customer. This email address is used to send a customer a receipt when a transaction is completed.|
| amount | True | `int` |  The amount of money to be charged. This should not be less than 500 shillings. |
| transactionId | True | `String` |  This is a unique reference, unique to the particular transaction being carried out. |
| fullName | False | `String` | This is the customers full name. It should include first and last name of the customer. |
| businessName | False | `String`  | The Business Name to be displayed on the payment widget banner |
| redirectUrL | False | `String`  | The webpageto redirect to once the payment is complete |
| onError | False | `Function(String)`  | Called with any error pertaining to the transaction |
| onPaymentComplete | False | `Function(Map)`  | Called with the transaction details once a payment is completed |
| onPaymentInitiated | False | `Function(MoMoResponse)`  | Called with the mobile money details when the transaction has been initiated successfully |

### UG Mobile Money Core
Incase you do not want to use the widget, you can access the `Function` to call to initiate the mobilemoney payment.

The function has the definition
```dart
Future<MoMoResponse> sendMoMoRequest(String secretKey,String phoneNumber,int amount,String email,String txRef,
    { String fullName,String redirectURL})
```
>see:[The Constructor for each item's definition](#constructor)

This function responds ith a `Future` of type `MoMoResponse` which contain a link to load and complete your payment.

### Preview
<img src="https://raw.githubusercontent.com/wizlif/rave_flutter/master/example/media/preview.gif">

## Contribute

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request