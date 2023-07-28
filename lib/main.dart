import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 앱 시작전에 초기화
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp, // 세로 고정
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  ); // Statusbar 색

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiktok clone',
      themeMode: ThemeMode.system, // 사용자의 설정에 따름
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
        brightness: Brightness.dark,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
        ),
        textTheme: Typography.whiteMountainView,
        tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.white,
        ),
        // textTheme: TextTheme(
        //   displayLarge: GoogleFonts.roboto(
        //       fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        //   displayMedium: GoogleFonts.roboto(
        //       fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        //   displaySmall:
        //       GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
        //   headlineMedium: GoogleFonts.roboto(
        //       fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        //   headlineSmall:
        //       GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
        //   titleLarge: GoogleFonts.roboto(
        //       fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        //   titleMedium: GoogleFonts.roboto(
        //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        //   titleSmall: GoogleFonts.roboto(
        //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        //   bodyLarge: GoogleFonts.roboto(
        //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        //   bodyMedium: GoogleFonts.roboto(
        //       fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        //   labelLarge: GoogleFonts.roboto(
        //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        //   bodySmall: GoogleFonts.roboto(
        //       fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        //   labelSmall: GoogleFonts.roboto(
        //       fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        // ),

        // textTheme: GoogleFonts.itimTextTheme(
        //   ThemeData(brightness: Brightness.dark).textTheme,
        // ),
      ),

      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          textTheme: Typography.blackMountainView,
          // textTheme: TextTheme(
          //   displayLarge: GoogleFonts.roboto(
          //       fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          //   displayMedium: GoogleFonts.roboto(
          //       fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          //   displaySmall:
          //       GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
          //   headlineMedium: GoogleFonts.roboto(
          //       fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          //   headlineSmall:
          //       GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
          //   titleLarge: GoogleFonts.roboto(
          //       fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          //   titleMedium: GoogleFonts.roboto(
          //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          //   titleSmall: GoogleFonts.roboto(
          //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          //   bodyLarge: GoogleFonts.roboto(
          //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          //   bodyMedium: GoogleFonts.roboto(
          //       fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          //   labelLarge: GoogleFonts.roboto(
          //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          //   bodySmall: GoogleFonts.roboto(
          //       fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          //   labelSmall: GoogleFonts.roboto(
          //       fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          // ),
          // textTheme: GoogleFonts.itimTextTheme(),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE9435A),
          brightness: Brightness.light,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
          tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
          )),
      home: const MainNavigationScreen(),
    );
  }
}

// class LayoutBuilderCodeLab extends StatelessWidget {
//   const LayoutBuilderCodeLab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return LayoutBuilder(
//       builder: (context, constraints) => Container(
//         width: size.width,
//         height: size.height,
//         color: Colors.teal,
//         child: Center(
//           child: Text(
//             "width: ${size.width}",
//             style: const TextStyle(color: Colors.white, fontSize: 98),
//           ),
//         ),
//       ),
//     );
//   }
// }
