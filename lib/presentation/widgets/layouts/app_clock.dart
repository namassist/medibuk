import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLiveClock extends StatefulWidget {
  const AppLiveClock({super.key});

  @override
  State<AppLiveClock> createState() => AppLiveClockState();
}

class AppLiveClockState extends State<AppLiveClock> {
  late final Stream<DateTime> _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Stream<DateTime>.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _ticker,
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();
        final dateStr = DateFormat('EEEE, d MMM yyyy').format(now);
        final timeStr = DateFormat('HH:mm:ss').format(now);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(dateStr, style: Theme.of(context).textTheme.titleMedium),
            Text(
              timeStr,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: Colors.grey[700]),
            ),
          ],
        );
      },
    );
  }
}
