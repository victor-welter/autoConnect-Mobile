import 'package:flutter/material.dart';

class SyncServiceView extends StatefulWidget {
  const SyncServiceView({super.key});

  @override
  State<SyncServiceView> createState() => _SyncServiceViewState();
}

class _SyncServiceViewState extends State<SyncServiceView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
    );
  }
}
