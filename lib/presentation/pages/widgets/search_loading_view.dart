import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/shared/widgets/app_shimmer.dart';

class SearchLoadingView extends StatelessWidget {
  const SearchLoadingView({required this.isDark, super.key});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) => Container(
        height: 72.h,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Row(
            children: [
              AppShimmer(width: 44.r, height: 44.r, radius: 22.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppShimmer(width: 140.w, height: 12.h, radius: 4.r),
                    SizedBox(height: 6.h),
                    AppShimmer(width: 80.w, height: 10.h, radius: 4.r),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
