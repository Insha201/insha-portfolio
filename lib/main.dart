import 'dart:html' as html;
import 'package:flutter/material.dart';

// ============================================================
// GLOBAL COLORS
// ============================================================

const Color background = Color(0xFFF7F4FC);
const Color softPurple = Color(0xFFE9E1FA);
const Color purple = Color(0xFF7357D8);
const Color deepPurple = Color(0xFF5037A8);
const Color navy = Color(0xFF171A3B);
const Color muted = Color(0xFF69677A);
const Color white = Color(0xFFFFFFFF);
const Color lavender = Color(0xFFF0EBFA);

void main() {
  runApp(const InshaPortfolio());
}

// ============================================================
// APP
// ============================================================

class InshaPortfolio extends StatelessWidget {
  const InshaPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insha Ansari | AI & ML Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.light,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final journeyKey = GlobalKey();
  final contactKey = GlobalKey();

  late AnimationController entranceController;
  late AnimationController floatingController;

  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> floatingAnimation;

  bool menuOpen = false;

  @override
  void initState() {
    super.initState();

    entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    fadeAnimation = CurvedAnimation(
      parent: entranceController,
      curve: Curves.easeOut,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: entranceController,
        curve: Curves.easeOutCubic,
      ),
    );

    floatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);

    floatingAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: floatingController,
        curve: Curves.easeInOut,
      ),
    );

    entranceController.forward();
  }

  @override
  void dispose() {
    entranceController.dispose();
    floatingController.dispose();
    super.dispose();
  }

  void scrollTo(GlobalKey key) {
    final context = key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }

    setState(() {
      menuOpen = false;
    });
  }

  void openLink(String url) {
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildNavbar(),
                _buildHero(),
                _buildAbout(),
                _buildSkills(),
                _buildProjects(),
                _buildJourney(),
                _buildAchievement(),
                _buildContact(),
                _buildFooter(),
              ],
            ),
          ),

          if (menuOpen)
            Positioned(
              top: 72,
              right: 18,
              child: _buildMobileMenu(),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // NAVBAR
  // ============================================================

  Widget _buildNavbar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final mobile = constraints.maxWidth < 800;

              return Row(
                children: [
                  _buildLogo(),

                  const Spacer(),

                  if (!mobile)
                    Row(
                      children: [
                        AnimatedNavItem(
                          title: 'Home',
                          onTap: () => scrollTo(homeKey),
                        ),
                        AnimatedNavItem(
                          title: 'About',
                          onTap: () => scrollTo(aboutKey),
                        ),
                        AnimatedNavItem(
                          title: 'Skills',
                          onTap: () => scrollTo(skillsKey),
                        ),
                        AnimatedNavItem(
                          title: 'Projects',
                          onTap: () => scrollTo(projectsKey),
                        ),
                        AnimatedNavItem(
                          title: 'Journey',
                          onTap: () => scrollTo(journeyKey),
                        ),
                        AnimatedNavItem(
                          title: 'Contact',
                          onTap: () => scrollTo(contactKey),
                        ),
                      ],
                    )
                  else
                    IconButton(
                      onPressed: () {
                        setState(() {
                          menuOpen = !menuOpen;
                        });
                      },
                      icon: Icon(
                        menuOpen ? Icons.close : Icons.menu_rounded,
                        color: navy,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return InkWell(
      onTap: () => scrollTo(homeKey),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    purple,
                    deepPurple,
                  ],
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Center(
                child: Text(
                  'IA',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Insha.',
              style: TextStyle(
                color: navy,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenu() {
    return Material(
      color: white,
      elevation: 12,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 210,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _mobileItem('Home', homeKey),
            _mobileItem('About', aboutKey),
            _mobileItem('Skills', skillsKey),
            _mobileItem('Projects', projectsKey),
            _mobileItem('Journey', journeyKey),
            _mobileItem('Contact', contactKey),
          ],
        ),
      ),
    );
  }

  Widget _mobileItem(String title, GlobalKey key) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: navy,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () => scrollTo(key),
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero() {
    return Container(
      key: homeKey,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 85,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            background,
            lavender,
            softPurple,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final mobile = constraints.maxWidth < 760;

                  if (mobile) {
                    return Column(
                      children: [
                        _buildHeroAvatar(),
                        const SizedBox(height: 45),
                        _buildHeroText(),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: _buildHeroText(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: _buildHeroAvatar(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: purple.withOpacity(0.15),
            ),
          ),
          child: const Text(
            'AI & ML ENGINEERING STUDENT',
            style: TextStyle(
              color: purple,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Hi, I\'m\nInsha Ansari.',
          style: TextStyle(
            color: navy,
            fontSize: 58,
            height: 1.02,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'I build intelligent, meaningful and user-focused '
          'solutions with Artificial Intelligence and Machine Learning.',
          style: TextStyle(
            color: muted,
            fontSize: 18,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            HoverButton(
              text: 'View My Work',
              icon: Icons.arrow_forward_rounded,
              filled: true,
              onTap: () => scrollTo(projectsKey),
            ),
            HoverButton(
              text: 'Contact Me',
              icon: Icons.mail_outline_rounded,
              filled: false,
              onTap: () => scrollTo(contactKey),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: purple,
              size: 18,
            ),
            const SizedBox(width: 7),
            const Text(
              'Mumbai, India',
              style: TextStyle(
                color: muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroAvatar() {
    return AnimatedBuilder(
      animation: floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, floatingAnimation.value),
          child: child,
        );
      },
      child: Container(
        width: 310,
        height: 310,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              purple,
              deepPurple,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: purple.withOpacity(0.25),
              blurRadius: 45,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 270,
            height: 270,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withOpacity(0.95),
              border: Border.all(
                color: white,
                width: 5,
              ),
            ),
            child: const Center(
              child: Text(
                'IA',
                style: TextStyle(
                  color: purple,
                  fontSize: 78,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ABOUT
  // ============================================================

  Widget _buildAbout() {
    return SectionContainer(
      key: aboutKey,
      title: 'About Me',
      subtitle: 'A little about my journey',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mobile = constraints.maxWidth < 760;

          final intro = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Building with curiosity, learning with purpose.',
                style: TextStyle(
                  color: navy,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'I am Insha Ansari, a third-year BE student specializing '
                'in Artificial Intelligence and Machine Learning at '
                'M.H. Saboo Siddik College of Engineering.',
                style: TextStyle(
                  color: muted,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'I completed my diploma in the AI & ML domain and '
                'have been developing my skills across programming, '
                'machine learning, deep learning and computer vision.',
                style: TextStyle(
                  color: muted,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Currently, I am exploring modern AI technologies while '
                'continuously strengthening my fundamentals and building '
                'practical projects.',
                style: TextStyle(
                  color: muted,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),
            ],
          );

          final cards = Column(
            children: [
              InfoCard(
                icon: Icons.school_rounded,
                title: 'Education',
                value: 'BE in Artificial Intelligence & Machine Learning',
                subtitle: 'M.H. Saboo Siddik College of Engineering',
              ),
              const SizedBox(height: 16),
              InfoCard(
                icon: Icons.calendar_month_rounded,
                title: 'Graduation',
                value: '2028',
                subtitle: 'Currently in Third Year',
              ),
              const SizedBox(height: 16),
              InfoCard(
                icon: Icons.code_rounded,
                title: 'Focus',
                value: 'AI • ML • Software Development',
                subtitle: 'Learning through practical projects',
              ),
            ],
          );

          if (mobile) {
            return Column(
              children: [
                intro,
                const SizedBox(height: 35),
                cards,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: intro,
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 4,
                child: cards,
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // SKILLS
  // ============================================================

  Widget _buildSkills() {
    final skills = [
      'Python',
      'HTML',
      'CSS',
      'JavaScript',
      'Machine Learning',
      'Deep Learning',
      'Computer Vision',
      'NLP',
      'Flutter',
    ];

    return SectionContainer(
      key: skillsKey,
      title: 'Skills',
      subtitle: 'Technologies I work with',
      backgroundColor: lavender,
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: skills
            .map(
              (skill) => SkillChip(
                name: skill,
              ),
            )
            .toList(),
      ),
    );
  }

  // ============================================================
  // PROJECTS
  // ============================================================

  Widget _buildProjects() {
    return SectionContainer(
      key: projectsKey,
      title: 'Featured Projects',
      subtitle: 'Projects I have designed and developed',
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final mobile = constraints.maxWidth < 850;

              final projects = [
                ProjectCard(
                  title: 'MindPlus',
                  subtitle: 'Student Stress Detection System',
                  year: '2024–25',
                  label: 'Diploma Project',
                  icon: Icons.psychology_rounded,
                  description:
                      'An AI-powered system that detects and analyzes '
                      'human posture in real time using computer vision '
                      'and machine learning techniques.',
                  technologies: [
                    'Python',
                    'Machine Learning',
                    'Computer Vision',
                  ],
                ),
                ProjectCard(
                  title: 'LEGALEASE',
                  subtitle: 'AI-Based Legal Assistance System',
                  year: '2025–26',
                  label: 'BE Project',
                  icon: Icons.gavel_rounded,
                  description:
                      'An AI platform combining NLP-based legal advisory, '
                      'scam detection, OCR document analysis and '
                      'multilingual support for accessible legal help.',
                  technologies: [
                    'Python',
                    'NLP',
                    'OCR',
                    'AI',
                  ],
                ),
                ProjectCard(
                  title: 'TruthLens',
                  subtitle: 'Multi-Agent AI Misinformation Detection',
                  year: '2025–26',
                  label: 'Award Winning',
                  icon: Icons.fact_check_rounded,
                  featured: true,
                  description:
                      'A real-time misinformation detection platform using '
                      'four cooperating AI agents for detection, tracing, '
                      'prediction and counter-narratives grounded in '
                      'verified sources.',
                  technologies: [
                    'Python',
                    'LangGraph',
                    'Groq',
                    'ChromaDB',
                    'Neo4j',
                    'FastAPI',
                    'React',
                  ],
                ),
              ];

              if (mobile) {
                return Column(
                  children: projects
                      .map(
                        (project) => Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: project,
                        ),
                      )
                      .toList(),
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: projects
                    .map(
                      (project) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: project,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // JOURNEY
  // ============================================================

  Widget _buildJourney() {
    return SectionContainer(
      key: journeyKey,
      title: 'My Journey',
      subtitle: 'From learning fundamentals to building AI solutions',
      backgroundColor: lavender,
      child: Column(
        children: [
          JourneyItem(
            year: '2024',
            title: 'Diploma in AI & ML',
            description:
                'Started building a strong foundation in programming, '
                'AI and machine learning.',
            icon: Icons.school_rounded,
          ),
          JourneyItem(
            year: '2024–25',
            title: 'MindPlus',
            description:
                'Developed a student stress detection project using '
                'computer vision and machine learning.',
            icon: Icons.psychology_rounded,
          ),
          JourneyItem(
            year: '2025',
            title: 'BE in AI & ML',
            description:
                'Continued my engineering journey while exploring '
                'advanced AI and software development.',
            icon: Icons.engineering_rounded,
          ),
          JourneyItem(
            year: '2025–26',
            title: 'LEGALEASE',
            description:
                'Worked on an AI-based legal assistance platform '
                'combining multiple intelligent features.',
            icon: Icons.gavel_rounded,
          ),
          JourneyItem(
            year: '2026',
            title: 'TruthLens',
            description:
                'Built a multi-agent misinformation detection system '
                'and secured first prize at a project expo.',
            icon: Icons.emoji_events_rounded,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACHIEVEMENT
  // ============================================================

  Widget _buildAchievement() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 75,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: Container(
            padding: const EdgeInsets.all(35),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  navy,
                  deepPurple,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: navy.withOpacity(0.18),
                  blurRadius: 35,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final mobile = constraints.maxWidth < 650;

                if (mobile) {
                  return Column(
                    children: [
                      _achievementIcon(),
                      const SizedBox(height: 25),
                      _achievementText(),
                    ],
                  );
                }

                return Row(
                  children: [
                    _achievementIcon(),
                    const SizedBox(width: 30),
                    Expanded(
                      child: _achievementText(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _achievementIcon() {
    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        color: white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: white.withOpacity(0.18),
        ),
      ),
      child: const Icon(
        Icons.emoji_events_rounded,
        color: white,
        size: 42,
      ),
    );
  }

  Widget _achievementText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACHIEVEMENT',
          style: TextStyle(
            color: Color(0xFFD8CFFF),
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '1st Prize — Project Expo',
          style: TextStyle(
            color: white,
            fontSize: 29,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Won first prize for TruthLens, a multi-agent AI '
          'misinformation detection project.',
          style: TextStyle(
            color: Color(0xFFD8D5E5),
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CONTACT
  // ============================================================

  Widget _buildContact() {
    return SectionContainer(
      key: contactKey,
      title: 'Let\'s Connect',
      subtitle: 'Have a project, opportunity or idea?',
      child: Center(
        child: Column(
          children: [
            const Text(
              'I would love to hear from you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: navy,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Whether it is an AI project, collaboration, internship '
              'opportunity or simply a conversation about technology.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: muted,
                fontSize: 16,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 14,
              runSpacing: 14,
              children: [
                HoverButton(
                  text: 'Email Me',
                  icon: Icons.email_outlined,
                  filled: true,
                  onTap: () {
                    html.window.location.href =
                        'mailto:a.insha.5001@gmail.com';
                  },
                ),
                HoverButton(
                  text: 'GitHub',
                  icon: Icons.code_rounded,
                  filled: false,
                  onTap: () {
                    openLink('https://github.com/Insha201');
                  },
                ),
              ],
            ),
            const SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: softPurple.withOpacity(0.55),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'a.insha.5001@gmail.com',
                style: TextStyle(
                  color: navy,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 35,
      ),
      color: navy,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            children: [
              const Text(
                'Insha Ansari',
                style: TextStyle(
                  color: white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'AI & ML Engineering Student',
                style: TextStyle(
                  color: Color(0xFFBEBBD0),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 1,
                color: white.withOpacity(0.1),
              ),
              const SizedBox(height: 20),
              const Text(
                '© 2026 Insha Ansari. Built with Flutter.',
                style: TextStyle(
                  color: Color(0xFF9F9CB2),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION CONTAINER
// ============================================================

class SectionContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final Color backgroundColor;

  const SectionContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.backgroundColor = background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 85,
      ),
      color: backgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: navy,
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  color: muted,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 38),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ANIMATED NAV ITEM
// ============================================================

class AnimatedNavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const AnimatedNavItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<AnimatedNavItem> createState() => _AnimatedNavItemState();
}

class _AnimatedNavItemState extends State<AnimatedNavItem> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovering = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: hovering
                ? purple.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: hovering ? navy : muted,
              fontWeight: hovering
                  ? FontWeight.w700
                  : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// INFO CARD
// ============================================================

class InfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: purple.withOpacity(
              hovering ? 0.45 : 0.12,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: navy.withOpacity(
                hovering ? 0.10 : 0.04,
              ),
              blurRadius: hovering ? 25 : 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: softPurple,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                widget.icon,
                color: purple,
                size: 26,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: purple,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.value,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      color: muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SKILL CHIP
// ============================================================

class SkillChip extends StatefulWidget {
  final String name;

  const SkillChip({
    super.key,
    required this.name,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: hovering ? softPurple : white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: purple.withOpacity(
              hovering ? 0.50 : 0.13,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: purple.withOpacity(
                hovering ? 0.12 : 0.04,
              ),
              blurRadius: hovering ? 16 : 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.circle,
              color: purple,
              size: 8,
            ),
            const SizedBox(width: 9),
            Text(
              widget.name,
              style: const TextStyle(
                color: navy,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROJECT CARD
// ============================================================

class ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String year;
  final String label;
  final String description;
  final IconData icon;
  final List<String> technologies;
  final bool featured;

  const ProjectCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.year,
    required this.label,
    required this.description,
    required this.icon,
    required this.technologies,
    this.featured = false,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final cardColor = widget.featured ? navy : white;
    final titleColor = widget.featured ? white : navy;
    final bodyColor = widget.featured
        ? const Color(0xFFD8D5E5)
        : muted;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(
          0,
          hovering ? -8 : 0,
          0,
        ),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: widget.featured
                ? Colors.transparent
                : purple.withOpacity(0.10),
          ),
          boxShadow: [
            BoxShadow(
              color: navy.withOpacity(
                hovering ? 0.13 : 0.05,
              ),
              blurRadius: hovering ? 30 : 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: widget.featured
                        ? white.withOpacity(0.12)
                        : softPurple,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.featured
                        ? white
                        : purple,
                    size: 26,
                  ),
                ),
                const Spacer(),
                if (widget.featured)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: purple.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '★ WINNER',
                      style: TextStyle(
                        color: white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              widget.title,
              style: TextStyle(
                color: titleColor,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.subtitle,
              style: TextStyle(
                color: widget.featured
                    ? const Color(0xFFCFCBE0)
                    : purple,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: widget.featured
                      ? const Color(0xFFBDB8D0)
                      : muted,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.year,
                  style: TextStyle(
                    color: bodyColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: widget.featured
                        ? white.withOpacity(0.10)
                        : softPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: widget.featured
                          ? white
                          : deepPurple,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              widget.description,
              style: TextStyle(
                color: bodyColor,
                fontSize: 14,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: widget.technologies
                  .map(
                    (tech) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: widget.featured
                            ? white.withOpacity(0.08)
                            : lavender,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tech,
                        style: TextStyle(
                          color: widget.featured
                              ? const Color(0xFFE3DFEE)
                              : deepPurple,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// JOURNEY ITEM
// ============================================================

class JourneyItem extends StatelessWidget {
  final String year;
  final String title;
  final String description;
  final IconData icon;

  const JourneyItem({
    super.key,
    required this.year,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: navy.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.circle,
              color: purple,
              size: 10,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: purple.withOpacity(0.09),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    year,
                    style: const TextStyle(
                      color: purple,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    description,
                    style: const TextStyle(
                      color: muted,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOVER BUTTON
// ============================================================

class HoverButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  const HoverButton({
    super.key,
    required this.text,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovering = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(
          0,
          hovering ? -3 : 0,
          0,
        ),
        child: ElevatedButton.icon(
          onPressed: widget.onTap,
          icon: Icon(
            widget.icon,
            size: 18,
          ),
          label: Text(
            widget.text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: widget.filled
                ? navy
                : white.withOpacity(0.55),
            foregroundColor: widget.filled
                ? white
                : navy,
            side: widget.filled
                ? BorderSide.none
                : BorderSide(
                    color: purple.withOpacity(0.35),
                  ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}