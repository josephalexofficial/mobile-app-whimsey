/// Validated inquiry sent to the Whimsey inbox.
class ContactInquiry {
  const ContactInquiry({
    required this.name,
    required this.email,
    required this.message,
    required this.serviceInterest,
  });

  final String name;
  final String email;
  final String message;
  final String serviceInterest;
}

/// Compile-time EmailJS configuration supplied with `--dart-define-from-file`.
class EmailJsConfig {
  const EmailJsConfig({
    required this.serviceId,
    required this.templateId,
    required this.publicKey,
  });

  final String serviceId;
  final String templateId;
  final String publicKey;

  static const EmailJsConfig fromEnvironment = EmailJsConfig(
    serviceId: String.fromEnvironment('EMAILJS_SERVICE_ID'),
    templateId: String.fromEnvironment('EMAILJS_TEMPLATE_ID'),
    publicKey: String.fromEnvironment('EMAILJS_PUBLIC_KEY'),
  );

  bool get isConfigured {
    return serviceId.trim().isNotEmpty &&
        templateId.trim().isNotEmpty &&
        publicKey.trim().isNotEmpty;
  }
}
