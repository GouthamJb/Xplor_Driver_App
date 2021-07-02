import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xplor_driver_app/Models/models/login_model.dart';
import 'package:xplor_driver_app/Views/Authentication/otp_page.dart';
import 'package:xplor_driver_app/Views/Authentication/sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _phoneFieldController = TextEditingController();
   String _mobile;
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
            Image.asset(
              'assets/icons/promologo.png',
              width: 30.w,
            ),
            SizedBox(width: 15.w),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(34.w, 10.h, 33.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Enter your mobile number',
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xbf000000),
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/kerala_tourism_logo.png',
                  width: 39.w,
                ),
                SizedBox(width: 5.w),
                Text(
                  '+91',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xbf000000),
                  ),
                ),
                SizedBox(width: 8.w),
                Form(
                  key: _formKey,
                  child: Container(
                    width: 221.w,
                    child: TextFormField(
                      controller: _phoneFieldController,
                      validator: (value) => value.length != 10
                          ? 'Enter a valid phone number'
                          : null,
                      onChanged: (val) {
                        _mobile = _phoneFieldController.text;
                      },
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xbf000000),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: '944xxxxxx2',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0x33000000),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            Text(
              'By continuing you may recieve an SMS for verification. Message and data rates may apply.',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: Color(0x73000000),
              ),
            ),
            SizedBox(height: 7.h),
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
                print("Pressed Auth Next Button");

                if (_formKey.currentState.validate()) {
                  print(_mobile);
                  LoginModal objLogin = new LoginModal(mobile: _mobile);
                  bool resultLogin = await objLogin.loginUser();
                  Map responseLogin = objLogin.getResponse();
                  Map responseServerLogin = objLogin.responseServer();
                  bool isRegistered = true;
                  print(responseLogin);
                  print(responseServerLogin);

                  if (responseServerLogin["response"] == "Not Registered!") {
                    isRegistered = false;
                  }
                  print(isRegistered);

                  if (resultLogin) {
                    print('Login done');
                    Get.to(() => OTPPage(), arguments: {
                      'mobile': _mobile,
                    });
                  } else if (!isRegistered) {
                    print("Sign Up Started");
                    Get.to(() => SignUp(), arguments: {
                      'mobile': _mobile,
                    });
                  } else {
                    final snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(responseLogin['message']),
                      duration: Duration(seconds: 3),
                    );

                    // ignore: deprecated_member_use
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                    print('Login Failed');
                  }
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
