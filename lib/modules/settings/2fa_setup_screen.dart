import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/helpers/http.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:websafe_svg/websafe_svg.dart';

class TwoFactorSetupScreen extends StatefulWidget {
  final dynamic clientId;

  const TwoFactorSetupScreen({super.key, required this.clientId});

  @override
  State<TwoFactorSetupScreen> createState() => _TwoFactorSetupScreenState();
}

class _TwoFactorSetupScreenState extends State<TwoFactorSetupScreen> {
  int? _index = 0;
  String? urlTotp;
  bool? appIsInstalled;
  TextEditingController? _textController;
  int? _totpCode;
  String qrLink = "null";
  String key = "";
  String formattedKey = "";

  @override
  void initState() {
    setQrLink();
    _textController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void setQrLink() async {
    var request = await http.post(
        Uri.parse('https://devservices.oshinstar.com/v3/auth'),
        body: json
            .encode({"eventType": "request_qr", "clientId": widget.clientId}),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer'
        });

    setState(() {
      qrLink = json.decode(request.body)["link"];
      key = json.decode(request.body)["key"];
      formattedKey = json.decode(request.body)["formattedKey"];
    });
  }

  Future<bool> validateTOTP() async {
    var request = await Http.post('v3/auth', {
      "eventType": "validate_totp",
      "clientId": widget.clientId,
      "totp": _totpCode.toString()
    });

    return request["valid"];
  }

  _onStepContinue() async {
    if (_index != 2) {
      _index = (_index ?? 0) + 1;
      setState(() {});
    } else {
      if ((_textController?.text.length ?? 0) > 0) {
        FocusScope.of(context).unfocus();
      }
    }
  }

  Future<void> _openTOTP(String link) async {
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(link)) {
        // ignore: deprecated_member_use
        await launch(link, forceSafariVC: false);
      } else {
        showDialog(
            context: context,
            builder: (_) => Dialog(
                  child: Text("Error"),
                ));
      }
    } catch (e) {
      print("Error: $e");
      showDialog(
          context: context,
          builder: (_) => Dialog(
                child: Text("Error"),
              ));
    }
  }

  Widget controlBuilders(context, details) {
    String nextKey = _index == 2 ? 'Done' : 'Next';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: Text(nextKey),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "x. Successfully activated two-factor authentication for your account.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WebsafeSvg.asset(
              'lib/assets/images/check.svg',
              width: 80,
              height: 80,
            ),
            Container(height: 30),
            Container(
              height: 40,
              width: 105,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Done",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Two factor authentication'),
      ),
      body: Container(
        color: Colors.grey.withOpacity(.2),
        padding: const EdgeInsets.only(left: 20, right: 17),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Two factor authentication is a process involving two factors to verify your identity when using secure online services.',
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'This involves something you know i.e., your and something you have, i.e., - your phone.',
                  textAlign: TextAlign.justify,
                ),
              ),
              Stepper(
                controlsBuilder: controlBuilders,
                physics: NeverScrollableScrollPhysics(),
                steps: [
                  Step(
                    title: Text('Abrir la aplicacion'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Abrir la aplicacion "Autenticador".'),
                        GestureDetector(
                          child: Text(
                            'Necesitas una aplicacion?',
                            style: TextStyle(color: OshinPalette.blue),
                          ),
                          onTap: () {
                            print("hello world");
                          },
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: Text('Escanea o presione el QR'),
                    content: Align(
                      alignment: Alignment.centerLeft,
                      child: Builder(
                        builder: (context) => GestureDetector(
                          onTap: () async {
                            await _openTOTP(qrLink);
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: OshinPalette.lightGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 155,
                                height: 150,
                                child: PrettyQrView.data(
                                  data: qrLink == "none" ? "error" : qrLink,
                                  decoration: const PrettyQrDecoration(
                                    shape: PrettyQrSmoothSymbol(
                                      color: Colors.black,
                                      roundFactor: 1,
                                    ),
                                    image: const PrettyQrDecorationImage(
                                      image: AssetImage(
                                          "lib/assets/images/oshinstar_logo.png"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "x. Or paste this code in your authenticator app",
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formattedKey,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.copy),
                                    onPressed: () {
                                      // Copy the key to the clipboard
                                      Clipboard.setData(
                                          ClipboardData(text: key));

                                      // Show a snackbar indicating successful copy
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Key copied to clipboard"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Step(
                    title: Text('Escribe el codigo'),
                    content: Container(
                      child: Column(
                        children: [
                          Text('Write the generated code'),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              onChanged: ((value) async {
                                setState(() {
                                  _totpCode = int.tryParse(value);
                                });
                                if (value.length >= 6) {
                                  final valid = await validateTOTP();

                                  valid == true ? null : null;

                                  valid == true
                                      ? _showSuccessDialog(context)
                                      : null;
                                }
                              }),
                              controller: _textController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[1234567890]'))
                              ],
                              style: TextStyle(letterSpacing: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                currentStep: _index ?? 0,
                onStepTapped: (value) {
                  _index = value;
                  setState(() {});
                },
                onStepContinue:
                    _index == 2 && (_textController?.text.length ?? 0) < 6
                        ? null
                        : _onStepContinue,
                onStepCancel: () => setState(() {
                  print(_index);
                  if (_index == 0) {
                    Navigator.pop(context);
                  } else
                    _index = (_index ?? 0) - 1;
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
