//all application routes are placed here
//Routes - Navigation
import 'package:flutter/material.dart';
import '/config/constants/AppConstants.dart';
import '/modules/screens/dashboard.dart';

import '../../core/auth/screens/login.dart';
import '../../core/auth/screens/register.dart';

Map<String,WidgetBuilder>getRoutes() {
  return {
    RouteConstants.LOGIN:(context) => const Login(),
    RouteConstants.REGISTER:(context) => const Register(),
    RouteConstants.DASHBOARD:(context) => const Dashboard(),
  };
}