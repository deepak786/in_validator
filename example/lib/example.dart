import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_validator/in_validator.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final TextEditingController _panCtrl = TextEditingController();
  final TextEditingController _aadhaarCtrl = TextEditingController();
  final TextEditingController _drivingLicenseCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _panCtrl.dispose();
    _aadhaarCtrl.dispose();
    _drivingLicenseCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black12,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 700,
          ),
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              // PAN
              getTextField(
                "PAN",
                _panCtrl,
                () {
                  PANValidator pan = PANValidator();
                  bool isValid = pan.isValid(_panCtrl.text);
                  if (isValid) {
                    _panCtrl.text = pan.format(_panCtrl.text)!;
                  }

                  return isValid;
                },
              ),
              // AADHAAR
              getTextField(
                "AADHAAR",
                _aadhaarCtrl,
                () {
                  AadhaarValidator aadhaar = AadhaarValidator();
                  bool isValid = aadhaar.isValid(_aadhaarCtrl.text);
                  if (isValid) {
                    _aadhaarCtrl.text = aadhaar.format(_aadhaarCtrl.text)!;
                  }

                  return isValid;
                },
              ),
              // DRIVING LICENSE
              getTextField(
                "DRIVING LICENSE",
                _drivingLicenseCtrl,
                () {
                  DrivingLicenseValidator drivingLicense =
                      DrivingLicenseValidator();
                  bool isValid =
                      drivingLicense.isValid(_drivingLicenseCtrl.text);
                  if (isValid) {
                    _drivingLicenseCtrl.text =
                        drivingLicense.format(_drivingLicenseCtrl.text)!;
                  }

                  return isValid;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTextField(String hint, TextEditingController controller,
      bool Function() validator) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
            ),
            controller: controller,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.save,
          ),
          onPressed: () {
            showToast(!validator() ? "invalid" : "valid");
          },
        ),
      ],
    );
  }

  void showToast(String message) {
    // show toast
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      webPosition: 'center',
    );
  }
}
