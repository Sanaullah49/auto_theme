import 'package:auto_theme/auto_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generates the opposite brightness from a light theme', () {
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
    );

    final generated = ThemeGenerator.generateOpposite(lightTheme);

    expect(generated.brightness, Brightness.dark);
    expect(generated.colorScheme.brightness, Brightness.dark);
    expect(
      generated.scaffoldBackgroundColor.computeLuminance(),
      lessThan(lightTheme.scaffoldBackgroundColor.computeLuminance()),
    );
  });

  test(
    'controller keeps original and generated themes on the correct side',
    () {
      final darkTheme = ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      );

      final controller = AutoThemeController(theme: darkTheme);

      expect(controller.originalTheme, same(darkTheme));
      expect(controller.darkTheme, same(darkTheme));
      expect(controller.lightTheme.brightness, Brightness.light);
    },
  );

  testWidgets('AutoThemeApp exposes controller and toggles mode', (
    tester,
  ) async {
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
    );

    await tester.pumpWidget(
      AutoThemeApp.materialApp(
        theme: lightTheme,
        initialThemeMode: ThemeMode.light,
        home: const _Harness(),
      ),
    );

    expect(find.text('light'), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.text('dark'), findsOneWidget);
  });
}

class _Harness extends StatelessWidget {
  const _Harness();

  @override
  Widget build(BuildContext context) {
    final controller = AutoThemeApp.of(context);

    return Scaffold(
      body: Center(child: Text(controller.themeMode.name)),
      floatingActionButton: const AutoThemeSwitch(),
    );
  }
}
