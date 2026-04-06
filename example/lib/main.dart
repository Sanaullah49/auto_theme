import 'package:auto_theme/auto_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DemoApp());
}

ThemeMode _initialThemeMode() {
  const value = String.fromEnvironment(
    'AUTO_THEME_INITIAL_MODE',
    defaultValue: 'system',
  );

  switch (value.toLowerCase()) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sourceTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0F766E),
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 3,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );

    return AutoThemeApp.materialApp(
      theme: sourceTheme,
      title: 'Auto Theme Demo',
      initialThemeMode: _initialThemeMode(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool notifications = true;
  bool updates = false;
  double progress = 0.62;
  int index = 0;
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final autoTheme = AutoThemeApp.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Theme Demo'),
        actions: const [
          AutoThemeSwitch(includeSystem: true),
          SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current mode', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('ThemeMode: ${autoTheme.themeMode.name}'),
                  Text('Brightness: ${theme.brightness.name}'),
                  const SizedBox(height: 16),
                  const AutoThemeToggle(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Palette', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _ColorChip('Primary', theme.colorScheme.primary),
                      _ColorChip('Secondary', theme.colorScheme.secondary),
                      _ColorChip('Surface', theme.colorScheme.surface),
                      _ColorChip('Error', theme.colorScheme.error),
                      _ColorChip('Background', theme.scaffoldBackgroundColor),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Controls', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: autoTheme.toggle,
                        child: const Text('Toggle'),
                      ),
                      FilledButton(
                        onPressed: autoTheme.setLight,
                        child: const Text('Light'),
                      ),
                      OutlinedButton(
                        onPressed: autoTheme.setDark,
                        child: const Text('Dark'),
                      ),
                      TextButton(
                        onPressed: autoTheme.setSystem,
                        child: const Text('System'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      hintText: 'Type anything',
                      prefixIcon: Icon(Icons.edit_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Notifications'),
                    value: notifications,
                    onChanged: (value) {
                      setState(() => notifications = value);
                    },
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Weekly updates'),
                    value: updates,
                    onChanged: (value) {
                      setState(() => updates = value ?? false);
                    },
                  ),
                  Slider(
                    value: progress,
                    onChanged: (value) {
                      setState(() => progress = value);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Feedback', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () => _showDialog(context),
                        child: const Text('Dialog'),
                      ),
                      ElevatedButton(
                        onPressed: () => _showSnackBar(context),
                        child: const Text('SnackBar'),
                      ),
                      ElevatedButton(
                        onPressed: () => _showSheet(context),
                        child: const Text('Bottom sheet'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: autoTheme.toggle,
        child: const Icon(Icons.brightness_6_rounded),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() => index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Generated theme'),
          content: const Text(
            'This dialog is using the automatically generated opposite theme.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('SnackBar colors also follow the generated theme.'),
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
      ),
    );
  }

  Future<void> _showSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bottom sheet',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'The package regenerates surfaces, accents, and text tones for the opposite mode.',
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
