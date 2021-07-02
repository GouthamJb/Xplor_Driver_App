import 'dart:async';
import 'dart:io';
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Controllers/location_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  BackgroundLocation _backgroundLocation = new BackgroundLocation();
  Timer _timer;
  bool locationServiceStatus = false;
  bool _isTimerInitialized = false;
  int noOfClick = 0;
  LocationController _locationController = Get.put(LocationController());
  GoogleMapController _controller;
  String _mapStyle;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(8.4845, 76.9477),
    zoom: 14,
  );

  //when page is initialized
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  //when page is detached or resumed
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.paused) {
      _locationController.setAppInactive();
    }
    if ((_locationController.isAppInactive.value) &&
        (state == AppLifecycleState.resumed)) {
      print("From Background");
      _controller.setMapStyle(_mapStyle);
      _locationController.checKLocationPermission();
      _locationController.setAppActive();
    }
    if (state == AppLifecycleState.detached) {
      onStopLocationServiceClick();
    }
    super.didChangeAppLifecycleState(state);
  }

  //when pages is disposed
  @override
  void dispose() {
    super.dispose();
    print('App is closing........');
    if (_isTimerInitialized) {
      _timer.cancel();
    }
    noOfClick = 0;
    locationServiceStatus = false;
    BackgroundLocation.stopLocationService();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<bool> _onwillPopScpoe() async {
    Get.defaultDialog(
        textConfirm: 'Exit App',
        onConfirm: () => exit(0),
        onCancel: () => Get.back(closeOverlays: true),
        title: 'Do you really want to exit?',
        middleText: 'Exiting the application will stop fetching location');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onwillPopScpoe,
      child: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          toolbarHeight: 60.h,
          elevation: 3.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Xplor',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: HexColor('#1F1F1F'),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 5.h, 0, 30.h),
                      child: Text(
                        'Tracking Application',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          color: HexColor('#1F1F1F'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          rotateGesturesEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (controller) async {
            _controller = controller;
            await rootBundle
                .loadString('assets/json_assets/map_style.json')
                .then((value) => {_mapStyle = value});
            _controller.setMapStyle(_mapStyle);
          },
        ),
        bottomNavigationBar: Container(
          height: 150.h,
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 18.w, top: 10.h),
                            child: Text(
                              'Hi,',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                                color: HexColor('#1F1F1F'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                      text: 'PF014',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp,
                                        color: HexColor('#1F1F1F'),
                                      ),
                                      children: [
                                        TextSpan(
                                            text: ', you are assigned to ',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 13.sp,
                                              color: HexColor('#1F1F1F'),
                                            )),
                                        TextSpan(
                                            text: 'Route 201',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.sp,
                                              color: HexColor('#1F1F1F'),
                                            ))
                                      ])),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18.w, top: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Please ensure that the you have activated the ',
                              style: TextStyle(
                                  fontSize: 9.sp, color: HexColor('#1F1F1F')),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'application during duty hours ',
                              style: TextStyle(
                                  fontSize: 9.sp, color: HexColor('#1F1F1F')),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (!locationServiceStatus) {
                        onStartLocationServiceClick();
                      } else {
                        onStopLocationServiceClick();
                      }
                    },
                    child: Container(
                      color: noOfClick != 0
                          ? locationServiceStatus
                              ? HexColor('#F7444E')
                              : HexColor('#18AD00')
                          : HexColor('#002C3E'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                noOfClick != 0
                                    ? locationServiceStatus
                                        ? 'Press to Deactivate'
                                        : 'Activate Live'
                                    : 'Get Ready!',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.sp),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Image.asset('assets/icons/shield.png'),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  onStartLocationServiceClick() async {
    try {
      if (!locationServiceStatus) {
        await BackgroundLocation.setAndroidNotification(
          title: "Xplor Driver App",
          message: "Currently fetching location",
          icon: "@mipmap/ic_launcher",
        );
        setState(() {
          noOfClick++;
          print(noOfClick);
        });

        await BackgroundLocation.startLocationService();
        if (noOfClick == 1) {
          BackgroundLocation.stopLocationService();
        } else {
          print("Background Location Service is starting......");
          await getCurrentLocation();
          setState(() {
            locationServiceStatus = true;
            _timer = new Timer.periodic(Duration(seconds: 12), (Timer t) {
              _isTimerInitialized = true;
              getCurrentLocation();
            });
          });
        }
      } else {
        print("Background Location Service is already runinng.......");
      }
    } catch (e) {
      print(e);
    }
  }

  getCurrentLocation() async {
    await _locationController.checKLocationPermission();
    _backgroundLocation.getCurrentLocation().then((location) => {
          print('This is current Location ' + location.toMap().toString()),
          _locationController.updateLocationString(location.toMap().toString())
        });
  }

  onStopLocationServiceClick() {
    print("Background Location Service is stopping.....");
    setState(() {
      noOfClick = 0;
      locationServiceStatus = false;
      BackgroundLocation.stopLocationService();
      _locationController.updateLocationString('No Available Data');
      if (_isTimerInitialized) {
        _timer.cancel();
      }
    });
  }
}
