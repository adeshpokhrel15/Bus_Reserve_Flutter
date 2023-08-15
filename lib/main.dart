import 'package:bus_reservation_udemy/pages/app.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppDataProvider(), child: const MyApp()));
}
