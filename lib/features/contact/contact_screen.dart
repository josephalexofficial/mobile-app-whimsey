import 'package:flutter/material.dart';

import '../../common/errors/app_exception.dart';
import '../../common/navigation/whimsey_app_controller.dart';
import '../../common/theme/whimsey_colors.dart';
import '../../common/theme/whimsey_theme.dart';
import '../../common/widgets/external_link.dart';
import '../../common/widgets/whimsey_ui.dart';
import 'data/company_links.dart';
import 'data/faq_catalog.dart';
import 'models/contact_inquiry.dart';
import 'services/contact_email_service.dart';

enum _FormPhase { idle, sending, success, error }

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  _FormPhase _phase = _FormPhase.idle;
  String? _interestSlug;
  String? _errorMessage;
  List<FieldIssue> _fieldIssues = const <FieldIssue>[];
  int _openFaqIndex = -1;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final interest = WhimseyScope.of(context).contactServiceInterest;
    if (interest == null || interest == _interestSlug) {
      return;
    }
    _interestSlug = interest;
    final label = interest.replaceAll('-', ' ');
    final prefix = "I'm interested in your $label service. ";
    if (!_messageController.text.startsWith(prefix)) {
      _messageController.text = prefix;
    }
  }

  Future<void> _submit() async {
    setState(() {
      _phase = _FormPhase.sending;
      _errorMessage = null;
      _fieldIssues = const <FieldIssue>[];
    });

    try {
      await sendContactEmail(
        rawName: _nameController.text,
        rawEmail: _emailController.text,
        rawMessage: _messageController.text,
        serviceInterest: _interestLabel ?? 'General Inquiry',
      );
      if (!mounted) {
        return;
      }
      setState(() => _phase = _FormPhase.success);
    } on ValidationException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _phase = _FormPhase.error;
        _fieldIssues = error.fieldIssues;
        _errorMessage = 'Check the highlighted fields and try again.';
      });
    } on AppException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _phase = _FormPhase.error;
        _errorMessage = error.message;
      });
    } on Exception {
      if (!mounted) {
        return;
      }
      setState(() {
        _phase = _FormPhase.error;
        _errorMessage = 'Something went wrong while sending your message. Please try again.';
      });
    }
  }

  String? get _interestLabel {
    final slug = _interestSlug;
    if (slug == null || slug.trim().isEmpty) {
      return null;
    }
    return slug.replaceAll('-', ' ');
  }

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    final isConfigured = EmailJsConfig.fromEnvironment.isConfigured;
    final isSending = _phase == _FormPhase.sending;

    return WhimseyPage(
      section: AppSection.contact,
      children: <Widget>[
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 28, pageHorizontalPadding, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const EyebrowPill(label: 'Get In Touch'),
              const SizedBox(height: 18),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 34,
                    height: 1.12,
                    fontWeight: FontWeight.w700,
                    fontFamily: whimseyFontFamily,
                  ),
                  children: const <InlineSpan>[
                    TextSpan(text: "Let's Build Something "),
                    TextSpan(
                      text: 'Engineered to Scale',
                      style: TextStyle(color: WhimseyColors.accent),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Tell us about your product, timeline, and system constraints. We review every submission manually and respond within one business day.',
                style: TextStyle(color: colors.subhead, fontSize: 16, height: 1.5, fontFamily: whimseyFontFamily),
              ),
              const SizedBox(height: 14),
              const TagWrap(
                labels: <String>['1 Business Day Response', 'Free Scoping Session', 'No Agency Overhead'],
              ),
            ],
          ),
        ),
        ContentBand(
          showTopBorder: true,
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 24, pageHorizontalPadding, 24),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: _phase == _FormPhase.success
                  ? const _SuccessPanel()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Project Scoping Form',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: whimseyFontFamily,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Share your requirements. We'll handle the rest.",
                          style: TextStyle(color: colors.caption, fontFamily: whimseyFontFamily),
                        ),
                        if (_interestLabel != null) ...<Widget>[
                          const SizedBox(height: 14),
                          Text(
                            'Inquiring about: $_interestLabel',
                            style: const TextStyle(
                              color: WhimseyColors.accent,
                              fontWeight: FontWeight.w600,
                              fontFamily: whimseyFontFamily,
                            ),
                          ),
                        ],
                        if (!isConfigured) ...<Widget>[
                          const SizedBox(height: 14),
                          const _Notice(
                            message:
                                'Email delivery is not configured. Add EmailJS keys to dart_defines.json and restart the app.',
                            isWarning: true,
                          ),
                        ],
                        if (_errorMessage != null) ...<Widget>[
                          const SizedBox(height: 14),
                          _Notice(message: _errorMessage!, isWarning: false),
                        ],
                        const SizedBox(height: 16),
                        _Field(
                          label: 'Name',
                          controller: _nameController,
                          hint: 'Alex Joseph',
                          enabled: !isSending,
                        ),
                        const SizedBox(height: 12),
                        _Field(
                          label: 'Email',
                          controller: _emailController,
                          hint: 'josephalexke@gmail.com',
                          enabled: !isSending,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        _Field(
                          label: 'Message',
                          controller: _messageController,
                          hint:
                              'Tell us about your product architecture, required system integrations, timeline parameters, or development constraints...',
                          enabled: !isSending,
                          maxLines: 6,
                        ),
                        if (_fieldIssues.isNotEmpty) ...<Widget>[
                          const SizedBox(height: 12),
                          for (final issue in _fieldIssues)
                            Text(
                              '${issue.field}: ${issue.issue}',
                              style: const TextStyle(color: WhimseyColors.danger, fontFamily: whimseyFontFamily),
                            ),
                        ],
                        const SizedBox(height: 16),
                        PrimaryButton(
                          label: isSending ? 'Sending Message...' : 'Send Message',
                          icon: Icons.send,
                          expand: true,
                          isBusy: isSending,
                          onPressed: isConfigured ? _submit : null,
                        ),
                      ],
                    ),
            ),
          ),
        ),
        ContentBand(
          padding: const EdgeInsets.fromLTRB(pageHorizontalPadding, 0, pageHorizontalPadding, 24),
          child: Column(
            children: <Widget>[
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
              const SizedBox(height: 10),
              const ContactTile(
                icon: Icons.schedule,
                label: 'Business Hours',
                value: CompanyLinks.hours,
              ),
              const SizedBox(height: 16),
              const Align(alignment: Alignment.centerLeft, child: SocialChipRow()),
            ],
          ),
        ),
        ContentBand(
          background: colors.canvasMuted,
          showTopBorder: true,
          child: Column(
            children: <Widget>[
              const SectionIntro(
                overline: 'FAQ',
                title: "Got questions? We've got answers.",
                description: 'Common questions from teams scoping their next build.',
                centered: true,
              ),
              const SizedBox(height: 16),
              for (var index = 0; index < faqCatalog.length; index += 1)
                _FaqTile(
                  item: faqCatalog[index],
                  isOpen: _openFaqIndex == index,
                  onTap: () {
                    setState(() {
                      _openFaqIndex = _openFaqIndex == index ? -1 : index;
                    });
                  },
                ),
            ],
          ),
        ),
        const SiteFooter(),
      ],
    );
  }
}

