import 'package:flutter/material.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color? labelIconColor;
  final Color? labelTextColor;
  final Color? mandatoryStarColor;
  final Color? helperTextColor;
  final Color? enabledBorderColor;
  final Color? disabledFillColor;
  final Color? disabledBorderColor;
  final Color? focusedFillColor;
  final Color? enabledFillColor;
  final Color? disabledIconColor;
  final Color? containerFormColor;
  final Color? borderFormColor;
  final Color? searchBarFillColor;

  const AppThemeExtension({
    required this.labelIconColor,
    required this.labelTextColor,
    required this.mandatoryStarColor,
    required this.helperTextColor,
    required this.enabledBorderColor,
    required this.disabledFillColor,
    required this.disabledBorderColor,
    required this.focusedFillColor,
    required this.enabledFillColor,
    required this.disabledIconColor,
    required this.containerFormColor,
    required this.borderFormColor,
    required this.searchBarFillColor,
  });

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? labelIconColor,
    Color? labelTextColor,
    Color? mandatoryStarColor,
    Color? helperTextColor,
    Color? enabledBorderColor,
    Color? disabledFillColor,
    Color? disabledBorderColor,
    Color? focusedFillColor,
    Color? enabledFillColor,
    Color? disabledIconColor,
    Color? containerFormColor,
    Color? borderFormColor,
    Color? searchBarFillColor,
  }) {
    return AppThemeExtension(
      labelIconColor: labelIconColor ?? this.labelIconColor,
      labelTextColor: labelTextColor ?? this.labelTextColor,
      mandatoryStarColor: mandatoryStarColor ?? this.mandatoryStarColor,
      helperTextColor: helperTextColor ?? this.helperTextColor,
      enabledBorderColor: enabledBorderColor ?? this.enabledBorderColor,
      disabledFillColor: disabledFillColor ?? this.disabledFillColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      focusedFillColor: focusedFillColor ?? this.focusedFillColor,
      enabledFillColor: enabledFillColor ?? this.enabledFillColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      containerFormColor: containerFormColor ?? this.containerFormColor,
      borderFormColor: borderFormColor ?? this.borderFormColor,
      searchBarFillColor: searchBarFillColor ?? this.searchBarFillColor,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      labelIconColor: Color.lerp(labelIconColor, other.labelIconColor, t),
      labelTextColor: Color.lerp(labelTextColor, other.labelTextColor, t),
      mandatoryStarColor: Color.lerp(
        mandatoryStarColor,
        other.mandatoryStarColor,
        t,
      ),
      helperTextColor: Color.lerp(helperTextColor, other.helperTextColor, t),
      enabledBorderColor: Color.lerp(
        enabledBorderColor,
        other.enabledBorderColor,
        t,
      ),
      disabledFillColor: Color.lerp(
        disabledFillColor,
        other.disabledFillColor,
        t,
      ),
      disabledBorderColor: Color.lerp(
        disabledBorderColor,
        other.disabledBorderColor,
        t,
      ),
      focusedFillColor: Color.lerp(focusedFillColor, other.focusedFillColor, t),
      enabledFillColor: Color.lerp(enabledFillColor, other.enabledFillColor, t),
      disabledIconColor: Color.lerp(
        disabledIconColor,
        other.disabledIconColor,
        t,
      ),
      containerFormColor: Color.lerp(
        containerFormColor,
        other.containerFormColor,
        t,
      ),
      borderFormColor: Color.lerp(borderFormColor, other.borderFormColor, t),
      searchBarFillColor: Color.lerp(
        searchBarFillColor,
        other.searchBarFillColor,
        t,
      ),
    );
  }
}
