import 'package:flutter/material.dart';
import 'package:medibuk/presentation/widgets/core/app_clock.dart';
import 'package:medibuk/presentation/widgets/core/app_topbar.dart';

class AppToolbar extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  const AppToolbar({super.key, required this.title, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTopBar(),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const AppLiveClock(),
              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: actions),
        ],
      ),
    );
  }
}
