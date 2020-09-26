import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rave_flutter/src/bloc/_mobile_money_bloc.dart';
import 'package:rave_flutter/src/models/momo_response.dart';

import '../../rave_constants.dart';

class UGMobileMoneyUtils {
  static Widget buildPayButton(MobileMoneyBloc _bloc,String amount, Function() pay) {
    return StreamBuilder<bool>(
        stream: _bloc.isInputInValid,
        builder: (context, snapshot) {
          return RaisedButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(children: <Widget>[
                Expanded(child: Text(
                  "Pay UGX $amount",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 18),
                )),
                Icon(CupertinoIcons.right_chevron,color: Colors.white,),
                Container(width: 10,)
              ],),
              onPressed: snapshot.hasData ? pay : null);
        });
  }

  static Widget buildLoadingPayButton(
      Future<MoMoResponse> future,
      Function() retry,
      Function(MoMoResponse moMoResponse) redirect,
      Color _primaryColor) {
    return FutureBuilder<MoMoResponse>(
        future: future,
        builder: (context, AsyncSnapshot<MoMoResponse> snapshot) {
          return MaterialButton(
              color: _getButtonColor(snapshot, _primaryColor),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: _buildLoadingWidget(snapshot, (MoMoResponse resp) {
                Future.delayed(const Duration(seconds: 5), () {
                  redirect(resp);
                });
              }),
              onPressed: () {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // Retry
                    retry();
                  }
                }
              });
        });
  }

  static Widget _buildLoadingWidget(
      AsyncSnapshot<MoMoResponse> snapshot, Function(MoMoResponse) onRedirect) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        );
        break;
      default:
        if (snapshot.hasError) {
          print(snapshot.error);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                CupertinoIcons.clear_circled_solid,
                color: Colors.white,
              ),
              Container(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Failed to initiate payment (Retry)",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        } else {
          if (onRedirect != null) onRedirect(snapshot.data);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Colors.white,
              ),
              Container(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Payment Initiated, We shall redirect you shortly to complete the payment.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        }
        break;
    }
  }

  static Color _getButtonColor(
      AsyncSnapshot<MoMoResponse> snapshot, Color _primaryColor) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return _primaryColor;
        break;
      default:
        if (snapshot.hasError) {
          return errorColor;
        } else {
          return successColor;
        }
        break;
    }
  }
}
