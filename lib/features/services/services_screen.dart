import 'package:flutter/material.dart';

import '../../common/navigation/whimsey_app_controller.dart';
import '../../common/theme/whimsey_colors.dart';
import '../../common/theme/whimsey_theme.dart';
import '../../common/widgets/whimsey_ui.dart';
import 'data/service_catalog.dart';

class _ProcessStep {
  const _ProcessStep({required this.number, required this.title, required this.description, required this.icon});

  final String number;
  final String title;
  final String description;
  final IconData icon;
}

const List<_ProcessStep> _processSteps = <_ProcessStep>[
  _ProcessStep(
    number: '01',
    title: 'Discovery',
    description: 'Rigorous requirement analysis, constraint mapping, and technical planning.',
    icon: Icons.search,
  ),
  _ProcessStep(
    number: '02',
    title: 'Architecture & Design',
    description: 'Mapping system internals, robust data schemas, and high-fidelity prototypes.',
    icon: Icons.design_services_outlined,
  ),
  _ProcessStep(
    number: '03',
    title: 'Engineering & Testing',
    description: 'Agile sprints, automated testing pipelines, and continuous code reviews.',
    icon: Icons.code,
  ),
  _ProcessStep(
    number: '04',
    title: 'Launch & Governance',
    description: 'Production deployment, observability setup, and structured transition runbooks.',
    icon: Icons.rocket_launch_outlined,
  ),
];

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WhimseyScope.of(context);
    final colors = whimseyColorsOf(context);

    return WhimseyPage(
      section: AppSection.services,
      children: <Widget>[
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 28, pageHorizontalPadding, 20),
          child: Column(
            children: <Widget>[
              const EyebrowPill(label: 'What We Deliver'),
              const SizedBox(height: 18),
              Text(
                'Technical Capabilities',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.text,
                  fontSize: 36,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'We deliver full-stack engineering, resilient infrastructure, and custom software systems designed with absolute technical precision.',
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.subhead, fontSize: 17, height: 1.5, fontFamily: whimseyFontFamily),
              ),
              const SizedBox(height: 16),
              const TagWrap(
                centered: true,
                labels: <String>['9 Core Services', 'End-to-End Delivery', 'Production-Ready Systems'],
              ),
            ],
          ),
        ),
        ContentBand(
          showTopBorder: true,
          child: Column(
            children: <Widget>[
              const SectionIntro(
                overline: 'Our Services',
                title: 'Nine Engineering Disciplines',
                description:
                    'From full-stack web platforms to cloud infrastructure. Every capability is engineered for scale, security, and long-term maintainability.',
                centered: true,
              ),
              const SizedBox(height: 20),
              for (var index = 0; index < serviceCatalog.length; index += 1) ...<Widget>[
                _ServiceCard(
                  indexLabel: (index + 1).toString().padLeft(2, '0'),
                  service: serviceCatalog[index],
                  onOpen: () => controller.openService(serviceCatalog[index].slug),
                ),
                const SizedBox(height: 14),
              ],
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
                overline: 'How We Work',
                title: 'Our Development Process',
                description:
                    'A disciplined four-phase lifecycle that keeps every engagement predictable, transparent, and production-ready.',
              ),
              const SizedBox(height: 18),
              for (final step in _processSteps) ...<Widget>[
                FeatureCard(
                  indexLabel: step.number,
                  title: step.title,
                  description: step.description,
                  icon: step.icon,
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 8, pageHorizontalPadding, 36),
          child: CtaBanner(
            overline: 'Get Started',
            title: 'Ready to expand your technical edge?',
            description:
                "Let's discuss your product requirements, constraints, and timeline. We respond with a clear scoping framework within one business day.",
            primaryLabel: 'Start Your Project',
            onPrimary: () => controller.openContact(),
            secondaryLabel: 'View Our Work',
            onSecondary: () => controller.openSection(AppSection.projects),
          ),
        ),
        const SiteFooter(),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.indexLabel,
    required this.service,
    required this.onOpen,
  });

  final String indexLabel;
  final ServiceOffering service;
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
                child: ServiceArtwork(slug: service.slug),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
