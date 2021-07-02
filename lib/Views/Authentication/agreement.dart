import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xplor_driver_app/Models/models/signup_model.dart';
import 'package:xplor_driver_app/Views/Authentication/otp_page.dart';

class Agreement extends StatefulWidget {
  Agreement({Key key}) : super(key: key);

  @override
  _AgreementState createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map data = {};
  String _mobile;
  String _name;
  bool isAgreed = false;

  @override
  void initState() {
    if (Get.arguments != null) {
      data = Get.arguments;
      print(data);
      _mobile = data['mobile'];
      _name = data['name'];
    }
    super.initState();
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
        padding: EdgeInsets.fromLTRB(34.w, 10.h, 33.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Row(children: [
              SizedBox(
                width: 257.5.w,
                child: RichText(
                  text: TextSpan(
                    text:
                        'Check the box to indicate you are at least 18 years of age, agree to the ',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0x88000000),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms & Conditions ',
                        style: TextStyle(
                          color: Color(0xff002C3E),
                        ),
                      ),
                      TextSpan(
                        text: 'and acknowledge the ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(
                          color: Color(0xff002C3E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 21.w),
              InkWell(
                onTap: () {
                  setState(() {
                    isAgreed = !isAgreed;
                  });
                },
                child: Container(
                  width: 16.h,
                  height: 16.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: isAgreed ? Color(0xff002c3e) : Colors.white,
                    border: Border.all(
                      color: Color(0xffC4C4C4),
                      width: 2.w,
                    ),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 13.h,
                  ),
                ),
              ),
            ]),
            Spacer(),
            ElevatedButton(
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: isAgreed ? Colors.white : Color(0xffb3bec5),
                ),
              ),
              onPressed: () async {
                print("Pressed Auth Next Button");
                print(isAgreed);
                if (!isAgreed) {
                  return;
                }
                print(_mobile);
                print(_name);
                SignUpModal objSignup =
                    new SignUpModal(mobile: _mobile, name: _name);
                bool resultSignup = await objSignup.signUpUser();
                Map responseSignup = objSignup.getResponse();

                if (resultSignup) {
                  print("success");

                  Get.to(OTPPage(), arguments: {
                    'mobile': _mobile,
                  });
                } else {
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(responseSignup['message']),
                    duration: Duration(seconds: 3),
                  );

                  // ignore: deprecated_member_use
                  _scaffoldKey.currentState.showSnackBar(snackBar);

                  print("failed");
                }
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.fromLTRB(0, 8, 0, 8.8)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    isAgreed ? Color(0xff002c3e) : Color(0xfff4f4f4)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    isAgreed ? Color(0xff002c3e) : Color(0xfff4f4f4)),
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
