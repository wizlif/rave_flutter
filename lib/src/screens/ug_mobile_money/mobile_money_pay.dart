import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:rave_flutter/src/bloc/_mobile_money_bloc.dart';
import 'package:rave_flutter/src/bloc/provider.dart';
import 'package:rave_flutter/src/helpers/regex.dart';
import 'package:rave_flutter/src/helpers/utils.dart';
import 'package:rave_flutter/src/models/momo_response.dart';
import 'package:rave_flutter/src/rave_constants.dart';
import 'package:rave_flutter/src/screens/ug_mobile_money/complete_payment/otp_entry.dart';
import 'package:rave_flutter/src/screens/ug_mobile_money/utils.dart';

class UgandaMobileMoneyPay extends StatefulWidget {
  final String secretKey;
  final String email;
  final String transactionId;
  final String fullName;
  final String businessName;
  final int amount;
  final Function(String) onError;
  final Function(Map) onPaymentComplete;
  final Function(MoMoResponse) onPaymentInitiated;
  final String redirectURL;

  const UgandaMobileMoneyPay(
    this.secretKey,
    this.amount,
    this.email,
    this.transactionId, {
    Key key,
    this.fullName,
    this.onError,
    this.onPaymentComplete,
    this.onPaymentInitiated,
    this.businessName,
    this.redirectURL = "https://rave-webhook.herokuapp.com/receivepayment",
  }) : super(key: key);

  @override
  _UgandaMobileMoneyPayState createState() => _UgandaMobileMoneyPayState();
}

class _UgandaMobileMoneyPayState extends State<UgandaMobileMoneyPay> {
  final _bloc = $Provider.of<MobileMoneyBloc>();

  Future<MoMoResponse> _initiatingPayment;

  Color _primaryColor;

  MoMoResponse _moMoResponse;

  @override
  void initState() {
    _bloc.changeAmount("${widget.amount}");
    if (widget.amount < 500) {
      _bloc.setError("Mobile Money amount can't be less than 500.");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _primaryColor = Theme.of(context).primaryColor;

    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/rave_logo.png",
                      package: 'rave_flutter'),
                  maxRadius: 30,
                ),
                Expanded(child: Container()),
                Text(widget.businessName != null ? widget.businessName : "",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: 'Segoe-UI',
                        color: textColor))
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            child: _moMoResponse == null
                ? Container(
                    color: payBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: ListView(
                      children: <Widget>[
                        // StreamBuilder<int>(
                        //   stream: _bloc.amount,
                        //   builder: (context, snapshot) {
                        //     return TextField(
                        //       decoration: InputDecoration(
                        //         labelText: "Amount",
                        //         errorText: snapshot.hasError ? "${snapshot.error}" : null,
                        //       ),
                        //       onChanged: _bloc.changeAmount,
                        //     );
                        //   },
                        // ),
                        // Text("UGX ${widget.amount}"),
                        RichText(
                          text: TextSpan(
                              text: "UGX ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  fontFamily: 'Segoe-UI',
                                  color: textColor),
                              children: [
                                TextSpan(
                                    text: "${widget.amount}".replaceAllMapped(
                                        RegexHelper.reg, Utils.mathFunc),
                                    style: TextStyle(fontSize: 20))
                              ]),
                        ),
                        Container(
                          height: 5,
                        ),
                        Text(
                          "${widget.email}",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Segoe-UI',
                              fontWeight: FontWeight.w300,
                              color: textColor),
                        ),
                        Container(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                          stream: _bloc.phone,
                          builder: (context, snapshot) {
                            return TextField(
                              keyboardType: TextInputType.phone,
                              autocorrect: false,
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15),
                              cursorColor: textColor,
                              maxLength: 10,
                              decoration: InputDecoration(
                                labelText: "PHONE NUMBER",
                                contentPadding: EdgeInsets.only(left: 20),
                                labelStyle: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide()),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(color: _primaryColor)),
                                errorText: snapshot.hasError
                                    ? "${snapshot.error}"
                                    : null,
                              ),
                              onChanged: _bloc.changePhone,
                            );
                          },
                        ),
                        Container(
                          height: 10,
                        ),
                        _initiatingPayment == null
                            ? UGMobileMoneyUtils.buildPayButton(
                                _bloc,
                                "${widget.amount}".replaceAllMapped(
                                    RegexHelper.reg, Utils.mathFunc),
                                startPay)
                            : UGMobileMoneyUtils.buildLoadingPayButton(
                                _initiatingPayment,
                                startPay,
                                redirect,
                                _primaryColor,
                              ),
                        Container(
                          height: 5,
                        ),
                        StreamBuilder<String>(
                          stream: _bloc.error,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data,
                                style: TextStyle(color: Colors.red),
                              );
                            }
                            return Container();
                          },
                        )
                      ],
                    ),
                  )
                : buildOTPRedirect(context),
          ),
        ],
      ),
    );
  }

  startPay() {
    setState(() {
      _initiatingPayment = _bloc.sendMoMoRequest(
        widget.secretKey,
        widget.amount,
        widget.email,
        widget.transactionId,
        fullName: widget.fullName,
      );
    });
  }

  FlutterWebviewPlugin _webViewPlugin;

  buildOTPRedirect(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: OTPRedirect(
              moMoResponse: _moMoResponse,
              redirectURL: widget.redirectURL,
              webViewPlugin: (wv) => _webViewPlugin = wv,
              onPaymentComplete: (Map response) {
                reset();
                TextStyle whiteText = TextStyle(color: Colors.white);
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Momo Payment",
                          style: whiteText,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.check_mark_circled,
                              color: Colors.white,
                              size: 100,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text(
                              "MoMo Payment Completed",
                              style: whiteText,
                            )
                          ],
                        ),
                        backgroundColor: Colors.green,
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                if (widget.onPaymentComplete != null)
                                  widget.onPaymentComplete(response);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Ok",
                                style: whiteText,
                              ))
                        ],
                      );
                    });

                setState(() {
                  _moMoResponse = null;
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  color: Colors.lightBlue,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.refresh_circled,
                        color: Colors.white,
                      ),
                      Container(
                        width: 10,
                      ),
                      Text(
                        "Refresh",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {
                    if (_webViewPlugin != null)
                      _webViewPlugin
                          .reloadUrl(_moMoResponse.meta.authorization.redirect);
                  },
                ),
              ),
              Container(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.orange,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(CupertinoIcons.clear_circled, color: Colors.white),
                      Container(
                        width: 10,
                      ),
                      Text("Cancel", style: TextStyle(color: Colors.white))
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {
                    reset();
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  redirect(MoMoResponse moMoResponse) {
    if (widget.onPaymentInitiated != null)
      widget.onPaymentInitiated(moMoResponse);

    setState(() {
      _moMoResponse = moMoResponse;
    });
  }

  reset() {
    _bloc.reset();
    setState(() {
      _initiatingPayment = null;
      _moMoResponse = null;
    });
  }
}
