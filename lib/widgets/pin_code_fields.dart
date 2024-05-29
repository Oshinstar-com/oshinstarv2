import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class NumberPinCodeField extends StatelessWidget {
  const NumberPinCodeField({
    super.key,
    this.onChanged,
    this.length,
    this.controller,
  });

  final void Function(BuildContext, String)? onChanged;
  final int? length;
  final TextEditingController? controller;

  Widget build(BuildContext context) {
    return PinCodeTextField(
      showCursor: false,
      enablePinAutofill: false,
      appContext: context,
      controller: controller,
      length: length ?? 0,
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      pinTheme: PinTheme(
        borderWidth: 4.0,
        inactiveFillColor: const Color.fromRGBO(196, 196, 196, 1),
        activeFillColor: Colors.grey,
        inactiveColor: const Color.fromRGBO(196, 196, 196, 1),
        activeColor: Colors.blue,
        selectedFillColor: const Color.fromRGBO(196, 196, 196, 1),
        selectedColor: Colors.black26,
        shape: PinCodeFieldShape.circle,
      ),
      onCompleted: (value) {
        //controller.clear();
      },
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) async {
        if (value.length == length) {
          onChanged?.call(context, value);
        }
      },
    );
  }
}