import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'agreement.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Map data = {};
  String _mobile;
  String firstName;
  String lastName;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    data = Get.arguments;
    _mobile = data['mobile'];

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
            Text(
              'Whats\'s your name?',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0x88000000),
              ),
            ),
            SizedBox(height: 60.h),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Container(
                    width: 140.w,
                    child: TextFormField(
                      controller: firstNameController,
                      validator: (value) =>
                          value.isEmpty ? 'Cannot be Empty' : null,
                      onChanged: (val) {
                        firstName = firstNameController.text;
                      },
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xbf000000),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        filled: false,
                        hintText: 'First Name',
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xbf000000),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 22.w),
                    width: 140.w,
                    child: TextFormField(
                      controller: lastNameController,
                      validator: (value) =>
                          value.isEmpty ? 'Cannot be Empty' : null,
                      onChanged: (val) {
                        lastName = lastNameController.text;
                      },
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xbf000000),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        filled: false,
                        hintText: 'Last Name',
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xbf000000),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                print("Pressed Auth Next Button");
                if (_formKey.currentState.validate()) {
                  String _name = firstName + " " + lastName;
                  print(_name);
                  print(_mobile);
                  Get.to(() => Agreement(), arguments: {
                    'mobile': _mobile,
                    'name': _name,
                  });
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