class _SuccessPanel extends StatelessWidget {
  const _SuccessPanel();

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return Column(
      children: <Widget>[
        const Icon(Icons.check_circle, color: WhimseyColors.accent, size: 48),
        const SizedBox(height: 12),
        const Text(
          'Message Received',
          style: TextStyle(
            color: WhimseyColors.accent,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: whimseyFontFamily,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Thank you for reaching out. Your project details have been transmitted to our engineering team. We will respond within one business day to schedule a technical scoping session.',
          textAlign: TextAlign.center,
          style: TextStyle(color: colors.caption, height: 1.5, fontFamily: whimseyFontFamily),
        ),
      ],
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.message, required this.isWarning});

  final String message;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final color = isWarning ? WhimseyColors.warning : WhimseyColors.danger;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(message, style: TextStyle(color: color, fontFamily: whimseyFontFamily)),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    required this.hint,
    required this.enabled,
    this.keyboardType,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final bool enabled;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: colors.text, fontWeight: FontWeight.w600, fontFamily: whimseyFontFamily),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(color: colors.text, fontFamily: whimseyFontFamily),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: colors.inputFill,
            hintStyle: TextStyle(color: colors.caption, fontFamily: whimseyFontFamily),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: WhimseyColors.accent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({
    required this.item,
    required this.isOpen,
    required this.onTap,
  });

  final FaqItem item;
  final bool isOpen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = whimseyColorsOf(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isOpen ? WhimseyColors.accent.withValues(alpha: 0.4) : colors.border,
          ),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                item.question,
                style: TextStyle(
                  color: colors.text,
                  fontWeight: FontWeight.w600,
                  fontFamily: whimseyFontFamily,
                ),
              ),
              trailing: Icon(
                isOpen ? Icons.expand_less : Icons.expand_more,
                color: WhimseyColors.accent,
              ),
              onTap: onTap,
            ),
            if (isOpen)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  item.answer,
                  style: TextStyle(color: colors.caption, height: 1.5, fontFamily: whimseyFontFamily),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
