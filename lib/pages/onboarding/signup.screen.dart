import 'package:carbonix/pages/navigator/navigator.screen.dart';
import 'package:carbonix/provider/user_details.model.dart';
import 'package:carbonix/theme/theme.dart';
import 'package:carbonix/utils/api_paths.dart';
import 'package:carbonix/utils/network_service.dart';
import 'package:carbonix/widgets/pressable/pressable.widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../widgets/onboarding/topbar.widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? phoneNumberError;
  String? phoneNumber;
  String countryCode = '+91';
  String? otp;
  String? name;
  bool isLoggedIn = false;
  final TextEditingController _phoneController = TextEditingController(),
      _otpController = TextEditingController(),
      _nameController = TextEditingController();
  bool _otpSent = false;
  String? _otpId;

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {
        phoneNumber = _phoneController.value.text;
        _otpId = null;
        if (_otpSent) {
          _otpSent = false;
        }
      });
    });
    _otpController.addListener(() {
      setState(() {
        otp = _otpController.value.text;
      });
    });
    _nameController.addListener(() {
      setState(() {
        name = _nameController.value.text;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    print('Sending OTP');
    await NetworkService().post(
        APIPath.sendOTP, {'phoneNumber': countryCode + (phoneNumber ?? '')},
        (response) {
      print(response);
      setState(() {
        _otpSent = true;
        if (response['body']['orderId'] != null) {
          setState(() {
            _otpId = response['body']['orderId'];
          });
        }
      });
    }, (error) {
      print(error);
      setState(() {
        _otpSent = false;
      });
    }, () {
      print('Processing OTP');
    });
  }

  Future<void> _verifyOtp() async {
    print(name);
    await NetworkService().post(
      APIPath.verifyOTP,
      {
        'phoneNumber': countryCode + (phoneNumber ?? ''),
        'otp': otp,
        'orderId': _otpId,
        'name': name,
      },
      (response) {
        print(response);
        if (response['body']['uid'] != null) {
          print('Verified');
          storage.write(key: 'user-id', value: response['body']['uid']);
          Navigator.of(context).push(
              MaterialWithModalsPageRoute(builder: (_) => NavigatorScreen()));
        } else {
          setState(() {
            _otpSent = false;
          });
        }
      },
      (error) {
        setState(() {
          _otpSent = false;
        });
      },
      () {
        print('Processing OTP');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ThemeColors.blue,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            const TopbarWidget(showBackIcon: false, bottomText: "Sign Up"),
            Positioned(
              top: 300,
              child: Row(
                children: [
                  const SizedBox(width: 20.0),
                  SizedBox(
                    width: screenWidth - 40,
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        focusColor: ThemeColors.darkGreen,
                      ),
                      keyboardType: TextInputType.name,
                      // hintText: 'Phone Number',
                      // isLast: true,
                      // width: 250,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 400,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20.0),
                  CountryCodePicker(
                    onChanged: (value) {
                      setState(() {
                        countryCode = value.toCountryStringOnly();
                      });
                    },
                    padding: EdgeInsets.all(0),
                    initialSelection: 'IN',
                    favorite: ['+91', '+1'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    showFlag: true,
                    alignLeft: false,
                  ),
                  SizedBox(
                    width: screenWidth - 150,
                    child: TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        focusColor: ThemeColors.darkGreen,
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      // hintText: 'Phone Number',
                      // isLast: true,
                      // width: 250,
                    ),
                  ),
                ],
              ),
            ),
            _otpSent
                ? Positioned(
                    top: 500,
                    child: Row(
                      children: [
                        const SizedBox(width: 20.0),
                        SizedBox(
                          width: screenWidth - 40,
                          child: TextField(
                            controller: _otpController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'OTP',
                              focusColor: ThemeColors.darkGreen,
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            // hintText: 'Phone Number',
                            // isLast: true,
                            // width: 250,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Positioned(
              top: _otpSent ? 600 : 550,
              left: 95,
              child: Consumer<UserDetailsModel>(
                  builder: (context, userDetailsModel, child) {
                return Pressable(
                  disabled: phoneNumber?.length != 10 ||
                      (_otpSent && (otp?.length ?? 0) < 4) ||
                      name?.length == 0,
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (!_otpSent) {
                      await _sendOtp();
                    } else {
                      await _verifyOtp();
                      await userDetailsModel.fetchTrips();
                    }
                    // Navigator.of(context).pushReplacement(
                    //     MaterialWithModalsPageRoute(
                    //         builder: (_) => NavigatorScreen()));
                  },
                  child: Opacity(
                    opacity: phoneNumber?.length == 10 ? 1 : 0.5,
                    child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: const LinearGradient(colors: [
                          Color(0xFF00DCF5),
                          Color(0xFF00E078),
                        ]),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      alignment: Alignment.center,
                      child: Text(
                        _otpSent ? "Verify Code" : "Send Code",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Positioned(
              bottom: -120,
              right: -80,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset("images/circle.png", height: 320),
              ),
            )
          ],
        ),
      ),
    );
  }
}
