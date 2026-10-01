import 'package:flutter/material.dart';

import '../../common/navigation/whimsey_app_controller.dart';
import '../../common/theme/whimsey_colors.dart';
import '../../common/theme/whimsey_theme.dart';
import '../../common/widgets/whimsey_ui.dart';

class _Value {
  const _Value({required this.title, required this.description, required this.icon});

  final String title;
  final String description;
  final IconData icon;
}

const List<_Value> _values = <_Value>[
  _Value(
    title: 'Innovation',
    description:
        'Pushing technical boundaries and exploring modern tools to build forward-thinking solutions that keep your systems competitive.',
    icon: Icons.lightbulb_outline,
  ),
  _Value(
    title: 'Craftsmanship',
    description:
        'Approaching software development with a deep commitment to writing clean, maintainable code and building rock-solid architectures.',
    icon: Icons.diamond_outlined,
  ),
  _Value(
    title: 'Reliability',
    description:
        'Maintaining rigorous testing standards and careful planning to ensure your digital products perform flawlessly from day one.',
    icon: Icons.verified_outlined,
  ),
  _Value(
    title: 'Partnership',
    description:
        'Working transparently with your team as a product-minded extension of your business, aligning technical milestones to your actual growth goals.',
    icon: Icons.handshake_outlined,
  ),
];

const List<String> _principles = <String>[
  'Scalable, maintainable code from day one',
  'Resilient integrations across your toolchain',
  'Functional systems without agency overhead',
  'Precision scoping and disciplined execution',
  'Documentation your team can run with post-handover',
];

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WhimseyScope.of(context);
    final colors = whimseyColorsOf(context);

    return WhimseyPage(
      section: AppSection.about,
      children: <Widget>[
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 28, pageHorizontalPadding, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const EyebrowPill(label: 'About Us'),
              const SizedBox(height: 18),
              Text(
                'Whimsey Technologies',
                style: TextStyle(
                  color: colors.text,
                  fontSize: 36,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 22,
                    height: 1.35,
                    fontFamily: whimseyFontFamily,
                  ),
                  children: const <InlineSpan>[
                    TextSpan(text: 'Light Up Your Vision With '),
                    TextSpan(
                      text: 'Precision-Crafted Tech',
                      style: TextStyle(color: WhimseyColors.accent, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'We are a product-minded engineering team building high-performance software platforms for organizations that demand clarity, discipline, and results.',
                style: TextStyle(color: colors.caption, height: 1.55, fontFamily: whimseyFontFamily),
              ),
              const SizedBox(height: 22),
              BrowserFrame(
                title: 'Whimsey Technologies',
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/whimsey_logo.png',
                        width: 260,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'ENGINEERED TO SCALE',
                        style: TextStyle(
                          color: WhimseyColors.accent,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          fontFamily: whimseyFontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ContentBand(
          background: colors.canvasMuted,
          showTopBorder: true,
          child: Column(
            children: <Widget>[
              const SectionIntro(
                overline: 'Our Purpose',
                title: 'Mission & Vision',
                description:
                    'The principles that guide every platform we architect, every sprint we run, and every system we deliver.',
                centered: true,
              ),
              const SizedBox(height: 18),
              FeatureCard(
                indexLabel: '01',
                title: 'Build With Precision',
                description:
                    'To build high-performance, predictable software platforms that eliminate complexity and turn bold ideas into operational reality.',
                icon: Icons.track_changes,
              ),
              const SizedBox(height: 12),
              FeatureCard(
                indexLabel: '02',
                title: 'Set the Standard',
                description:
                    'To set the global standard for engineering discipline, proving that clean code and deliberate system architecture are the ultimate foundation for sustainable business growth.',
                icon: Icons.visibility_outlined,
              ),
            ],
          ),
        ),
        ContentBand(
          child: const Column(
            children: <Widget>[
              SectionIntro(
                overline: 'Track Record',
                title: 'Proven Performance',
                description: 'Numbers that reflect our commitment to quality delivery and long-term client partnerships.',
                centered: true,
              ),
              SizedBox(height: 18),
              MetricsRow(),
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
                overline: 'What We Stand For',
                title: 'Core Values',
                description: 'The engineering culture behind every Whimsey Technologies engagement.',
              ),
              const SizedBox(height: 18),
              for (var index = 0; index < _values.length; index += 1) ...<Widget>[
                FeatureCard(
                  indexLabel: (index + 1).toString().padLeft(2, '0'),
                  title: _values[index].title,
                  description: _values[index].description,
                  icon: _values[index].icon,
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
              const SectionIntro(
                overline: 'Our Approach',
                title: 'How We Build',
                description:
                    'Our team consists of senior, product-minded engineers who focus strictly on writing scalable code, building resilient integrations, and launching functional software systems without the traditional agency overhead.',
              ),
              const SizedBox(height: 18),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: colors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'ENGINEERING PRINCIPLES',
                        style: TextStyle(
                          color: WhimseyColors.accent,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          fontFamily: whimseyFontFamily,
                        ),
                      ),
                      const SizedBox(height: 14),
                      for (final principle in _principles)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Icon(Icons.check_circle, color: WhimseyColors.accent, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  principle,
                                  style: TextStyle(color: colors.text, height: 1.4, fontFamily: whimseyFontFamily),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 8, pageHorizontalPadding, 36),
          child: CtaBanner(
            overline: 'Work With Us',
            title: 'Ready to partner with a team that builds with discipline?',
            description: 'Tell us about your product vision. We respond within one business day.',
            primaryLabel: 'Start Your Project',
            onPrimary: () => controller.openContact(),
            secondaryLabel: 'View Our Services',
            onSecondary: () => controller.openSection(AppSection.services),
          ),
        ),
        const SiteFooter(),
      ],
    );
  }
}
