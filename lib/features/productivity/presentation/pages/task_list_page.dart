import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_forge/features/productivity/presentation/pages/create_task_page.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/task_list_body.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late final ValueNotifier<String> _stateNotifier;

  @override
  void initState() {
    super.initState();
    _stateNotifier = ValueNotifier<String>('loading');
    unawaited(_loadTasks());
  }

  Future<void> _loadTasks() async {
    _stateNotifier.value = 'loading';
    await Future<void>.delayed(const Duration(milliseconds: 1000));
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
        title: const Text('My Tasks'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            tooltip: 'Simulate Error',
            onPressed: _triggerError,
          ),
        ],
      ),
      body: TaskListBody(
        stateNotifier: _stateNotifier,
        onRetry: _loadTasks,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        onPressed: () {
          unawaited(
            Navigator.of(context).push<void>(
              CupertinoPageRoute<void>(
                builder: (context) => const CreateTaskPage(),
              ),
            ).then((_) async {
              await _loadTasks();
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
