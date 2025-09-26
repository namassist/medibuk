import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibuk/domain/entities/app_theme_extension.dart';
import 'package:medibuk/domain/entities/color_schemes.g.dart';
import 'package:medibuk/presentation/pages/dashboard.dart';
import 'package:medibuk/presentation/providers/shared_providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);

    const lightAppColors = AppThemeExtension(
      labelIconColor: Color(0xFF1E88E5),
      labelTextColor: Color(0xff333333),
      mandatoryStarColor: Color(0xFFD32F2F),
      helperTextColor: Color(0xFFBDBDBD),
      enabledBorderColor: Color(0xFFCECECE),
      disabledFillColor: Color(0xFFEEEEEE),
      disabledBorderColor: Color(0xFFA6A6A6),
      focusedFillColor: Color(0xFFFFFFCC),
      enabledFillColor: Colors.white,
      disabledIconColor: Color(0xFF757575),
      containerFormColor: Color(0xfff9f9f9),
      borderFormColor: Color(0xFFE0E0E0),
      searchBarFillColor: Color(0xFFE0EFF1),
    );

    const darkAppColors = AppThemeExtension(
      labelIconColor: Color(0xFF64B5F6),
      labelTextColor: Color(0xFFE0E0E0),
      mandatoryStarColor: Color(0xFFE57373),
      helperTextColor: Color(0xFF757575),
      enabledBorderColor: Color(0xFF616161),
      disabledFillColor: Color(0xFF424242),
      disabledBorderColor: Color(0xFF757575),
      focusedFillColor: Color(0xFF3A3A28),
      enabledFillColor: Color(0xFF212121),
      disabledIconColor: Color(0xFFBDBDBD),
      containerFormColor: Color(0xFF2D2F30),
      borderFormColor: Color(0xFF3F484A),
      searchBarFillColor: Color(0xFF2C3A3C),
    );

    return MaterialApp(
      title: 'Medical Record System',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme(),
        extensions: const [lightAppColors],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        extensions: const [darkAppColors],
      ),
      themeMode: themeMode,
      home: const DashboardScreen(),
    );
  }
}
