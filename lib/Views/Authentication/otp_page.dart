import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xplor_driver_app/Models/models/login_model.dart';
import 'package:xplor_driver_app/Models/models/otp_model.dart';
import 'package:xplor_driver_app/Models/models/signup_model.dart';
import 'package:xplor_driver_app/Views/home_screen.dart';

Color errorColor = Color(0xffE52A0E);

class OTPPage extends StatefulWidget {
  const OTPPage({Key key}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String otp = '';
  bool inCorrectOTP = false;
  String _mobile;
  Map data = {};
  bool isResend = false;
  Timer _timer;
  bool isTimerInitializes = false;
  FocusNode fNode1, fNode2, fNode3, fNode4;
  String otp1, otp2, otp3, otp4;
  resendPressable() {
    setState(() {
      isTimerInitializes = true;
    });
    _timer = new Timer(const Duration(seconds: 30), () {
      setState(() {
        isResend = false;
      });
    });
  }

  @override
  void initState() {
    fNode1 = FocusNode();
    fNode2 = FocusNode();
    fNode3 = FocusNode();
    fNode4 = FocusNode();
    if (Get.arguments != null) {
      data = Get.arguments;
      print(data);
      _mobile = data['mobile'];
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (isTimerInitializes) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
                size: 20.sp,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/icons/promologo.png',
              width: 30.w,
            ),
            SizedBox(width: 15.w),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(34.w, 10.h, 33.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Enter the 4-digit code sent to you at',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0x77000000),
              ),
            ),
            Text(
              _mobile,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xbf000000),
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color:
                                      inCorrectOTP ? errorColor : Colors.black,
                                  width: 1),
                            ),
                          ),
                          child: Center(
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  inCorrectOTP = false;
                                });
                              },
                              focusNode: fNode1,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    otp1 = value.toString();
                                    fNode2.requestFocus();
                                    print(otp1);
                                  }
                                });
                              },
                              autofocus: true,
                              maxLength: 1,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0x33000000),
                                ),
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              textAlign: TextAlign.center,
                              obscureText: true,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: EdgeInsets.only(left: 13.w),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color:
                                      inCorrectOTP ? errorColor : Colors.black,
                                  width: 1),
                            ),
                          ),
                          child: Center(
                            child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              focusNode: fNode2,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    otp2 = value.toString();
                                    fNode3.requestFocus();
                                    print(otp2);
                                  } else {
                                    fNode1.requestFocus();
                                  }
                                });
                              },
                              maxLength: 1,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0x33000000),
                                ),
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              textAlign: TextAlign.center,
                              obscureText: true,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: EdgeInsets.only(left: 13.w),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color:
                                      inCorrectOTP ? errorColor : Colors.black,
                                  width: 1),
                            ),
                          ),
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              focusNode: fNode3,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    otp3 = value.toString();
                                    fNode4.requestFocus();
                                    print(otp3);
                                  } else {
                                    fNode2.requestFocus();
                                  }
                                });
                              },
                              maxLength: 1,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0x33000000),
                                ),
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              textAlign: TextAlign.center,
                              obscureText: true,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 13.w),
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color:
                                      inCorrectOTP ? errorColor : Colors.black,
                                  width: 1),
                            ),
                          ),
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              focusNode: fNode4,
                              onChanged: (value) async {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    otp4 = value.toString();
                                    fNode4.unfocus();
                                    print(otp4);
                                  } else {
                                    fNode3.requestFocus();
                                  }
                                });
                              },
                              maxLength: 1,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0x33000000),
                                ),
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              textAlign: TextAlign.center,
                              obscureText: true,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //
                  ],
                ),
              ],
            ),
            SizedBox(height: 15.h),
            inCorrectOTP
                ? Text(
                    'The SMS code you’ve entered is incorrect.',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w300,
                      color: errorColor,
                    ),
                  )
                : SizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Didn\'t get the code?',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w300,
                    color: Color(0xbf000000),
                  ),
                ),
                GestureDetector(
                  onTap: isResend
                      ? null
                      : () async {
                          resendPressable();
                          setState(() {
                            isResend = true;
                          });
                          print("Resend pressed");
                          LoginModal objLogin = new LoginModal(mobile: _mobile);
                          bool resultLogin = await objLogin.loginUser();

                          SignUpModal objSignup =
                              new SignUpModal(mobile: _mobile, name: '');
                          bool resultSignup = await objSignup.signUpUser();
                          Map responseSignup = objSignup.getResponse();

                          if (resultLogin) {
                            print(
                                'OTP Resend Successful->Existing User : $_mobile');
                          } else if (resultSignup) {
                            print("OTP Resend Successful->New User : $_mobile");
                          } else {
                            final snackBar = SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(responseSignup['message']),
                              duration: Duration(seconds: 3),
                            );

                            // ignore: deprecated_member_use
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            print('Login Failed');
                          }
                        },
                  child: Text(
                    ' Resend Code',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: isResend ? Colors.grey[300] : Color(0xfff7444e),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                setState(() {
                  otp = otp1 + otp2 + otp3 + otp4;
                });

                if (otp.length == 4) {
                  OtpModal obj = new OtpModal(mobile: _mobile, otp: otp);
                  bool result = await obj.sendOtp();
                  Map response = obj.getResponse();

                  if (result) {
                    print('otp verification success');

                    Get.offAll(() => HomeScreen());
                  } else {
                    if (response['message'] == 'Incorrect OTP!') {
                      setState(() {
                        inCorrectOTP = true;
                      });
                    }

                    print('otp verification failed');
                  }
                } else {
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text("Please fill all fields"),
                    duration: Duration(seconds: 3),
                    elevation: 20,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.fromLTRB(0, 8, 0, 8.8)),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Color(0x88002c3e)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff002c3e)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
