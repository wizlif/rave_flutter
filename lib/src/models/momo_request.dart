import 'package:json_annotation/json_annotation.dart';

part 'momo_request.g.dart';

@JsonSerializable()
class MoMoRequest {
  @JsonKey(name: 'tx_ref', nullable: true)
  final String txRef;

  @JsonKey(name: 'amount', required: true)
  final String amount;

  @JsonKey(name: 'email', nullable: true)
  final String email;

  @JsonKey(name: 'phone_number', required: true)
  final String phoneNumber;

  @JsonKey(name: 'currency', required: true, defaultValue: "UGX")
  final String currency;

  @JsonKey(name: 'fullname', nullable: true)
  final String fullname;

  @JsonKey(name: 'redirect_url', nullable: true,defaultValue: "https://rave-webhook.herokuapp.com/receivepayment")
  final String redirectUrl;

  @JsonKey(name: 'order_id', nullable: true)
  final String orderId;

  @JsonKey(name: 'client_ip', nullable: true)
  final String clientIP;

  @JsonKey(name: 'device_fingerprint', nullable: true)
  final String deviceFingerPrint;

  @JsonKey(name: 'network', required: true)
  final String network;

  MoMoRequest(
      {this.txRef,
      this.amount,
      this.email,
      this.phoneNumber,
      this.currency,
      this.fullname,
      this.redirectUrl,
      this.clientIP,
      this.deviceFingerPrint,
      this.orderId,
      this.network});

  factory MoMoRequest.fromJson(Map<String, dynamic> json) =>
      _$MoMoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MoMoRequestToJson(this);
}
