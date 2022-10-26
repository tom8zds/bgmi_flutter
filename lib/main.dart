import 'dart:io';

import 'package:bgmi_flutter/internal/setting/bloc/setting_bloc.dart';
import 'package:bgmi_flutter/internal/setting/setting.dart';
import 'package:bgmi_flutter/presentations/frame_page.dart';
import 'package:bgmi_flutter/presentations/init_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  await Hive.initFlutter(appDocPath);
  SettingRepo(await Hive.openBox("setting"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeMode themeMode = ThemeMode.system;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.mandyRed;
    return BlocProvider(
      create: (context) => SettingBloc(),
      child: BlocConsumer<SettingBloc, SettingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is SettingInitial) {
            context.read<SettingBloc>().add(CheckServerEvent());
          }
          return MaterialApp(
            title: 'BGMI FLUTTER',
            // Use a predefined FlexThemeData.light() theme for the light theme.
            theme: FlexThemeData.light(
              scheme: FlexScheme.flutterDash,
              surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
              blendLevel: 20,
              appBarOpacity: 0.95,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 20,
                blendOnColors: false,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              // To use the playground font, add GoogleFonts package and uncomment
              // fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
            darkTheme: FlexThemeData.dark(
              scheme: FlexScheme.flutterDash,
              surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
              blendLevel: 15,
              appBarOpacity: 0.90,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 30,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              // To use the playground font, add GoogleFonts package and uncomment
              // fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
            // If you do not have a themeMode switch, uncomment this line
            // to let the device system mode control the theme mode:
            // themeMode: ThemeMode.system,
            // Use the above dark or light theme based on active themeMode.
            themeMode: themeMode,
            home: state is SettingIdle ? const FramePage() : InitPage(),
          );
        },
      ),
    );
  }
}
