import 'package:flutter/material.dart';

//https://api.flutter.dev/flutter/material/ThemeData-class.html

var clickIconColor = Color.fromARGB(255, 141, 117, 8);

var textbuttonColor = const Color(0xffA17807);
var backgroundColor = const Color(0xffF0EFEB);
var textinBodyColor = const Color(0xff011636);
var graytextColor = const Color(0xff919191);
var myorangeColor = const Color(0xFFFD8C00);
var mybrowonColor = const Color(0xffA17807);

class LocalThemes {
  static final darkTheme = ThemeData(
      // background color
      //scaffoldBackgroundColor: Colors.grey.shade900,
      // accentColor: clickIconColor,
      // appbar color
      // primaryColor: Colors.black,
      colorScheme: ColorScheme.light(),
      iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
// Text Styles

      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
        ),
      ),

// text button theme
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: clickIconColor,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      )),
      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              backgroundColor: clickIconColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)), // background color
              textStyle: TextStyle(
                color: Colors.white,
                // fontStyle: FontStyle.italic,
              ))),
      // outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(15),
        textStyle: TextStyle(),
      )));
//
  ///
  /// Ligh Them
  ///
  static final lightTheme = ThemeData(
    textTheme: TextTheme(
      bodyMedium: TextStyle(),
      bodySmall: TextStyle(),
    ).apply(
      bodyColor: Colors.grey,
      displayColor: Colors.grey,
    ),
    primaryColor: clickIconColor,
    fontFamily: 'MyFont',
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 22, 43, 22),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Color(0xFFDAA520),
          fontFamily: 'sebhafont',
        )),
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 230, 159, 52)),
    primaryIconTheme:
        const IconThemeData(color: Color.fromARGB(255, 230, 159, 52)),

    //primarySwatch: Colors.indigo,
    //ElvatedButton theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: clickIconColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: TextStyle(
          color: Colors.grey,
          // fontStyle: FontStyle.italic,
        ),
      ),
    ),

    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     onPrimary: Colors.yellow,
    //     textStyle: TextStyle(
    //       fontSize: 20,
    //       fontFamily: 'Lato',
    //       fontWeight: FontWeight.bold,
    //       color: Colors.white,
    //     ),
    //   ),
    // ),

// Text in body

    // text button theme
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      foregroundColor: textbuttonColor,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.white,
      ),
    )),
    colorScheme:
        const ColorScheme.light(primary: Color.fromARGB(255, 230, 159, 52))
            .copyWith(background: backgroundColor),
  );
}
