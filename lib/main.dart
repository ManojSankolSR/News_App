import 'package:api/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      home: home(),
    ),
  ));
}
