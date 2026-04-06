import 'package:flutter/material.dart';

import 'auto_theme_app.dart';
import 'auto_theme_controller.dart';

/// A ready-made icon button that toggles the active theme mode.
class AutoThemeSwitch extends StatelessWidget {
  const AutoThemeSwitch({
    super.key,
    this.builder,
    this.animated = true,
    this.lightIcon = Icons.light_mode_rounded,
    this.darkIcon = Icons.dark_mode_rounded,
    this.systemIcon = Icons.brightness_auto_rounded,
    this.iconSize = 24,
    this.iconColor,
    this.includeSystem = false,
    this.tooltip,
  });

  final Widget Function(BuildContext context, AutoThemeController controller)?
  builder;
  final bool animated;
  final IconData lightIcon;
  final IconData darkIcon;
  final IconData systemIcon;
  final double iconSize;
  final Color? iconColor;
  final bool includeSystem;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final controller = AutoThemeApp.of(context);

    if (builder != null) {
      return builder!(context, controller);
    }

    return _DefaultThemeSwitch(
      controller: controller,
      animated: animated,
      lightIcon: lightIcon,
      darkIcon: darkIcon,
      systemIcon: systemIcon,
      iconSize: iconSize,
      iconColor: iconColor,
      includeSystem: includeSystem,
      tooltip: tooltip,
    );
  }
}

class _DefaultThemeSwitch extends StatelessWidget {
  const _DefaultThemeSwitch({
    required this.controller,
    required this.animated,
    required this.lightIcon,
    required this.darkIcon,
    required this.systemIcon,
    required this.iconSize,
    required this.includeSystem,
    this.iconColor,
    this.tooltip,
  });

  final AutoThemeController controller;
  final bool animated;
  final IconData lightIcon;
  final IconData darkIcon;
  final IconData systemIcon;
  final double iconSize;
  final Color? iconColor;
  final bool includeSystem;
  final String? tooltip;

  void _handleTap() {
    if (!includeSystem) {
      controller.toggle();
      return;
    }

    switch (controller.themeMode) {
      case ThemeMode.light:
        controller.setDark();
      case ThemeMode.dark:
        controller.setSystem();
      case ThemeMode.system:
        controller.setLight();
    }
  }

  IconData _currentIcon() {
    switch (controller.themeMode) {
      case ThemeMode.light:
        return lightIcon;
      case ThemeMode.dark:
        return darkIcon;
      case ThemeMode.system:
        return systemIcon;
    }
  }

  String _defaultTooltip() {
    switch (controller.themeMode) {
      case ThemeMode.light:
        return 'Switch to dark mode';
      case ThemeMode.dark:
        return includeSystem ? 'Switch to system mode' : 'Switch to light mode';
      case ThemeMode.system:
        return 'Switch to light mode';
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = _currentIcon();
    final color = iconColor ?? Theme.of(context).iconTheme.color;

    return IconButton(
      onPressed: _handleTap,
      tooltip: tooltip ?? _defaultTooltip(),
      icon: animated
          ? AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.85, end: 1).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Icon(
                icon,
                key: ValueKey<IconData>(icon),
                size: iconSize,
                color: color,
              ),
            )
          : Icon(icon, size: iconSize, color: color),
    );
  }
}

/// A switch-style theme control that can be dropped into settings screens.
class AutoThemeToggle extends StatelessWidget {
  const AutoThemeToggle({super.key, this.activeColor, this.inactiveColor});

  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final controller = AutoThemeApp.of(context);
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final isDark =
        controller.themeMode == ThemeMode.dark ||
        (controller.themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.light_mode_rounded,
          size: 18,
          color: isDark
              ? Colors.grey
              : activeColor ?? Theme.of(context).colorScheme.primary,
        ),
        Switch(
          value: isDark,
          onChanged: (value) {
            if (value) {
              controller.setDark();
            } else {
              controller.setLight();
            }
          },
          activeThumbColor: activeColor,
          inactiveThumbColor: inactiveColor,
        ),
        Icon(
          Icons.dark_mode_rounded,
          size: 18,
          color: isDark
              ? activeColor ?? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
      ],
    );
  }
}
