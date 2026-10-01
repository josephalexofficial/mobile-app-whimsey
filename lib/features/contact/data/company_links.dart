/// Public company channels. These are not secrets.
class CompanyLinks {
  const CompanyLinks._();

  static const String inbox = 'whimseytech@gmail.com';
  static const String phoneDisplay = '0769591223';
  static const String phoneUri = 'tel:+254769591223';
  static const String emailUri = 'mailto:whimseytech@gmail.com';
  static const String hours = 'Monday – Friday: 8:00 AM – 5:00 PM EAT';

  static const List<SocialChannel> socialChannels = <SocialChannel>[
    SocialChannel(label: 'LinkedIn', url: 'https://www.linkedin.com/company/whimseytech/'),
    SocialChannel(label: 'X', url: 'https://x.com/whimseytech'),
    SocialChannel(label: 'Instagram', url: 'https://www.instagram.com/whimseytech/'),
    SocialChannel(label: 'YouTube', url: 'https://www.youtube.com/@whimseytech'),
    SocialChannel(label: 'Facebook', url: 'https://www.facebook.com/whimseytech'),
    SocialChannel(label: 'TikTok', url: 'https://www.tiktok.com/@whimseyofficialke'),
  ];
}

class SocialChannel {
  const SocialChannel({
    required this.label,
    required this.url,
  });

  final String label;
  final String url;
}

class PerformanceMetric {
  const PerformanceMetric({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;
}

const List<PerformanceMetric> performanceMetrics = <PerformanceMetric>[
  PerformanceMetric(value: '98%', label: 'Client Retention'),
  PerformanceMetric(value: '30+', label: 'Projects Delivered'),
  PerformanceMetric(value: '4.9/5', label: 'Client Rating'),
  PerformanceMetric(value: '2+', label: 'Years in Market'),
];
