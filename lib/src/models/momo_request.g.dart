// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'momo_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoMoRequest _$MoMoRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['amount', 'phone_number', 'currency', 'network']);
  return MoMoRequest(
    txRef: json['tx_ref'] as String,
    amount: json['amount'] as String,
    email: json['email'] as String,
    phoneNumber: json['phone_number'] as String,
    currency: json['currency'] as String ?? 'UGX',
    fullname: json['fullname'] as String,
    redirectUrl: json['redirect_url'] as String ??
        'https://rave-webhook.herokuapp.com/receivepayment',
    clientIP: json['client_ip'] as String,
    deviceFingerPrint: json['device_fingerprint'] as String,
    orderId: json['order_id'] as String,
    network: json['network'] as String,
  );
}

Map<String, dynamic> _$MoMoRequestToJson(MoMoRequest instance) =>
    <String, dynamic>{
      'tx_ref': instance.txRef,
      'amount': instance.amount,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'currency': instance.currency,
      'fullname': instance.fullname,
      'redirect_url': instance.redirectUrl,
      'order_id': instance.orderId,
      'client_ip': instance.clientIP,
      'device_fingerprint': instance.deviceFingerPrint,
      'network': instance.network,
    };
