import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class Utils {
  static final _telephony = Telephony.instance;

  static sendSms({required String phoneNumber, required String message}) async {
    await _telephony.sendSms(
        to: phoneNumber,
        message: message,
        statusListener: (status) {
          print('Status: ${status.name}');
        },
    );
  }

  static requestPermission() async {
    var status = await Permission.sms.status;
    bool? permissionsGranted = await _telephony.requestPhoneAndSmsPermissions;

    // if (!status.isGranted) {
    //   await Permission.sms.request();
    // }
  }
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    if (oldValue.text.length > newValue.text.length) {
      if (newText.length == 4) {
        return const TextEditingValue(text: '+998 ');
      }

      return TextEditingValue(text: newText);
    }

    if (RegExp(r'[0-9]').hasMatch(newText[newText.length - 1])) {
      if (newText.length == 7 || newText.length == 11 || newText.length == 14) {
        return TextEditingValue(text: '$newText ');
      }

      return newValue;
    } else {
      return TextEditingValue(text: oldValue.text);
    }
  }
}