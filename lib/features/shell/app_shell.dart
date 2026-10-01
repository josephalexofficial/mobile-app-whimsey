import 'package:flutter/material.dart';

import '../../common/navigation/whimsey_app_controller.dart';
import '../../common/theme/whimsey_colors.dart';
import '../../common/theme/whimsey_theme.dart';
import '../about/about_screen.dart';
import '../contact/contact_screen.dart';
import '../home/home_screen.dart';
import '../projects/project_detail_screen.dart';
import '../projects/projects_screen.dart';
import '../services/service_detail_screen.dart';
import '../services/services_screen.dart';

const double pageGutter = 20;

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WhimseyScope.of(context);
    final colors = whimseyColorsOf(context);
    final serviceSlug = controller.serviceSlug;
    final projectSlug = controller.projectSlug;
    final detailIsOpen = serviceSlug != null || projectSlug != null;

    return PopScope(
      canPop: !detailIsOpen,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          controller.popDetail();
        }
      },
      child: Scaffold(
        backgroundColor: colors.canvas,
        appBar: AppBar(
          titleSpacing: pageGutter,
          title: GestureDetector(
            onTap: () => controller.openSection(AppSection.home),
            child: const Text(
              'Whimsey Technologies',
              style: TextStyle(
                color: WhimseyColors.accent,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                fontFamily: whimseyFontFamily,
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              tooltip: controller.themeMode == ThemeMode.dark
                  ? 'Switch to light mode'
                  : 'Switch to dark mode',
              onPressed: controller.toggleTheme,
              icon: Icon(
                controller.themeMode == ThemeMode.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
            ),
            const SizedBox(width: 4),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: colors.border),
          ),
        ),
        body: Stack(
          children: <Widget>[
            IndexedStack(
              index: controller.section.index,
              children: const <Widget>[
                HomeScreen(),
                AboutScreen(),
                ServicesScreen(),
                ProjectsScreen(),
                ContactScreen(),
              ],
            ),
            if (serviceSlug != null)
              Positioned.fill(
                child: ColoredBox(
                  color: colors.canvas,
                  child: ServiceDetailScreen(slug: serviceSlug),
                ),
              ),
            if (projectSlug != null)
              Positioned.fill(
                child: ColoredBox(
                  color: colors.canvas,
                  child: ProjectDetailScreen(slug: projectSlug),
                ),
              ),
          ],
        ),
        bottomNavigationBar: const WhimseyTabBar(),
      ),
    );
  }
}

class WhimseyTabBar extends StatelessWidget {
  const WhimseyTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WhimseyScope.of(context);
    final colors = whimseyColorsOf(context);
    const tabs = <_TabSpec>[
      _TabSpec(section: AppSection.home, label: 'Home', icon: Icons.home_outlined),
      _TabSpec(section: AppSection.about, label: 'About', icon: Icons.info_outline),
      _TabSpec(section: AppSection.services, label: 'Services', icon: Icons.work_outline),
      _TabSpec(section: AppSection.projects, label: 'Projects', icon: Icons.folder_open),
      _TabSpec(section: AppSection.contact, label: 'Contact', icon: Icons.mail_outline),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.header,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            children: tabs
                .map(
                  (tab) => Expanded(
                    child: _TabButton(
                      spec: tab,
                      isActive: _isTabActive(controller, tab.section),
                      onTap: () => controller.openSection(tab.section),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

bool _isTabActive(WhimseyAppController controller, AppSection section) {
  if (controller.serviceSlug != null) {
    return section == AppSection.services;
  }
  if (controller.projectSlug != null) {
    return section == AppSection.projects;
  }
  return controller.section == section;
}

class _TabSpec {
  const _TabSpec({
    required this.section,
    required this.label,
    required this.icon,
  });

  final AppSection section;
  final String label;
  final IconData icon;
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.spec,
    required this.isActive,
    required this.onTap,
  });

  final _TabSpec spec;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    final color = isActive ? WhimseyColors.accent : colors.caption.withValues(alpha: 0.7);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(spec.icon, size: 20, color: color),
          const SizedBox(height: 2),
          Text(
            spec.label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              fontFamily: whimseyFontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
