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

bool _initialHardcodedFallbackEnabled() {
  const value = String.fromEnvironment(
    'AUTO_THEME_ENABLE_HARDCODED_FALLBACK',
    defaultValue: 'false',
  );
  return value.toLowerCase() == 'true';
}

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  late bool _enableHardcodedFallback;

  @override
  void initState() {
    super.initState();
    _enableHardcodedFallback = _initialHardcodedFallbackEnabled();
  }

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
      hardcodedColorStrategy: _enableHardcodedFallback
          ? HardcodedColorStrategy.colorFilter
          : HardcodedColorStrategy.none,
      hardcodedColorFilterStrength: 1.0,
      debugShowCheckedModeBanner: false,
      home: HomePage(
        hardcodedFallbackEnabled: _enableHardcodedFallback,
        onHardcodedFallbackChanged: (enabled) {
          setState(() => _enableHardcodedFallback = enabled);
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.hardcodedFallbackEnabled,
    required this.onHardcodedFallbackChanged,
  });

  final bool hardcodedFallbackEnabled;
  final ValueChanged<bool> onHardcodedFallbackChanged;

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
                  Text(
                    'Hardcoded color scenario',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'The preview below uses fixed colors and does not read Theme.of(context). '
                    'Turn this fallback on, then switch light/dark mode to see the conversion.',
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Enable hardcoded-color fallback'),
                    subtitle: Text(
                      widget.hardcodedFallbackEnabled
                          ? 'Enabled (best-effort app-wide filter is active)'
                          : 'Disabled (hardcoded colors stay unchanged)',
                    ),
                    value: widget.hardcodedFallbackEnabled,
                    onChanged: widget.onHardcodedFallbackChanged,
                  ),
                  const SizedBox(height: 8),
                  const _HardcodedColorPreview(),
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

class _HardcodedColorPreview extends StatelessWidget {
  const _HardcodedColorPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: _FixedColorTile(
                title: 'Hardcoded Light Tile',
                subtitle: 'Fixed background and text',
                background: Color(0xFFF8FAFC),
                iconColor: Color(0xFFF59E0B),
                textColor: Color(0xFF0F172A),
                borderColor: Color(0xFFE2E8F0),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _FixedColorTile(
                title: 'Hardcoded Dark Tile',
                subtitle: 'Fixed background and text',
                background: Color(0xFF0F172A),
                iconColor: Color(0xFF38BDF8),
                textColor: Color(0xFFF8FAFC),
                borderColor: Color(0xFF334155),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFC7D2FE)),
          ),
          child: const Text(
            'This banner color is hardcoded too.',
            style: TextStyle(
              color: Color(0xFF312E81),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _FixedColorTile extends StatelessWidget {
  const _FixedColorTile({
    required this.title,
    required this.subtitle,
    required this.background,
    required this.iconColor,
    required this.textColor,
    required this.borderColor,
  });

  final String title;
  final String subtitle;
  final Color background;
  final Color iconColor;
  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(Icons.palette_rounded, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor.withAlpha(204),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
