import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final IconData? icon;
  final double? width;
  final bool isDisabled;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.width,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 100,
      height: 30,
      child: FilledButton(
        style: (MediaQuery.of(context).size.width > 600)
            ? FilledButton.styleFrom(
                padding: EdgeInsets.all(8),
                backgroundColor: isDisabled
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
              )
            : FilledButton.styleFrom(
                padding: EdgeInsets.all(2),
                backgroundColor: isDisabled
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
              ),
        onPressed: isDisabled ? null : onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  icon,
                  size: (MediaQuery.of(context).size.width > 600) ? 24 : 64,
                  color: isDisabled
                      ? Colors.grey.shade300
                      : Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            if (text.isNotEmpty)
              Expanded(
                child: Text(
                  text,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
