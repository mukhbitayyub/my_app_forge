import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/dashboard_body.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final ValueNotifier<String> _stateNotifier;

  @override
  void initState() {
    super.initState();
    _stateNotifier = ValueNotifier<String>('loading');
    unawaited(_loadData());
  }

  Future<void> _loadData() async {
    _stateNotifier.value = 'loading';
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    _stateNotifier.value = 'loaded';
  }

  void _triggerError() {
    _stateNotifier.value = 'error';
  }

  @override
  void dispose() {
    _stateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productivity Hub'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            tooltip: 'Simulate Error',
            onPressed: _triggerError,
          ),
        ],
      ),
      body: DashboardBody(
        stateNotifier: _stateNotifier,
        onRetry: _loadData,
      ),
    );
  }
}
