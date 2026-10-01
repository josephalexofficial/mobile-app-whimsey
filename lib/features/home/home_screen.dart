import 'package:flutter/material.dart';

import '../../common/navigation/whimsey_app_controller.dart';
import '../../common/theme/whimsey_colors.dart';
import '../../common/theme/whimsey_theme.dart';
import '../../common/widgets/whimsey_ui.dart';

class _Pillar {
  const _Pillar({required this.title, required this.description, required this.icon});

  final String title;
  final String description;
  final IconData icon;
}

class _FeaturedService {
  const _FeaturedService({
    required this.title,
    required this.label,
    required this.description,
    required this.slug,
  });

  final String title;
  final String label;
  final String description;
  final String slug;
}

const List<_Pillar> _pillars = <_Pillar>[
  _Pillar(
    title: 'Technical Excellence',
    description:
        'Full-stack delivery with clear system architecture, strict code reviews, and comprehensive documentation your team can seamlessly run with.',
    icon: Icons.code,
  ),
  _Pillar(
    title: 'Quality Assurance',
    description:
        'Automated test suites, isolated staging environments, and rigorous release checklists tailored to match your specific operational and compliance needs.',
    icon: Icons.verified_user_outlined,
  ),
  _Pillar(
    title: 'Operable Systems',
    description:
        'Built-in observability, automated backups, and detailed runbooks so your software ecosystem remains rock-solid long after handover.',
    icon: Icons.monitor_heart_outlined,
  ),
  _Pillar(
    title: 'Continuous Innovation',
    description:
        'Forward-thinking infrastructure execution that anticipates technology trends, keeping your platforms modern, future-proof, and ahead of the curve.',
    icon: Icons.bolt_outlined,
  ),
  _Pillar(
    title: 'Embedded Partnership',
    description:
        'Product-minded engineers who integrate into your workflows, adapt to your daily tools, and prioritize clear asynchronous documentation by default.',
    icon: Icons.groups_outlined,
  ),
  _Pillar(
    title: 'Business Outcomes',
    description:
        'We align software milestones directly to revenue, cost efficiency, and risk mitigation, mapping engineering work directly to what leadership measures.',
    icon: Icons.trending_up,
  ),
];

const List<_FeaturedService> _featuredServices = <_FeaturedService>[
  _FeaturedService(
    title: 'Responsive Interfaces, Bulletproof Backends',
    label: 'Full-Stack Web Engineering',
    description:
        'We engineer full-stack web applications where pixel-perfect responsive interfaces meet secure, scalable server architectures. Every layer is built for performance, maintainability, and long-term growth.',
    slug: 'web-engineering',
  ),
  _FeaturedService(
    title: 'Native Speed, Cross-Platform Reach',
    label: 'Mobile Application Development',
    description:
        'From iOS to Android, we deliver mobile applications engineered for fluid performance and intuitive workflows. Native capabilities and cross-platform efficiency, without compromise.',
    slug: 'mobile-development',
  ),
  _FeaturedService(
    title: 'Internal Platforms That Scale With You',
    label: 'Custom Enterprise Software',
    description:
        'We build custom enterprise software that automates corporate workflows and eliminates operational friction. Tailored internal platforms your teams actually want to use every day.',
    slug: 'enterprise-software',
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WhimseyScope.of(context);
    final colors = whimseyColorsOf(context);

    return WhimseyPage(
      section: AppSection.home,
      children: <Widget>[
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 28, pageHorizontalPadding, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const EyebrowPill(label: 'Whimsey Technologies'),
              const SizedBox(height: 18),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 36,
                    height: 1.12,
                    fontWeight: FontWeight.w700,
                    fontFamily: whimseyFontFamily,
                    color: colors.text,
                  ),
                  children: const <InlineSpan>[
                    TextSpan(text: 'Light Up Your Vision With '),
                    TextSpan(
                      text: 'Precision-Crafted Tech',
                      style: TextStyle(color: WhimseyColors.accent),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'We engineer high-performance software, intuitive web ecosystems, and robust integrations—scoped clearly, built to scale, and delivered with absolute technical precision.',
                style: TextStyle(
                  color: colors.subhead,
                  fontSize: 17,
                  height: 1.55,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              const SizedBox(height: 16),
              const TagWrap(
                labels: <String>['Full-Stack Engineering', 'Cloud & DevOps', 'Enterprise Software'],
              ),
              const SizedBox(height: 22),
              PrimaryButton(
                label: 'Start Your Project',
                expand: true,
                onPressed: () => controller.openContact(),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                  label: 'Explore Services',
                  onPressed: () => controller.openSection(AppSection.services),
                ),
              ),
              const SizedBox(height: 28),
              BrowserFrame(
                title: 'System Architecture',
                child: const HeroArchitectureGraphic(),
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
              const SectionIntro(
                overline: 'Why Whimsey',
                title: 'Why Choose Whimsey Tech?',
                description:
                    'We strip away the agency overhead to deliver high-performing systems built with clean, intentional engineering.',
              ),
              const SizedBox(height: 22),
              for (var index = 0; index < _pillars.length; index += 1) ...<Widget>[
                FeatureCard(
                  indexLabel: (index + 1).toString().padLeft(2, '0'),
                  title: _pillars[index].title,
                  description: _pillars[index].description,
                  icon: _pillars[index].icon,
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 18),
              const SectionIntro(
                overline: 'Track Record',
                title: 'Proven Performance',
                description: 'Numbers that reflect disciplined delivery and long-term client partnerships.',
                centered: true,
              ),
              const SizedBox(height: 18),
              const MetricsRow(),
            ],
          ),
        ),
        ContentBand(
          child: Column(
            children: <Widget>[
              const SectionIntro(
                overline: 'Capabilities',
                title: 'What We Build',
                description:
                    'We design, build, and deploy high-performance software solutions engineered to scale with your business.',
                centered: true,
              ),
              const SizedBox(height: 22),
              for (final service in _featuredServices) ...<Widget>[
                _FeaturedServiceCard(service: service, onOpen: () => controller.openService(service.slug)),
                const SizedBox(height: 14),
              ],
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                  label: 'View All Services',
                  onPressed: () => controller.openSection(AppSection.services),
                ),
              ),
            ],
          ),
        ),
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 8, pageHorizontalPadding, 36),
          child: CtaBanner(
            overline: 'Start Building',
            title: 'Ready to start your next build?',
            description:
                'Tell us about your product, timeline, and constraints. We respond within one business day.',
            primaryLabel: 'Start Your Project',
            onPrimary: () => controller.openContact(),
            secondaryLabel: 'Explore Services',
            onSecondary: () => controller.openSection(AppSection.services),
          ),
        ),
        const SiteFooter(),
      ],
    );
  }
}

class _FeaturedServiceCard extends StatelessWidget {
  const _FeaturedServiceCard({required this.service, required this.onOpen});

  final _FeaturedService service;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: ServiceArtwork(slug: service.slug, height: 150),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      service.label.toUpperCase(),
                      style: const TextStyle(
                        color: WhimseyColors.accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        fontFamily: whimseyFontFamily,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.title,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: 20,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                        fontFamily: whimseyFontFamily,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.description,
                      style: TextStyle(color: colors.caption, height: 1.5, fontFamily: whimseyFontFamily),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Learn More  →',
                      style: TextStyle(
                        color: WhimseyColors.accent,
                        fontWeight: FontWeight.w600,
                        fontFamily: whimseyFontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
