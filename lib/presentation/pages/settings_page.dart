import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_forge/core/network/api_endpoints.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _pushNotifications = true;
  bool _developerLogs = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Preferences', isDark),
            SizedBox(height: 12.h),
            _buildPreferenceCard(isDark),
            SizedBox(height: 24.h),
            _buildSectionHeader('System Environment', isDark),
            SizedBox(height: 12.h),
            _buildEnvironmentCard(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Text(
      title,
      style: isDark ? AppTextStyles.darkTitleMediumBold : AppTextStyles.titleMediumBold,
    );
  }

  Widget _buildPreferenceCard(bool isDark) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              activeTrackColor: AppColors.primaryColor,
              title: Text(
                'Push Notifications',
                style: isDark ? AppTextStyles.darkBodyMediumBold : AppTextStyles.bodyMediumBold,
              ),
              subtitle: Text(
                'Receive instant status updates',
                style: isDark ? AppTextStyles.darkLabelSmall : AppTextStyles.labelSmall,
              ),
              value: _pushNotifications,
              onChanged: (val) => setState(() => _pushNotifications = val),
            ),
            const Divider(height: 1),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              activeTrackColor: AppColors.primaryColor,
              title: Text(
                'Developer Logs',
                style: isDark ? AppTextStyles.darkBodyMediumBold : AppTextStyles.bodyMediumBold,
              ),
              subtitle: Text(
                'Track raw HTTP request logs',
                style: isDark ? AppTextStyles.darkLabelSmall : AppTextStyles.labelSmall,
              ),
              value: _developerLogs,
              onChanged: (val) => setState(() => _developerLogs = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentCard(bool isDark) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            _buildConfigRow('API Base URL', ApiEndpoints.baseUrl, isDark),
            const Divider(),
            _buildConfigRow('HTTP Timeout', '${ApiEndpoints.timeout} ms', isDark),
            const Divider(),
            _buildConfigRow('Platform OS', Theme.of(context).platform.name.toUpperCase(), isDark),
            const Divider(),
            _buildConfigRow('Blueprint Version', '1.0.0 (Production)', isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigRow(String key, String value, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Text(
            key,
            style: isDark ? AppTextStyles.darkBodyMediumBold : AppTextStyles.bodyMediumBold,
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: isDark ? AppTextStyles.darkLabelSmall : AppTextStyles.labelSmall,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
