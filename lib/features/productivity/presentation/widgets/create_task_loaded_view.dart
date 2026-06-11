import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/task_date_field.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/task_priority_selector.dart';

class CreateTaskLoadedView extends StatefulWidget {
  const CreateTaskLoadedView({super.key});

  @override
  State<CreateTaskLoadedView> createState() => _CreateTaskLoadedViewState();
}

class _CreateTaskLoadedViewState extends State<CreateTaskLoadedView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedPriority = 'Medium';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task "${_titleController.text}" created successfully!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a due date'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          Text('Task Title', style: AppTextStyles.titleMediumBold),
          SizedBox(height: 8.h),
          TextFormField(
            controller: _titleController,
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Enter task description...',
              hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey),
              filled: true,
              fillColor: AppColors.lightSurface,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.surface, width: 1.w),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.surface, width: 1.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
              ),
            ),
            validator: (val) =>
                val == null || val.trim().isEmpty ? 'Title is required' : null,
          ),
          SizedBox(height: 24.h),
          Text('Due Date', style: AppTextStyles.titleMediumBold),
          SizedBox(height: 8.h),
          TaskDateField(
            selectedDate: _selectedDate,
            onTap: _pickDate,
          ),
          SizedBox(height: 24.h),
          Text('Priority Level', style: AppTextStyles.titleMediumBold),
          SizedBox(height: 12.h),
          TaskPrioritySelector(
            selectedPriority: _selectedPriority,
            onPriorityChanged: (val) => setState(() => _selectedPriority = val),
          ),
          SizedBox(height: 40.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            onPressed: _submitForm,
            child: Text(
              'Create Task',
              style: AppTextStyles.titleMediumBold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
