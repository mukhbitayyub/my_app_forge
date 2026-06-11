import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/presentation/pages/widgets/search_loading_view.dart';
import 'package:my_app_forge/shared/widgets/app_empty_view.dart';
import 'package:my_app_forge/shared/widgets/app_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<String> _results = [];

  void _onSearchChanged(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        _results = [];
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future<void>.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _results = [
          'Clean Architecture Boilerplate',
          'GoRouter Multi-Shell Navigation',
          'BLoC State Management pattern',
          'ScreenUtil Responsive Toolkit',
          'GetIt Injectable Dependency graph',
        ].where((item) => item.toLowerCase().contains(value.toLowerCase())).toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Resources',
                style: isDark ? AppTextStyles.darkHeadlineMediumBold : AppTextStyles.headlineMediumBold,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: _searchController,
                label: 'Search',
                hint: 'Type query (e.g. clean, bloc...)',
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                onChanged: _onSearchChanged,
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: _buildContent(isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isDark) {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      return AppEmptyView(
        message: 'Start Searching',
        subMessage: 'Type any keyword above to search through the blueprint references.',
        icon: Icon(Icons.search_outlined, size: 48.r, color: AppColors.grey),
      );
    }

    if (_isLoading) {
      return SearchLoadingView(isDark: isDark);
    }

    if (_results.isEmpty) {
      return AppEmptyView(
        message: 'No Matches Found',
        subMessage: 'We could not find any elements matching "$query". Try another query.',
        icon: Icon(Icons.search_off_outlined, size: 48.r, color: AppColors.grey),
      );
    }

    return ListView.separated(
      itemCount: _results.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final item = _results[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
              child: const Icon(Icons.code, color: AppColors.primaryColor),
            ),
            title: Text(
              item,
              style: isDark ? AppTextStyles.darkBodyMediumBold : AppTextStyles.bodyMediumBold,
            ),
            subtitle: Text(
              'Blueprint Core Component',
              style: isDark ? AppTextStyles.darkLabelSmall : AppTextStyles.labelSmall,
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.primaryColor),
            onTap: () {},
          ),
        );
      },
    );
  }
}
