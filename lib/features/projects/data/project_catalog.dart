class ProjectCase {
  const ProjectCase({
    required this.slug,
    required this.title,
    required this.imageAsset,
    required this.description,
    required this.techStack,
    required this.detailDescription,
    required this.challenge,
    required this.solution,
    required this.outcomes,
  });

  final String slug;
  final String title;
  final String imageAsset;
  final String description;
  final List<String> techStack;
  final String detailDescription;
  final String challenge;
  final String solution;
  final List<String> outcomes;
}

class ClientTestimonial {
  const ClientTestimonial({
    required this.name,
    required this.role,
    required this.quote,
    required this.projectSlug,
  });

  final String name;
  final String role;
  final String quote;
  final String projectSlug;
}

ProjectCase? findProjectBySlug(String slug) {
  for (final project in projectCatalog) {
    if (project.slug == slug) {
      return project;
    }
  }
  return null;
}

int projectIndexForSlug(String slug) {
  for (var index = 0; index < projectCatalog.length; index += 1) {
    if (projectCatalog[index].slug == slug) {
      return index + 1;
    }
  }
  return 0;
}

const List<ProjectCase> projectCatalog = <ProjectCase>[
  ProjectCase(
    slug: 'hightech-international',
    title: 'HighTech International Website',
    imageAsset: 'assets/images/hightech.jpg',
    description:
        'A full-stack institutional platform featuring an interactive multi-step student enrollment system, a secure admin applicant tracker, and a dynamic departmental course management directory.',
    techStack: <String>['React', 'Node.js', 'Tailwind CSS', 'PostgreSQL', 'JWT'],
    detailDescription:
        'HighTech International needed a comprehensive digital platform to modernize their student enrollment pipeline and administrative operations.',
    challenge:
        'The institution relied on fragmented manual processes for student applications, course management, and departmental coordination — creating bottlenecks and data inconsistencies.',
    solution:
        'We engineered a full-stack platform with a multi-step enrollment wizard, secure JWT-authenticated admin dashboard, and dynamic course directory with real-time applicant tracking.',
    outcomes: <String>[
      'Streamlined multi-step enrollment portal',
      'Secure admin applicant tracking system',
      'Dynamic departmental course management',
      'Reduced manual data entry by 80%',
    ],
  ),
  ProjectCase(
    slug: 'skilllink',
    title: 'SkillLink',
    imageAsset: 'assets/images/skilllink.jpg',
    description:
        'A full-stack data-driven marketplace that formalizes the informal labor economy through decoupled React/Laravel architecture, transaction-locked reputation ledgers, and dynamic PDF work transcript engines.',
    techStack: <String>['React', 'Laravel', 'Tailwind CSS', 'MySQL', 'PHP'],
    detailDescription:
        'SkillLink bridges the gap between informal workers and formal employment opportunities through a reputation-driven marketplace platform.',
    challenge:
        'Informal labor markets lack verifiable work history and trust mechanisms, making it difficult for skilled workers to access formal opportunities.',
    solution:
        'We built a decoupled React/Laravel marketplace with transaction-locked reputation ledgers, dynamic PDF work transcripts, and verified skill matching algorithms.',
    outcomes: <String>[
      'Formalized informal labor marketplace',
      'Transaction-locked reputation system',
      'Dynamic PDF work transcript generation',
      'Verified skill-to-opportunity matching',
    ],
  ),
  ProjectCase(
    slug: 'gladys-erude-org',
    title: 'The Gladys Erude Organization Platform',
    imageAsset: 'assets/images/gladys_erude.jpg',
    description:
        'A high-performance, cross-border web platform featuring optimized multi-category media filters, an integrated e-commerce shop, and multi-currency fundraising architectures (USD/KES) to eliminate donor friction.',
    techStack: <String>['React', 'Next.js', 'Tailwind CSS', 'Node.js', 'Stripe'],
    detailDescription:
        'The Gladys Erude Organization required a cross-border platform to showcase their mission, sell merchandise, and accept international donations seamlessly.',
    challenge:
        'Managing multi-currency donations, media-rich content, and e-commerce operations across borders created significant donor friction and operational complexity.',
    solution:
        'We delivered a Next.js platform with optimized media filters, integrated Stripe-powered e-commerce, and dual-currency (USD/KES) fundraising architecture.',
    outcomes: <String>[
      'Multi-currency donation processing',
      'Integrated e-commerce storefront',
      'Optimized media gallery with filters',
      'Cross-border payment support',
    ],
  ),
  ProjectCase(
    slug: 'inner-harbour-resort',
    title: 'Inner Harbour Resort Website',
    imageAsset: 'assets/images/inner_harbor.jpg',
    description:
        'A premium hospitality platform featuring an interactive room catalog with client-side pricing filters, a digital restaurant ordering hub, and dedicated geolocated lakeside package modules.',
    techStack: <String>['React', 'Next.js', 'Tailwind CSS', 'Node.js', 'Framer Motion'],
    detailDescription:
        'Inner Harbour Resort needed a premium digital presence to showcase their lakeside accommodations and streamline guest booking experiences.',
    challenge:
        'Guests struggled to browse room options, compare packages, and place restaurant orders through outdated, non-responsive digital channels.',
    solution:
        'We crafted a premium hospitality platform with interactive room catalogs, client-side pricing filters, digital restaurant ordering, and geolocated package modules.',
    outcomes: <String>[
      'Interactive room catalog with live filters',
      'Digital restaurant ordering hub',
      'Geolocated lakeside package modules',
      'Improved guest booking conversion',
    ],
  ),
  ProjectCase(
    slug: 'dynamic-pictures-media',
    title: 'Dynamic Pictures Media Platform',
    imageAsset: 'assets/images/dynamic.jpg',
    description:
        'A high-performance multimedia portfolio platform featuring an instant client-side media filtering gallery, asset lazy-loading optimization for slow networks, and dynamic client intake funnels.',
    techStack: <String>['React', 'Tailwind CSS', 'Vite', 'Node.js', 'Framer Motion'],
    detailDescription:
        'Dynamic Pictures Media required a portfolio platform capable of showcasing heavy media assets without compromising load performance.',
    challenge:
        'Large media files caused severe network lag, and the existing client onboarding process lacked structure and automation.',
    solution:
        'We built a Vite-powered portfolio with instant client-side media filtering, aggressive lazy-loading optimization, and dynamic client intake funnels.',
    outcomes: <String>[
      'Eliminated network lag on media-heavy pages',
      'Instant client-side gallery filtering',
      'Streamlined client onboarding funnel',
      'Optimized asset delivery pipeline',
    ],
  ),
  ProjectCase(
    slug: 'alex-joseph-portfolio',
    title: 'Alex Joseph Portfolio',
    imageAsset: 'assets/images/alex_joseph.jpg',
    description:
        'An ultra-minimalist developer brand hub featuring fluid micro-interactions, dark-mode styling blocks, and an asynchronous technical playbook infrastructure built for clear architectural storytelling.',
    techStack: <String>['Vite', 'React', 'Tailwind CSS'],
    detailDescription:
        'A personal developer portfolio engineered as a minimalist brand hub with architectural storytelling at its core.',
    challenge:
        'The developer needed a portfolio that communicated technical depth and design sensibility without generic template aesthetics.',
    solution:
        'We created an ultra-minimalist hub with fluid micro-interactions, dual-theme styling, and an asynchronous technical playbook for architectural storytelling.',
    outcomes: <String>[
      'Distinctive minimalist brand identity',
      'Fluid micro-interaction system',
      'Dark-mode native design blocks',
      'Asynchronous technical playbook',
    ],
  ),
];

const List<ClientTestimonial> testimonialCatalog = <ClientTestimonial>[
  ClientTestimonial(
    name: 'John Obwoge',
    role: 'Principal, Hightech College',
    quote:
        'Whimsey Tech transformed our entire enrollment process. They replaced our complex manual systems with a beautifully streamlined multi-step portal that drastically simplified tracking applicant data from day one.',
    projectSlug: 'hightech-international',
  ),
  ClientTestimonial(
    name: 'Mulusa Norris',
    role: 'CEO, Dynamic Pictures Media',
    quote:
        'The custom portfolio platform delivered by their team handles heavy media files effortlessly. Network lag is completely eliminated, and our client onboarding funnel has never run more smoothly.',
    projectSlug: 'dynamic-pictures-media',
  ),
  ClientTestimonial(
    name: 'Harmasson Lukale',
    role: 'Manager, Inner Harbour Resort',
    quote:
        'Our digital room catalog and restaurant booking modules are incredibly fast and reliable. Guests frequently comment on the smooth filters, and our backend planning is now flawlessly organized.',
    projectSlug: 'inner-harbour-resort',
  ),
];
