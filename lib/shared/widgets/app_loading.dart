import 'package:flutter/material.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({
    this.size = 24.0,
    this.color,
    super.key,
  });

  final double size;
  final Color? color;

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(
              widget.color ?? AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
