import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../navigation/whimsey_app_controller.dart';
import '../theme/whimsey_colors.dart';
import '../theme/whimsey_theme.dart';
import '../../features/contact/data/company_links.dart';
import '../../features/services/data/service_catalog.dart';
import 'external_link.dart';

const double pageHorizontalPadding = 20;

class WhimseyPage extends StatefulWidget {
  const WhimseyPage({
    required this.section,
    required this.children,
    super.key,
  });

  final AppSection section;
  final List<Widget> children;

  @override
  State<WhimseyPage> createState() => _WhimseyPageState();
}

class _WhimseyPageState extends State<WhimseyPage> {
  final ScrollController _scrollController = ScrollController();
  int _seenScrollTick = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = WhimseyScope.of(context);
    final isDetailOpen = controller.serviceSlug != null || controller.projectSlug != null;
    if (controller.section != widget.section || isDetailOpen) {
      return;
    }
    if (controller.scrollToTopTick == _seenScrollTick) {
      return;
    }
    _seenScrollTick = controller.scrollToTopTick;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      children: widget.children,
    );
  }
}

class ContentBand extends StatelessWidget {
  const ContentBand({
    required this.child,
    this.background,
    this.padding = const EdgeInsets.fromLTRB(pageHorizontalPadding, 48, pageHorizontalPadding, 48),
    this.showTopBorder = false,
    super.key,
  });

  final Widget child;
  final Color? background;
  final EdgeInsets padding;
  final bool showTopBorder;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background ?? colors.canvas,
        border: showTopBorder ? Border(top: BorderSide(color: colors.border)) : null,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class EyebrowPill extends StatelessWidget {
  const EyebrowPill({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: WhimseyColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: WhimseyColors.accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.auto_awesome, size: 14, color: WhimseyColors.accent),
          const SizedBox(width: 8),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: WhimseyColors.accent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
              fontFamily: whimseyFontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

class Overline extends StatelessWidget {
  const Overline({required this.label, this.color, super.key});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        color: color ?? colors.caption.withValues(alpha: 0.9),
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.2,
        fontFamily: whimseyFontFamily,
      ),
    );
  }
}

class SectionIntro extends StatelessWidget {
  const SectionIntro({
    required this.overline,
    required this.title,
    required this.description,
    this.centered = false,
    super.key,
  });

  final String overline;
  final String title;
  final String description;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    final align = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Overline(label: overline),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: textAlign,
          style: TextStyle(
            color: colors.text,
            fontSize: 30,
            height: 1.15,
            fontWeight: FontWeight.w700,
            fontFamily: whimseyFontFamily,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          description,
          textAlign: textAlign,
          style: TextStyle(
            color: colors.caption,
            fontSize: 15,
            height: 1.55,
            fontFamily: whimseyFontFamily,
          ),
        ),
      ],
    );
  }
}

class TagWrap extends StatelessWidget {
  const TagWrap({required this.labels, this.centered = false, super.key});

  final List<String> labels;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return Wrap(
      alignment: centered ? WrapAlignment.center : WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: labels
          .map(
            (label) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: colors.border),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: colors.caption,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: whimseyFontFamily,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class TechWrap extends StatelessWidget {
  const TechWrap({required this.stack, super.key});

  final List<String> stack;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: stack
          .map(
            (item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: WhimseyColors.accent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: colors.text,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: whimseyFontFamily,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
    this.isBusy = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      onPressed: isBusy ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: WhimseyColors.accent,
        disabledBackgroundColor: WhimseyColors.accent.withValues(alpha: 0.45),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(
          fontFamily: whimseyFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (isBusy) ...<Widget>[
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            ),
            const SizedBox(width: 8),
          ] else if (icon != null) ...<Widget>[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          if (expand)
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            )
          else
            Text(label),
          if (!isBusy && icon == null) ...<Widget>[
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 18),
          ],
        ],
      ),
    );
    if (!expand) {
      return button;
    }
    return SizedBox(width: double.infinity, child: button);
  }
}

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.light = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    final foreground = light ? Colors.white : colors.text;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: foreground,
        side: BorderSide(color: light ? Colors.white.withValues(alpha: 0.4) : colors.border),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(
          fontFamily: whimseyFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(label),
        ],
      ),
    );
  }
}

