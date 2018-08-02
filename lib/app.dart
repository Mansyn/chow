import 'package:flutter/material.dart';

import 'backdrop.dart';
import 'colors.dart';
import 'home.dart';
import 'login.dart';
import 'category_menu_page.dart';
import 'model/product.dart';
import 'supplemental/cut_corners_border.dart';

class ChowApp extends StatefulWidget {
  @override
  _ChowAppState createState() => _ChowAppState();
}

class _ChowAppState extends State<ChowApp> {
  Category _currentCategory = Category.all;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chow',
      home: Backdrop(
        currentCategory: _currentCategory,
        frontLayer: HomePage(category: _currentCategory),
        backLayer: CategoryMenuPage(
          currentCategory: _currentCategory,
          onCategoryTap: _onCategoryTap,
        ),
        frontTitle: Text('CHOW'),
        backTitle: Text('MENU'),
      ),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: _kChowTheme,
    );
  }

  /// Function to call when a [Category] is tapped.
  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name != '/login') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => LoginPage(),
    fullscreenDialog: true,
  );
}

final ThemeData _kChowTheme = _buildChowTheme();

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: kChowBrown900);
}

ThemeData _buildChowTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kChowBrown900,
    primaryColor: kChowGreen100,
    buttonColor: kChowGreen100,
    scaffoldBackgroundColor: kChowBackgroundWhite,
    cardColor: kChowBackgroundWhite,
    textSelectionColor: kChowGreen100,
    errorColor: kChowErrorRed,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: kChowBrown900),
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
    textTheme: _buildChowTextTheme(base.textTheme),
    primaryTextTheme: _buildChowTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildChowTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildChowTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kChowBrown900,
        bodyColor: kChowBrown900,
      );
}
