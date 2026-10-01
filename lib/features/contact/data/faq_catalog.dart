class FaqItem {
  const FaqItem({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;
}

const List<FaqItem> faqCatalog = <FaqItem>[
  FaqItem(
    question: 'What software development methodologies do you use?',
    answer:
        'We run on a highly disciplined Agile framework. We break development into distinct two-week engineering sprints, backed by continuous integration pipelines and mandatory asynchronous code reviews to ensure maximum software stability.',
  ),
  FaqItem(
    question: 'How do you handle project handovers and documentation?',
    answer:
        "We don't leave you with a mystery codebase. Every solution we deploy comes packed with comprehensive system architecture charts, inline code documentation, automated test suites, and clean maintenance runbooks that your internal engineering team can immediately take over.",
  ),
  FaqItem(
    question: 'Can you integrate with our existing infrastructure and tools?',
    answer:
        'Yes. Our engineers are strictly product-minded. We embed seamlessly into your current daily workflows, adapting instantly to your preferred stack constraints, communication channels, and project tracking tools from day one.',
  ),
  FaqItem(
    question: 'What happens if our platform experiences a traffic spike or downtime?',
    answer:
        'We build architectures tailored to scale. By engineering with built-in observability tools, automated fallback paths, and secure cloud replication setups, your applications are fully optimized to handle unexpected traffic surges effortlessly.',
  ),
];
