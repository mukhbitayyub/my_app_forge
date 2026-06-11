import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/task_item_card.dart';

class TaskListLoadedView extends StatefulWidget {
  const TaskListLoadedView({super.key});

  @override
  State<TaskListLoadedView> createState() => _TaskListLoadedViewState();
}

class _TaskListLoadedViewState extends State<TaskListLoadedView> {
  final List<Map<String, dynamic>> _tasks = [
    {'id': '1', 'title': 'Design high-fidelity mockups', 'group': 'Today', 'priority': 'High', 'category': 'Work'},
    {'id': '2', 'title': 'Gym training & cardio', 'group': 'Today', 'priority': 'Medium', 'category': 'Health'},
    {'id': '3', 'title': 'Code review & merge PRs', 'group': 'Today', 'priority': 'High', 'category': 'Work'},
    {'id': '4', 'title': 'Weekly grocery shopping', 'group': 'Upcoming', 'priority': 'Low', 'category': 'Personal'},
    {'id': '5', 'title': 'Review monthly financial budget', 'group': 'Upcoming', 'priority': 'Medium', 'category': 'Finance'},
  ];

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<Map<String, dynamic>>>{};
    for (final task in _tasks) {
      groups.putIfAbsent(task['group'] as String, () => []).add(task);
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: groups.keys.length,
      itemBuilder: (context, index) {
        final groupName = groups.keys.elementAt(index);
        final groupTasks = groups[groupName]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text(
                groupName,
                style: AppTextStyles.titleMediumBold.copyWith(color: AppColors.primaryColor),
              ),
            ),
            ...groupTasks.map((task) => TaskItemCard(
                  task: task,
                  onDismissed: () {
                    setState(() {
                      _tasks.removeWhere((item) => item['id'] == task['id']);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Task "${task['title']}" completed!'),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                )),
          ],
        );
      },
    );
  }
}
