import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Services/cache_services.dart';
import 'Views/home_screen.dart';
import 'Views/Authentication/get_started.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var accessToken = await CacheService().getAccessToken();
  var refreshToken = await CacheService().getRefreshToken();
  runApp(MyApp(
    accessToken: accessToken,
    refreshToken: refreshToken,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  MyApp({this.accessToken, this.refreshToken});
  final String accessToken;
  final String refreshToken;
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 667),
        builder: () => GetMaterialApp(
              defaultTransition: Transition.cupertino,
              theme: ThemeData(
                primarySwatch: Colors.grey,
                fontFamily: 'OpenSans',
              ),
              debugShowCheckedModeBanner: false,
              home: (widget.accessToken == null && widget.refreshToken == null)
                  ? GetStarted()
                  : HomeScreen(),
            ));
  }
}
