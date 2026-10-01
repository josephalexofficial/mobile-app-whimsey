import 'package:flutter/material.dart';

import '../../common/navigation/whimsey_app_controller.dart';
import '../../common/theme/whimsey_colors.dart';
import '../../common/theme/whimsey_theme.dart';
import '../../common/widgets/whimsey_ui.dart';
import 'data/project_catalog.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WhimseyScope.of(context);
    final colors = whimseyColorsOf(context);

    return WhimseyPage(
      section: AppSection.projects,
      children: <Widget>[
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 28, pageHorizontalPadding, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const EyebrowPill(label: 'Our Portfolio'),
              const SizedBox(height: 18),
              Text(
                'Shipped Production Platforms',
                style: TextStyle(
                  color: colors.text,
                  fontSize: 36,
                  height: 1.12,
                  fontWeight: FontWeight.w700,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Explore our portfolio of robust, high-performance applications built with clean code and delivered with absolute technical precision.',
                style: TextStyle(color: colors.subhead, fontSize: 17, height: 1.5, fontFamily: whimseyFontFamily),
              ),
              const SizedBox(height: 16),
              const TagWrap(
                labels: <String>['Production Platforms', 'Full-Stack Delivery', 'Client-Verified Results'],
              ),
            ],
          ),
        ),
        ContentBand(
          showTopBorder: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SectionIntro(
                overline: 'Case Studies',
                title: 'Production-Ready Platforms',
                description:
                    'Real projects engineered for performance, scale, and long-term maintainability. Open any card for the full case study.',
              ),
              const SizedBox(height: 18),
              for (var index = 0; index < projectCatalog.length; index += 1) ...<Widget>[
                _ProjectCard(
                  indexLabel: (index + 1).toString().padLeft(2, '0'),
                  project: projectCatalog[index],
                  onOpen: () => controller.openProject(projectCatalog[index].slug),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
        ContentBand(
          background: colors.canvasMuted,
          showTopBorder: true,
          child: const Column(
            children: <Widget>[
              SectionIntro(
                overline: 'Track Record',
                title: 'Proven Performance',
                description: 'Metrics that reflect our commitment to quality delivery and lasting client partnerships.',
                centered: true,
              ),
              SizedBox(height: 18),
              MetricsRow(),
            ],
          ),
        ),
        ContentBand(
          child: Column(
            children: <Widget>[
              const SectionIntro(
                overline: 'Client Voices',
                title: 'What Our Partners Say',
                description: 'Feedback from the leaders and organizations we engineer for.',
                centered: true,
              ),
              const SizedBox(height: 18),
              for (final testimonial in testimonialCatalog) ...<Widget>[
                _TestimonialCard(testimonial: testimonial),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
        const SiteFooter(),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.indexLabel,
    required this.project,
    required this.onOpen,
  });

  final String indexLabel;
  final ProjectCase project;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BrowserFrame(
            title: '$indexLabel  ${project.title}',
            child: GestureDetector(
              onTap: () => showProjectLightbox(context, project.imageAsset, project.title),
              child: Image.asset(
                project.imageAsset,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
                semanticLabel: project.title,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  project.title,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: whimseyFontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: TextStyle(color: colors.caption, height: 1.5, fontFamily: whimseyFontFamily),
                ),
                const SizedBox(height: 14),
                TechWrap(stack: project.techStack),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: onOpen,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: WhimseyColors.accent,
                    textStyle: const TextStyle(
                      fontFamily: whimseyFontFamily,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Text('View Case Study  →'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  const _TestimonialCard({required this.testimonial});

  final ClientTestimonial testimonial;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    final initial = testimonial.name.isEmpty ? '?' : testimonial.name[0];
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
            Icon(Icons.format_quote, color: WhimseyColors.accent.withValues(alpha: 0.4)),
            const SizedBox(height: 8),
            Text(
              '"${testimonial.quote}"',
              style: TextStyle(color: colors.text, height: 1.5, fontFamily: whimseyFontFamily),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: WhimseyColors.accent.withValues(alpha: 0.12),
                  child: Text(
                    initial,
                    style: const TextStyle(
                      color: WhimseyColors.accent,
                      fontWeight: FontWeight.w700,
                      fontFamily: whimseyFontFamily,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        testimonial.name,
                        style: TextStyle(
                          color: colors.text,
                          fontWeight: FontWeight.w700,
                          fontFamily: whimseyFontFamily,
                        ),
                      ),
                      Text(
                        testimonial.role,
                        style: TextStyle(color: colors.caption, fontFamily: whimseyFontFamily),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
