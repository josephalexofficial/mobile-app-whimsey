import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Primary sections of the Whimsey platform. Order matches the bottom tab bar.
enum AppSection {
  home,
  about,
  services,
  projects,
  contact,
}

const String _themeStorageKey = 'whimsey-theme';

/// Owns navigation and the saved light or dark theme.
class WhimseyAppController extends ChangeNotifier {
  AppSection section = AppSection.home;
  String? serviceSlug;
  String? projectSlug;
  String? contactServiceInterest;
  ThemeMode themeMode = ThemeMode.light;
  int scrollToTopTick = 0;
  bool isThemeReady = false;

  /// Restores the last explicit theme, or the device theme on a first launch.
  Future<void> restoreTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final storedTheme = preferences.getString(_themeStorageKey);
    final platformIsDark =
        WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;

    if (storedTheme == 'dark' || (storedTheme == null && platformIsDark)) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }

    isThemeReady = true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _themeStorageKey,
      themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  void openSection(AppSection nextSection) {
    final isAlreadyVisible =
        section == nextSection && serviceSlug == null && projectSlug == null;
    section = nextSection;
    serviceSlug = null;
    projectSlug = null;
    if (isAlreadyVisible) {
      scrollToTopTick += 1;
    }
    notifyListeners();
  }

  void openService(String slug) {
    section = AppSection.services;
    serviceSlug = slug;
    projectSlug = null;
    notifyListeners();
  }

  void openProject(String slug) {
    section = AppSection.projects;
    projectSlug = slug;
    serviceSlug = null;
    notifyListeners();
  }

  void openContact({String? serviceSlug}) {
    section = AppSection.contact;
    this.serviceSlug = null;
    projectSlug = null;
    contactServiceInterest = serviceSlug;
    notifyListeners();
  }

  /// Closes a service or project detail when the Android back button is pressed.
  bool popDetail() {
    if (serviceSlug == null && projectSlug == null) {
      return false;
    }

    serviceSlug = null;
    projectSlug = null;
    notifyListeners();
    return true;
  }
}

/// Exposes [WhimseyAppController] to the widget tree.
class WhimseyScope extends InheritedNotifier<WhimseyAppController> {
  const WhimseyScope({
    required WhimseyAppController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static WhimseyAppController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<WhimseyScope>();
    final controller = scope?.notifier;
    if (controller == null) {
      throw StateError('WhimseyScope is missing above this context.');
    }
    return controller;
  }
}
