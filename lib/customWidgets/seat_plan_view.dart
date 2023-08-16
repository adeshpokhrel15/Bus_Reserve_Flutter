import 'package:flutter/material.dart';

class SeatPlanView extends StatelessWidget {
  const SeatPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SeatWidget extends StatefulWidget {
  final String label;
  final bool isBooked;
  final Function(bool) onSelect;
  const SeatWidget(
      {super.key,
      required this.label,
      required this.isBooked,
      required this.onSelect});

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
