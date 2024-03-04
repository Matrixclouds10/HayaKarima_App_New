// ignore_for_file: constant_identifier_names


import 'package:flutter/material.dart';

// const String URL = 'https://hayhkarima.com/api/';


// const String URL = 'https://hayakarima.orbscope.net/api/';
const String URL = 'https://hayakarima.dev02.matrix-clouds.com/api/';

// const String URL_MAP = 'https://hayhkarima.com/api/map';
 const String URL_MAP = 'https://hayakarima.dev02.matrix-clouds.com/api/map';

/// -----------------------------------
///           SharedPreferences Variables
/// -----------------------------------

const String ACCESS_TOKEN = 'accessToken';
const String STATUS = 'status';
const String UserName = 'name';
const String UserImage = 'image';
const String UserCity = 'city';
const String UserEmail = 'email';
const String UserGovernment = 'government';
const String UserPhone = 'phone';
const String ID_TOKEN = 'accessToken';
const String language_code = 'language_code';

/// -----------------------------------
///
///           Home Screen
///
/// -----------------------------------

double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

const double defaultPadding = 16.0;
