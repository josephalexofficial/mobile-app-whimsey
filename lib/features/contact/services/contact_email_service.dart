import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../../common/errors/app_exception.dart';
import '../../../common/logging/app_logger.dart';
import '../models/contact_inquiry.dart';

const int emailRequestTimeoutInMs = 10000;
const int minimumNameLength = 2;
const int maximumNameLength = 120;
const int minimumMessageLength = 10;
const int maximumMessageLength = 5000;
const String _companyInbox = 'whimseytech@gmail.com';
const String _emailJsEndpoint = 'https://api.emailjs.com/api/v1.0/email/send';

final RegExp _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

/// Validates and delivers a project inquiry through EmailJS.
///
/// [rawName], [rawEmail], and [rawMessage] are untrusted form input.
/// [serviceInterest] is a catalog slug or "General Inquiry".
///
/// Returns normally when EmailJS accepts the message.
///
/// Throws [ValidationException] when a field fails its length or format rule.
/// Throws [ConfigurationException] when the EmailJS defines are empty.
/// Throws [ExternalServiceException] when the request times out or is rejected.
/// This method does not retry, because a contact submission is not idempotent.
Future<void> sendContactEmail({
  required String rawName,
  required String rawEmail,
  required String rawMessage,
  required String serviceInterest,
  EmailJsConfig config = EmailJsConfig.fromEnvironment,
}) async {
  final inquiry = _validateInquiry(
    rawName: rawName,
    rawEmail: rawEmail,
    rawMessage: rawMessage,
    serviceInterest: serviceInterest,
  );

  if (!config.isConfigured) {
    throw const ConfigurationException();
  }

  final client = HttpClient();
  client.connectionTimeout = const Duration(milliseconds: emailRequestTimeoutInMs);

  try {
    final request = await client
        .postUrl(Uri.parse(_emailJsEndpoint))
        .timeout(const Duration(milliseconds: emailRequestTimeoutInMs));
    request.headers.contentType = ContentType.json;
    request.write(
      jsonEncode(<String, Object>{
        'service_id': config.serviceId,
        'template_id': config.templateId,
        'user_id': config.publicKey,
        'template_params': <String, String>{
          'from_name': inquiry.name,
          'from_email': inquiry.email,
          'user_name': inquiry.name,
          'user_email': inquiry.email,
          'name': inquiry.name,
          'email': inquiry.email,
          'reply_to': inquiry.email,
          'message': inquiry.message,
          'service_interest': inquiry.serviceInterest,
          'to_email': _companyInbox,
        },
      }),
    );

    final response = await request
        .close()
        .timeout(const Duration(milliseconds: emailRequestTimeoutInMs));
    await response.drain<void>();

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ExternalServiceException(
        message:
            'The message could not be delivered. Please try again or email $_companyInbox directly.',
      );
    }
  } on AppException {
    rethrow;
  } on Exception catch (error) {
    AppLogger.error(
      'Contact inquiry delivery failed.',
      errorCode: 'THIRD_PARTY_FAILURE',
    );
    final isTimeout = error is TimeoutException;
    throw ExternalServiceException(
      message: isTimeout
          ? 'The request timed out. Please try again or email $_companyInbox directly.'
          : 'Something went wrong while sending your message. Please try again or email $_companyInbox directly.',
    );
  } finally {
    client.close(force: true);
  }
}

ContactInquiry _validateInquiry({
  required String rawName,
  required String rawEmail,
  required String rawMessage,
  required String serviceInterest,
}) {
  final name = rawName.trim();
  final email = rawEmail.trim();
  final message = rawMessage.trim();
  final interest = serviceInterest.trim().isEmpty ? 'General Inquiry' : serviceInterest.trim();
  final issues = <FieldIssue>[];

  if (name.length < minimumNameLength || name.length > maximumNameLength) {
    issues.add(
      const FieldIssue(
        field: 'name',
        issue: 'Name must be between 2 and 120 characters.',
      ),
    );
  }

  if (!_emailPattern.hasMatch(email) || email.length > maximumNameLength) {
    issues.add(
      const FieldIssue(
        field: 'email',
        issue: 'A valid email address is required.',
      ),
    );
  }

  if (message.length < minimumMessageLength || message.length > maximumMessageLength) {
    issues.add(
      const FieldIssue(
        field: 'message',
        issue: 'Message must be between 10 and 5000 characters.',
      ),
    );
  }

  if (issues.isNotEmpty) {
    throw ValidationException(fieldIssues: issues);
  }

  return ContactInquiry(
    name: name,
    email: email,
    message: message,
    serviceInterest: interest,
  );
}
