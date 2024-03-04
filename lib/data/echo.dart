import 'dart:developer';

import 'package:flutter/foundation.dart';


kEcho(String text) {
  if (kDebugMode) log('✅ $text');
}

kEcho100(String text) {
  if (kDebugMode) log('💯 $text');
}

kEchoError(String text) {
  if (kDebugMode) log('❌ $text');
}

kEchoTemp(String text) {
  if (kDebugMode) log('👅 $text');
}

kEchoSearch(String text) {
  if (kDebugMode) print('🔎 $text');
}

kEchoData(String? text) {
  if (kDebugMode) print('📝 $text');
}

kEchoCool(String? text) {
  if (kDebugMode) print('🆒 $text');
}