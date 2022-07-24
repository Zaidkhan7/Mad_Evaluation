import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/modules/screens/dashboard.dart';

void main()  {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Dashboard(), //once initial route defined no need to mention home
    // initialRoute: RouteConstants.DASHBOARD, //inital or base route
    // routes: getRoutes(), //all routes are loaded here 
  ));
}