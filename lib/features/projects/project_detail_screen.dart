import 'package:flutter/material.dart';

import '../../common/navigation/whimsey_app_controller.dart';
import '../../common/theme/whimsey_colors.dart';
import '../../common/theme/whimsey_theme.dart';
import '../../common/widgets/whimsey_ui.dart';
import 'data/project_catalog.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context) {
    final project = findProjectBySlug(slug);
    final controller = WhimseyScope.of(context);
    final colors = whimseyColorsOf(context);

    if (project == null) {
      return ContentBand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('This project is not in the catalog.'),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Back to Projects',
              onPressed: () => controller.openSection(AppSection.projects),
            ),
          ],
        ),
      );
    }

    final indexLabel = projectIndexForSlug(project.slug).toString().padLeft(2, '0');
    final related = projectCatalog.where((item) => item.slug != project.slug).take(3).toList();

    return WhimseyPage(
      section: AppSection.projects,
      children: <Widget>[
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 20, pageHorizontalPadding, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton(
                onPressed: () => controller.openSection(AppSection.projects),
                child: const Text('→  Back to All Projects'),
              ),
              const SizedBox(height: 8),
              Text(
                '$indexLabel   CASE STUDY',
                style: const TextStyle(
                  color: WhimseyColors.accent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                project.title,
                style: TextStyle(
                  color: colors.text,
                  fontSize: 32,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                project.detailDescription,
                style: TextStyle(color: colors.subhead, fontSize: 16, height: 1.5, fontFamily: whimseyFontFamily),
              ),
              const SizedBox(height: 16),
              const Overline(label: 'Tech Stack'),
              const SizedBox(height: 10),
              TechWrap(stack: project.techStack),
              const SizedBox(height: 18),
              PrimaryButton(
                label: 'Start Your Project',
                expand: true,
                onPressed: () => controller.openContact(),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                  label: 'Expand Preview',
                  icon: Icons.zoom_in,
                  onPressed: () => showProjectLightbox(context, project.imageAsset, project.title),
                ),
              ),
              const SizedBox(height: 20),
              BrowserFrame(
                title: 'Live Preview',
                child: GestureDetector(
                  onTap: () => showProjectLightbox(context, project.imageAsset, project.title),
                  child: Image.asset(
                    project.imageAsset,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    semanticLabel: project.title,
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
                overline: 'The Story',
                title: 'Challenge & Solution',
                description: 'How we identified the core problem and engineered a platform built to solve it at scale.',
                centered: true,
              ),
              const SizedBox(height: 18),
              FeatureCard(
                indexLabel: '01',
                title: 'Problem Statement',
                description: project.challenge,
                icon: Icons.error_outline,
              ),
              const SizedBox(height: 12),
              FeatureCard(
                indexLabel: '02',
                title: 'Engineering Approach',
                description: project.solution,
                icon: Icons.lightbulb_outline,
              ),
            ],
          ),
        ),
        ContentBand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SectionIntro(
                overline: 'Results',
                title: 'Key Outcomes',
                description: 'Measurable deliverables and platform capabilities delivered at launch and beyond.',
              ),
              const SizedBox(height: 16),
              for (final outcome in project.outcomes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.check_circle, color: WhimseyColors.accent, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          outcome,
                          style: TextStyle(color: colors.text, height: 1.4, fontFamily: whimseyFontFamily),
                        ),
                      ),
                    ],
                  ),
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
                overline: 'More Work',
                title: 'Other Case Studies',
                description: 'Additional production platforms from the Whimsey Technologies portfolio.',
              ),
              const SizedBox(height: 12),
              for (final item in related)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(item.imageAsset, width: 64, height: 48, fit: BoxFit.cover),
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      color: colors.text,
                      fontWeight: FontWeight.w700,
                      fontFamily: whimseyFontFamily,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_outward, color: WhimseyColors.accent),
                  onTap: () => controller.openProject(item.slug),
                ),
            ],
          ),
        ),
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 8, pageHorizontalPadding, 36),
          child: CtaBanner(
            overline: 'Build With Us',
            title: 'Want a platform like this for your business?',
            description:
                "Share your project requirements. We'll respond within one business day with a clear technical roadmap.",
            primaryLabel: 'Start Your Project',
            onPrimary: () => controller.openContact(),
            secondaryLabel: 'Our Services',
            onSecondary: () => controller.openSection(AppSection.services),
          ),
        ),
        const SiteFooter(),
      ],
    );
  }
}