class CtaBanner extends StatelessWidget {
  const CtaBanner({
    required this.overline,
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.onPrimary,
    required this.secondaryLabel,
    required this.onSecondary,
    super.key,
  });

  final String overline;
  final String title;
  final String description;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String secondaryLabel;
  final VoidCallback onSecondary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 36),
      decoration: BoxDecoration(
        color: WhimseyColors.accent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: <Widget>[
          Text(
            overline.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 12,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              fontFamily: whimseyFontFamily,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              height: 1.15,
              fontWeight: FontWeight.w700,
              fontFamily: whimseyFontFamily,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 15,
              height: 1.5,
              fontFamily: whimseyFontFamily,
            ),
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: onPrimary,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: WhimseyColors.accent,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(primaryLabel, style: const TextStyle(fontFamily: whimseyFontFamily, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: onSecondary,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(secondaryLabel, style: const TextStyle(fontFamily: whimseyFontFamily, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class MetricsRow extends StatelessWidget {
  const MetricsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.45,
      children: performanceMetrics
          .map(
            (metric) => DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      metric.value,
                      style: const TextStyle(
                        color: WhimseyColors.accent,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        fontFamily: whimseyFontFamily,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      metric.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.caption,
                        fontSize: 13,
                        fontFamily: whimseyFontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    required this.indexLabel,
    required this.title,
    required this.description,
    required this.icon,
    super.key,
  });

  final String indexLabel;
  final String title;
  final String description;
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: WhimseyColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: WhimseyColors.accent, size: 20),
                ),
                const Spacer(),
                Text(
                  indexLabel,
                  style: TextStyle(
                    color: WhimseyColors.accent.withValues(alpha: 0.35),
                    fontWeight: FontWeight.w700,
                    fontFamily: whimseyFontFamily,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: colors.text,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: whimseyFontFamily,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: colors.caption,
                height: 1.5,
                fontSize: 14,
                fontFamily: whimseyFontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    final controller = WhimseyScope.of(context);
    return ContentBand(
      background: colors.canvasMuted,
      showTopBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                'assets/images/whimsey_logo.png',
                height: 44,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Whimsey Technologies',
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: whimseyFontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Light Up Your Vision With Precision-Crafted Tech. We create innovative solutions that transform ideas into reality.',
            style: TextStyle(color: colors.caption, height: 1.5, fontFamily: whimseyFontFamily),
          ),
          const SizedBox(height: 18),
          const SocialChipRow(),
          const SizedBox(height: 28),
          const Overline(label: 'Services'),
          const SizedBox(height: 10),
          for (final service in serviceCatalog.take(3))
            FooterLink(
              label: service.title,
              onTap: () => controller.openService(service.slug),
            ),
          FooterLink(
            label: 'View All Services',
            emphasized: true,
            onTap: () => controller.openSection(AppSection.services),
          ),
          const SizedBox(height: 22),
          const Overline(label: 'Quick Links'),
          const SizedBox(height: 10),
          FooterLink(label: 'Home', onTap: () => controller.openSection(AppSection.home)),
          FooterLink(label: 'About', onTap: () => controller.openSection(AppSection.about)),
          FooterLink(label: 'Services', onTap: () => controller.openSection(AppSection.services)),
          FooterLink(label: 'Projects', onTap: () => controller.openSection(AppSection.projects)),
          FooterLink(label: 'Contact', onTap: () => controller.openSection(AppSection.contact)),
          const SizedBox(height: 22),
          const Overline(label: 'Get in Touch'),
          const SizedBox(height: 10),
          ContactTile(
            icon: Icons.mail_outline,
            label: 'Email',
            value: CompanyLinks.inbox,
            onTap: () => openExternalUri(context, CompanyLinks.emailUri),
          ),
          const SizedBox(height: 10),
          ContactTile(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: CompanyLinks.phoneDisplay,
            onTap: () => openExternalUri(context, CompanyLinks.phoneUri),
          ),
          const SizedBox(height: 22),
          Divider(color: colors.border),
          const SizedBox(height: 12),
          Text(
            '© 2026 Whimsey Tech. All rights reserved.',
            style: TextStyle(color: colors.caption, fontSize: 13, fontFamily: whimseyFontFamily),
          ),
          const SizedBox(height: 8),
          // The website footer links to "#" for these labels, so the app shows
          // them as text until real policy pages exist.
          Text(
            'Privacy Policy  ·  Terms of Service',
            style: TextStyle(color: colors.caption, fontSize: 13, fontFamily: whimseyFontFamily),
          ),
        ],
      ),
    );
  }
}

class FooterLink extends StatelessWidget {
  const FooterLink({
    required this.label,
    required this.onTap,
    this.emphasized = false,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          '→  $label',
          style: TextStyle(
            color: emphasized ? WhimseyColors.accent : colors.text.withValues(alpha: 0.82),
            fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
            fontFamily: whimseyFontFamily,
          ),
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: WhimseyColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: WhimseyColors.accent, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      label.toUpperCase(),
                      style: TextStyle(
                        color: colors.caption,
                        fontSize: 11,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w600,
                        fontFamily: whimseyFontFamily,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: TextStyle(
                        color: colors.text,
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

class SocialChipRow extends StatelessWidget {
  const SocialChipRow({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: CompanyLinks.socialChannels
          .map(
            (channel) => ActionChip(
              label: Text(channel.label),
              labelStyle: TextStyle(
                color: colors.text,
                fontFamily: whimseyFontFamily,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: colors.surface,
              side: BorderSide(color: colors.border),
              onPressed: () => openExternalUri(context, channel.url),
            ),
          )
          .toList(),
    );
  }
}

class BrowserFrame extends StatelessWidget {
  const BrowserFrame({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: colors.canvasMuted,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: <Widget>[
                  const _WindowDot(color: Color(0xFFFF5F57)),
                  const SizedBox(width: 6),
                  const _WindowDot(color: Color(0xFFFFBD2E)),
                  const SizedBox(width: 6),
                  const _WindowDot(color: Color(0xFF28CA41)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: colors.caption, fontSize: 12, fontFamily: whimseyFontFamily),
                    ),
                  ),
                ],
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  const _WindowDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}

class ServiceArtwork extends StatelessWidget {
  const ServiceArtwork({
    required this.slug,
    this.height = 168,
    super.key,
  });

  final String slug;
  final double height;

  @override
  Widget build(BuildContext context) {
    final markup = serviceIllustrationMarkup[slug] ?? serviceIllustrationMarkup['web-engineering'];
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0x1A0056D2), Color(0x050056D2)],
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(18),
      child: markup == null
          ? const SizedBox.shrink()
          : SvgPicture.string(markup, fit: BoxFit.contain),
    );
  }
}

class HeroArchitectureGraphic extends StatelessWidget {
  const HeroArchitectureGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: SvgPicture.string(heroArchitectureMarkup, fit: BoxFit.contain),
    );
  }
}

void showProjectLightbox(BuildContext context, String assetPath, String title) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return Dialog.fullscreen(
        backgroundColor: const Color(0xFF0B0F19),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Center(
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Image.asset(assetPath, fit: BoxFit.contain, semanticLabel: title),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  icon: const Icon(Icons.close, color: Colors.white),
                  tooltip: 'Close preview',
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

const String heroArchitectureMarkup = '''
<svg viewBox="0 0 400 400" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="400" height="400" rx="16" fill="#0056D2" fill-opacity="0.04"/>
  <line x1="100" y1="120" x2="200" y2="80" stroke="#0056D2" stroke-opacity="0.3" stroke-width="1.5"/>
  <line x1="200" y1="80" x2="300" y2="140" stroke="#0056D2" stroke-opacity="0.3" stroke-width="1.5"/>
  <line x1="100" y1="120" x2="150" y2="220" stroke="#0056D2" stroke-opacity="0.3" stroke-width="1.5"/>
  <line x1="300" y1="140" x2="250" y2="240" stroke="#0056D2" stroke-opacity="0.3" stroke-width="1.5"/>
  <line x1="150" y1="220" x2="250" y2="240" stroke="#0056D2" stroke-opacity="0.3" stroke-width="1.5"/>
  <circle cx="100" cy="120" r="24" fill="#0056D2" fill-opacity="0.12" stroke="#0056D2" stroke-width="2"/>
  <circle cx="200" cy="80" r="20" fill="#0056D2" fill-opacity="0.12" stroke="#0056D2" stroke-width="2"/>
  <circle cx="300" cy="140" r="22" fill="#0056D2" fill-opacity="0.12" stroke="#0056D2" stroke-width="2"/>
  <circle cx="150" cy="220" r="28" fill="#0056D2" fill-opacity="0.12" stroke="#0056D2" stroke-width="2"/>
  <circle cx="250" cy="240" r="26" fill="#0056D2" fill-opacity="0.12" stroke="#0056D2" stroke-width="2"/>
  <circle cx="200" cy="200" r="16" fill="#0056D2" fill-opacity="0.2" stroke="#0056D2" stroke-width="1.5"/>
  <circle cx="80" cy="300" r="14" fill="#0056D2" fill-opacity="0.12" stroke="#0056D2" stroke-width="1.5"/>
  <circle cx="320" cy="310" r="14" fill="#0056D2" fill-opacity="0.12" stroke="#0056D2" stroke-width="1.5"/>
</svg>
''';

const Map<String, String> serviceIllustrationMarkup = <String, String>{
  'web-engineering': '''
<svg viewBox="0 0 200 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="160" height="100" rx="8" stroke="#0056D2" stroke-width="2" fill="#FFFFFF" fill-opacity="0.55"/>
  <rect x="20" y="20" width="160" height="18" rx="8" fill="#0056D2" fill-opacity="0.15"/>
  <circle cx="32" cy="29" r="3" fill="#FF5F57"/><circle cx="42" cy="29" r="3" fill="#FFBD2E"/><circle cx="52" cy="29" r="3" fill="#28CA41"/>
  <rect x="35" y="50" width="50" height="6" rx="2" fill="#0056D2" fill-opacity="0.4"/>
  <rect x="35" y="62" width="80" height="4" rx="1" fill="#0056D2" fill-opacity="0.2"/>
  <rect x="120" y="48" width="45" height="55" rx="4" stroke="#0056D2" stroke-width="1.5" fill="#0056D2" fill-opacity="0.08"/>
</svg>
''',
  'mobile-development': '''
<svg viewBox="0 0 200 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="65" y="10" width="70" height="120" rx="12" stroke="#0056D2" stroke-width="2" fill="#FFFFFF" fill-opacity="0.55"/>
  <rect x="90" y="18" width="20" height="4" rx="2" fill="#0056D2" fill-opacity="0.3"/>
  <rect x="75" y="35" width="50" height="30" rx="4" fill="#0056D2" fill-opacity="0.15"/>
  <rect x="75" y="72" width="50" height="6" rx="2" fill="#0056D2" fill-opacity="0.35"/>
  <circle cx="100" cy="118" r="5" stroke="#0056D2" stroke-width="1.5"/>
</svg>
''',
  'enterprise-software': '''
<svg viewBox="0 0 200 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="70" width="40" height="50" fill="#0056D2" fill-opacity="0.2" stroke="#0056D2" stroke-width="1.5"/>
  <rect x="80" y="45" width="40" height="75" fill="#0056D2" fill-opacity="0.3" stroke="#0056D2" stroke-width="1.5"/>
  <rect x="130" y="60" width="40" height="60" fill="#0056D2" fill-opacity="0.15" stroke="#0056D2" stroke-width="1.5"/>
  <path d="M50 40 L100 20 L150 40" stroke="#0056D2" stroke-width="1.5" fill="none"/>
</svg>
''',
  'api-integration': '''
<svg viewBox="0 0 200 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <circle cx="100" cy="70" r="22" fill="#0056D2" fill-opacity="0.15" stroke="#0056D2" stroke-width="2"/>
  <circle cx="40" cy="40" r="14" fill="#0056D2" fill-opacity="0.1" stroke="#0056D2" stroke-width="1.5"/>
  <circle cx="160" cy="40" r="14" fill="#0056D2" fill-opacity="0.1" stroke="#0056D2" stroke-width="1.5"/>
  <circle cx="40" cy="100" r="14" fill="#0056D2" fill-opacity="0.1" stroke="#0056D2" stroke-width="1.5"/>
  <circle cx="160" cy="100" r="14" fill="#0056D2" fill-opacity="0.1" stroke="#0056D2" stroke-width="1.5"/>
  <line x1="54" y1="48" x2="80" y2="60" stroke="#0056D2" stroke-width="1.5" stroke-opacity="0.5"/>
  <line x1="146" y1="48" x2="120" y2="60" stroke="#0056D2" stroke-width="1.5" stroke-opacity="0.5"/>
  <line x1="54" y1="92" x2="80" y2="80" stroke="#0056D2" stroke-width="1.5" stroke-opacity="0.5"/>
  <line x1="146" y1="92" x2="120" y2="80" stroke="#0056D2" stroke-width="1.5" stroke-opacity="0.5"/>
</svg>
''',
  'cloud-devops': '''
<svg viewBox="0 0 200 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M50 80 Q50 55 75 55 Q85 35 110 45 Q140 40 145 65 Q165 65 165 85 Q165 100 150 100 L55 100 Q40 100 40 85 Q40 80 50 80Z" fill="#0056D2" fill-opacity="0.15" stroke="#0056D2" stroke-width="2"/>
  <circle cx="85" cy="75" r="4" fill="#0056D2" fill-opacity="0.5"/>
  <circle cx="100" cy="70" r="4" fill="#0056D2" fill-opacity="0.5"/>
  <circle cx="115" cy="75" r="4" fill="#0056D2" fill-opacity="0.5"/>
</svg>
''',
  'database-architecture': '''
<svg viewBox="0 0 200 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <ellipse cx="80" cy="40" rx="40" ry="14" fill="#0056D2" fill-opacity="0.2" stroke="#0056D2" stroke-width="1.5"/>
  <path d="M40 40 L40 95 Q40 109 80 109 Q120 109 120 95 L120 40" fill="#0056D2" fill-opacity="0.08" stroke="#0056D2" stroke-width="1.5"/>
  <ellipse cx="80" cy="95" rx="40" ry="14" fill="#0056D2" fill-opacity="0.15" stroke="#0056D2" stroke-width="1.5"/>
</svg>
''',
  'workflow-automation': '''
<svg viewBox="0 0 200 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="55" width="40" height="30" rx="6" fill="#0056D2" fill-opacity="0.15" stroke="#0056D2" stroke-width="1.5"/>
  <rect x="80" y="30" width="40" height="30" rx="6" fill="#0056D2" fill-opacity="0.25" stroke="#0056D2" stroke-width="1.5"/>
  <rect x="140" y="55" width="40" height="30" rx="6" fill="#0056D2" fill-opacity="0.15" stroke="#0056D2" stroke-width="1.5"/>
  <rect x="80" y="90" width="40" height="30" rx="6" fill="#0056D2" fill-opacity="0.2" stroke="#0056D2" stroke-width="1.5"/>
  <path d="M60 70 L80 45 M120 45 L140 70 M100 60 L100 90" stroke="#0056D2" stroke-width="1.5"/>
</svg>
''',
  'ui-ux-prototyping': '''
<svg viewBox="0 0 200 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="25" y="25" width="70" height="90" rx="4" stroke="#0056D2" stroke-width="1.5" stroke-dasharray="4 3"/>
  <rect x="105" y="25" width="70" height="90" rx="4" stroke="#0056D2" stroke-width="2" fill="#FFFFFF" fill-opacity="0.45"/>
  <rect x="115" y="50" width="50" height="25" rx="2" fill="#0056D2" fill-opacity="0.2"/>
  <rect x="115" y="38" width="30" height="4" rx="1" fill="#0056D2" fill-opacity="0.5"/>
</svg>
''',
  'ecommerce-engineering': '''
<svg viewBox="0 0 200 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="140" height="80" rx="8" stroke="#0056D2" stroke-width="2" fill="#FFFFFF" fill-opacity="0.45"/>
  <rect x="45" y="58" width="45" height="38" rx="4" fill="#0056D2" fill-opacity="0.12" stroke="#0056D2"/>
  <rect x="100" y="58" width="45" height="38" rx="4" fill="#0056D2" fill-opacity="0.12" stroke="#0056D2"/>
  <circle cx="150" cy="46" r="10" fill="#0056D2" fill-opacity="0.2" stroke="#0056D2"/>
</svg>
''',
};
