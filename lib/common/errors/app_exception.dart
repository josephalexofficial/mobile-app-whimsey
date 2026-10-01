/// Operational failure raised inside the app and shown without a stack trace.
sealed class AppException implements Exception {
  const AppException({
    required this.message,
    required this.errorCode,
  });

  final String message;
  final String errorCode;

  @override
  String toString() => '$errorCode: $message';
}

/// A single field that failed contact-form validation.
class FieldIssue {
  const FieldIssue({
    required this.field,
    required this.issue,
  });

  final String field;
  final String issue;
}

/// Raised when user input fails the contact-form contract.
class ValidationException extends AppException {
  const ValidationException({required this.fieldIssues})
      : super(
          message: 'Input validation failed.',
          errorCode: 'VALIDATION_FAILED',
        );

  final List<FieldIssue> fieldIssues;
}

/// Raised when EmailJS defines are absent from the build.
class ConfigurationException extends AppException {
  const ConfigurationException()
      : super(
          message:
              'Email delivery is not configured. Add EmailJS keys to dart_defines.json and restart the app.',
          errorCode: 'CONFIGURATION_MISSING',
        );
}

/// Raised when EmailJS rejects the inquiry or the request times out.
class ExternalServiceException extends AppException {
  const ExternalServiceException({required super.message})
      : super(errorCode: 'THIRD_PARTY_FAILURE');
}
