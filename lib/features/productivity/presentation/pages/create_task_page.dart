import 'package:flutter/material.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/create_task_body.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  late final ValueNotifier<String> _stateNotifier;

  @override
  void initState() {
    super.initState();
    _stateNotifier = ValueNotifier<String>('loaded');
  }

  void _triggerError() {
    _stateNotifier.value = 'error';
  }

  void _resetToForm() {
    _stateNotifier.value = 'loaded';
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
        title: const Text('Create Task'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            tooltip: 'Simulate Error',
            onPressed: _triggerError,
          ),
        ],
      ),
      body: CreateTaskBody(
        stateNotifier: _stateNotifier,
        onRetry: _resetToForm,
      ),
    );
  }
}
