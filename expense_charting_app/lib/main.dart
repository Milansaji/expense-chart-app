import 'package:expense_charting_app/model/home.dart';
import 'package:expense_charting_app/widgets/expenses_list/expense.dart';
import 'package:flutter/material.dart';

var kcolorscheme = ColorScheme.fromSeed(seedColor: Colors.white);
var kdarkcolorscheme = ColorScheme.fromSeed(seedColor: Colors.black);

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kdarkcolorscheme,
        dropdownMenuTheme: DropdownMenuThemeData(
            menuStyle: MenuStyle(
                backgroundColor:
                    MaterialStatePropertyAll(kdarkcolorscheme.primary)),
            textStyle: TextStyle(color: Colors.white)),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
        )),
        bottomSheetTheme: BottomSheetThemeData(
          modalBackgroundColor: kdarkcolorscheme.primary,
          backgroundColor: Colors.white,
        ),
        cardTheme: CardTheme().copyWith(
          color: kdarkcolorscheme.primary,
        ),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
            backgroundColor: kdarkcolorscheme.primary,
            foregroundColor: Colors.white)),
    theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorscheme,
        cardTheme: CardTheme().copyWith(color: kcolorscheme.secondaryContainer),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kcolorscheme.primaryContainer)),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(color: kcolorscheme.onSecondaryContainer))),
    themeMode: ThemeMode.system,
    home: Home(),
  ));
}
