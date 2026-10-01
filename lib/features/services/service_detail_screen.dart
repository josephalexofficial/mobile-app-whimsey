import 'package:flutter/material.dart';

import '../../common/navigation/whimsey_app_controller.dart';
import '../../common/theme/whimsey_colors.dart';
import '../../common/theme/whimsey_theme.dart';
import '../../common/widgets/whimsey_ui.dart';
import 'data/service_catalog.dart';

const List<IconData> _quadrantIcons = <IconData>[
  Icons.layers_outlined,
  Icons.memory_outlined,
  Icons.account_tree_outlined,
  Icons.shield_outlined,
];

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context) {
    final service = findServiceBySlug(slug);
    final controller = WhimseyScope.of(context);
    final colors = whimseyColorsOf(context);

    if (service == null) {
      return ContentBand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('This service is not in the catalog.'),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Back to Services',
              onPressed: () => controller.openSection(AppSection.services),
            ),
          ],
        ),
      );
    }

    final indexLabel = serviceIndexForSlug(service.slug).toString().padLeft(2, '0');
    final related = serviceCatalog.where((item) => item.slug != service.slug).take(4).toList();

    return WhimseyPage(
      section: AppSection.services,
      children: <Widget>[
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 20, pageHorizontalPadding, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton(
                onPressed: () => controller.openSection(AppSection.services),
                child: const Text('→  Back to All Services'),
              ),
              const SizedBox(height: 8),
              Text(
                indexLabel,
                style: const TextStyle(
                  color: WhimseyColors.accent,
                  fontWeight: FontWeight.w700,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                service.title.toUpperCase(),
                style: const TextStyle(
                  color: WhimseyColors.accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                service.heroTitle,
                style: TextStyle(
                  color: colors.text,
                  fontSize: 34,
                  height: 1.12,
                  fontWeight: FontWeight.w700,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                service.heroSubtitle,
                style: TextStyle(color: colors.subhead, fontSize: 16, height: 1.5, fontFamily: whimseyFontFamily),
              ),
              const SizedBox(height: 18),
              PrimaryButton(
                label: 'Start ${service.shortTitle} Project',
                expand: true,
                onPressed: () => controller.openContact(serviceSlug: service.slug),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                  label: 'View All Services',
                  onPressed: () => controller.openSection(AppSection.services),
                ),
              ),
              const SizedBox(height: 22),
              BrowserFrame(
                title: service.shortTitle,
                child: ServiceArtwork(slug: service.slug, height: 220),
              ),
            ],
          ),
        ),
        ContentBand(
          background: colors.canvasMuted,
          showTopBorder: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionIntro(
                overline: 'Engineering Pillars',
                title: 'Technical Expertise Framework',
                description:
                    'Four core engineering pillars that define how we architect, build, and deliver every ${service.shortTitle.toLowerCase()} engagement.',
              ),
              const SizedBox(height: 18),
              for (var index = 0; index < service.quadrants.length; index += 1) ...<Widget>[
                _QuadrantCard(
                  indexLabel: (index + 1).toString().padLeft(2, '0'),
                  quadrant: service.quadrants[index],
                  icon: _quadrantIcons[index],
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
        ContentBand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionIntro(
                overline: 'Tooling',
                title: '${service.shortTitle} Technology Stack',
                description: 'Modern, industry-standard tools used to build stable, performant software systems.',
              ),
              const SizedBox(height: 16),
              TechWrap(stack: service.techStack),
            ],
          ),
        ),
        ContentBand(
          background: colors.canvasMuted,
          showTopBorder: true,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionIntro(
                overline: 'Lifecycle',
                title: 'Development Process',
                description:
                    'A structured delivery pipeline from initial scoping through production governance.',
              ),
              SizedBox(height: 18),
              FeatureCard(
                indexLabel: '01',
                title: 'Strategy & Scoping',
                description: 'Technical requirements gathering and constraint mapping.',
                icon: Icons.search,
              ),
              SizedBox(height: 12),
              FeatureCard(
                indexLabel: '02',
                title: 'Architecture & UI/UX',
                description: 'Designing database schemas, system interfaces, and wireframes.',
                icon: Icons.design_services_outlined,
              ),
              SizedBox(height: 12),
              FeatureCard(
                indexLabel: '03',
                title: 'Agile Engineering',
                description: 'High-performance code implementation backed by automated testing pipelines.',
                icon: Icons.code,
              ),
              SizedBox(height: 12),
              FeatureCard(
                indexLabel: '04',
                title: 'Governance & Deployment',
                description: 'CI/CD launch tracks and observability setup.',
                icon: Icons.rocket_launch_outlined,
              ),
            ],
          ),
        ),
        ContentBand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SectionIntro(
                overline: 'Explore More',
                title: 'Other Capabilities',
                description: 'Additional engineering disciplines across the Whimsey Technologies portfolio.',
              ),
              const SizedBox(height: 16),
              for (final item in related) ...<Widget>[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    item.shortTitle,
                    style: TextStyle(
                      color: colors.text,
                      fontWeight: FontWeight.w700,
                      fontFamily: whimseyFontFamily,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_outward, color: WhimseyColors.accent),
                  onTap: () => controller.openService(item.slug),
                ),
                Divider(color: colors.border, height: 1),
              ],
            ],
          ),
        ),
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 8, pageHorizontalPadding, 36),
          child: CtaBanner(
            overline: "Let's Build",
            title: 'Ready to build your ${service.shortTitle.toLowerCase()} solution?',
            description:
                "Share your project constraints and timeline. We'll respond with a clear technical scoping framework within one business day.",
            primaryLabel: 'Discuss Your Project Idea',
            onPrimary: () => controller.openContact(serviceSlug: service.slug),
            secondaryLabel: 'See Our Work',
            onSecondary: () => controller.openSection(AppSection.projects),
          ),
        ),
        const SiteFooter(),
      ],
    );
  }
}

class _QuadrantCard extends StatelessWidget {
  const _QuadrantCard({
    required this.indexLabel,
    required this.quadrant,
    required this.icon,
  });

  final String indexLabel;
  final ServiceQuadrant quadrant;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: WhimseyColors.accent),
                const Spacer(),
                Text(
                  indexLabel,
                  style: TextStyle(
                    color: WhimseyColors.accent.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w700,
                    fontFamily: whimseyFontFamily,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              quadrant.title,
              style: TextStyle(
                color: colors.text,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: whimseyFontFamily,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              quadrant.subtitle,
              style: const TextStyle(
                color: WhimseyColors.accent,
                fontWeight: FontWeight.w600,
                fontFamily: whimseyFontFamily,
              ),
            ),
            const SizedBox(height: 12),
            for (final item in quadrant.items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '→  $item',
                  style: TextStyle(color: colors.caption, height: 1.4, fontFamily: whimseyFontFamily),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
