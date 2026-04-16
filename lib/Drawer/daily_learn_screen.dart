import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

import '../app_theme.dart';

class DailyLearnScreen extends StatefulWidget {
  const DailyLearnScreen({super.key});

  @override
  State<DailyLearnScreen> createState() => _DailyLearnScreenState();
}

class _DailyLearnScreenState extends State<DailyLearnScreen> {
  int streakCount = 3;
  int completedLessons = 0;

  final List<Map<String, String>> dailyLessons = const [
    // ================= Programming =================
    {
      'title': 'Python Fundamentals',
      'description': 'Learn Python basics for problem solving.',
      'language': 'Python',
      'link': 'https://docs.python.org/3/tutorial/',
    },
    {
      'title': 'Flutter Basics',
      'description': 'Learn the basics of Flutter and widgets.',
      'language': 'Flutter',
      'link': 'https://docs.flutter.dev/get-started',
    },
    {
      'title': 'Dart Language',
      'description': 'Understand Dart syntax and structures.',
      'language': 'Flutter',
      'link': 'https://dart.dev/guides',
    },
    {
      'title': 'JavaScript Basics',
      'description': 'Understand JavaScript for web development.',
      'language': 'JavaScript',
      'link': 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide',
    },

    // ================= Discrete Mathematics =================
    {
      'title': 'Logic and Proof',
      'description': 'Propositional logic, predicates, proofs.',
      'language': 'Discrete Math',
      'link': 'https://www.geeksforgeeks.org/discrete-mathematics-logic/',
    },
    {
      'title': 'Sets & Cardinality',
      'description': 'Set operations, relations, cardinality.',
      'language': 'Discrete Math',
      'link': 'https://www.geeksforgeeks.org/sets-in-discrete-mathematics/',
    },
    {
      'title': 'Functions & Relations',
      'description': 'Functions and relations.',
      'language': 'Discrete Math',
      'link': 'https://www.geeksforgeeks.org/functions-discrete-mathematics/',
    },
    {
      'title': 'Counting Techniques',
      'description': 'Permutations, combinations, pigeonhole principle.',
      'language': 'Discrete Math',
      'link': 'https://www.geeksforgeeks.org/counting-principles/',
    },
    {
      'title': 'Graphs',
      'description': 'Graph theory basics.',
      'language': 'Discrete Math',
      'link':
          'https://www.geeksforgeeks.org/graph-data-structure-and-algorithms/',
    },

    // ================= Digital Logic Design =================
    {
      'title': 'Number Systems & Codes',
      'description': 'Binary, octal, hexadecimal number systems.',
      'language': 'DLD',
      'link': 'https://www.geeksforgeeks.org/number-system-and-codes/',
    },
    {
      'title': 'Boolean Algebra',
      'description': 'Boolean laws and simplification.',
      'language': 'DLD',
      'link': 'https://www.geeksforgeeks.org/boolean-algebra/',
    },
    {
      'title': 'Combinational Logic Circuits',
      'description': 'Adders, subtractors, multiplexers.',
      'language': 'DLD',
      'link': 'https://www.geeksforgeeks.org/combinational-logic-circuits/',
    },
    {
      'title': 'Sequential Logic & Flip-Flops',
      'description': 'Flip-flops, counters, registers.',
      'language': 'DLD',
      'link': 'https://www.geeksforgeeks.org/sequential-circuits/',
    },

    // ================= Electrical Drives & Instrumentation =================
    {
      'title': 'DC Machines',
      'description': 'DC motors and generators.',
      'language': 'Electrical',
      'link': 'https://www.geeksforgeeks.org/dc-machines/',
    },
    {
      'title': 'AC Machines',
      'description': 'Transformers and induction motors.',
      'language': 'Electrical',
      'link': 'https://www.geeksforgeeks.org/ac-machines/',
    },
    {
      'title': 'Measuring Instruments',
      'description': 'Analog and digital measuring instruments.',
      'language': 'Electrical',
      'link': 'https://www.geeksforgeeks.org/electrical-measuring-instruments/',
    },

    // ================= Vector Analysis & Linear Algebra =================
    {
      'title': 'Vector Calculus',
      'description': 'Gradient, divergence, curl.',
      'language': 'Math',
      'link': 'https://www.geeksforgeeks.org/vector-calculus/',
    },
    {
      'title': 'Matrices & Linear Equations',
      'description': 'Matrices and linear systems.',
      'language': 'Math',
      'link': 'https://www.geeksforgeeks.org/matrices/',
    },
    {
      'title': 'Eigenvalues & Eigenvectors',
      'description': 'Eigenvalues and eigenvectors.',
      'language': 'Math',
      'link': 'https://www.geeksforgeeks.org/eigenvalues-and-eigenvectors/',
    },

    // ================= Economics =================
    {
      'title': 'Introduction to Economics',
      'description': 'Basic concepts of economics.',
      'language': 'Economics',
      'link': 'https://www.investopedia.com/terms/e/economics.asp',
    },
    {
      'title': 'Demand, Supply & Elasticity',
      'description': 'Market demand, supply, and elasticity.',
      'language': 'Economics',
      'link': 'https://www.investopedia.com/terms/l/lawofdemand.asp',
    },
    {
      'title': 'Economy of Bangladesh',
      'description': 'Economic structure of Bangladesh.',
      'language': 'Economics',
      'link': 'https://en.wikipedia.org/wiki/Economy_of_Bangladesh',
    },

    // ================= Government & Sociology =================
    {
      'title': 'State and Government',
      'description': 'Concept of state and governance.',
      'language': 'Civics',
      'link':
          'https://www.britannica.com/topic/state-sovereign-political-entity',
    },
    {
      'title': 'Forms of Government',
      'description': 'Democracy, monarchy, dictatorship.',
      'language': 'Civics',
      'link': 'https://www.britannica.com/topic/government',
    },
    {
      'title': 'Introduction to Sociology',
      'description': 'Society, culture, and social system.',
      'language': 'Sociology',
      'link': 'https://www.britannica.com/topic/sociology',
    },
    {
      'title': 'Social Problems of Bangladesh',
      'description': 'Social development issues.',
      'language': 'Sociology',
      'link': 'https://en.wikipedia.org/wiki/Social_issues_in_Bangladesh',
    },
  ];

  String dailyAdvice =
      "📌 Consistency beats intensity. Learn a little every day!";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bgPrimary,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            color: AppTheme.bgCard,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "🔥 Streak: $streakCount days",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "🎯 Daily Goal: $completedLessons / ${dailyLessons.length}",
                    style: GoogleFonts.inter(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dailyAdvice,
                    style: GoogleFonts.inter(color: const Color(0xFF43D39E)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // 📚 Lesson List
          Expanded(
            child: ListView.builder(
              itemCount: dailyLessons.length,
              itemBuilder: (context, index) {
                final lesson = dailyLessons[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: AppTheme.bgCard,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.neonBlue,
                      child: Text(
                        lesson['language']![0],
                        style: GoogleFonts.spaceGrotesk(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      lesson['title']!,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      "${lesson['description']}\nSubject: ${lesson['language']}",
                      style: GoogleFonts.inter(
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    isThreeLine: true,
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppTheme.textMuted,
                    ),
                    onTap: () {
                      setState(() {
                        completedLessons++;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LessonDetailPage(
                            title: lesson['title']!,
                            description: lesson['description']!,
                            link: lesson['link']!,
                            youtubeLink: lesson['youtube'],
                            gdriveLink: lesson['gdrive'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ================= Lesson Detail Page =================
class LessonDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String link;
  final String? youtubeLink;
  final String? gdriveLink;

  const LessonDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.link,
    this.youtubeLink,
    this.gdriveLink,
  });

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Handle error - maybe show a snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open link: $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPrimary,
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.description,
              style: GoogleFonts.inter(
                fontSize: 18,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Docs button
            ElevatedButton.icon(
              icon: const Icon(Icons.link),
              label: const Text("Open Docs"),
              onPressed: () => _openLink(widget.link),
            ),

            const SizedBox(height: 12),

            // YouTube button
            if (widget.youtubeLink != null)
              ElevatedButton.icon(
                icon: const Icon(Icons.play_circle_fill),
                label: const Text("Watch on YouTube"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => _openLink(widget.youtubeLink!),
              ),

            const SizedBox(height: 12),

            // Google Drive button
            if (widget.gdriveLink != null)
              ElevatedButton.icon(
                icon: const Icon(Icons.cloud),
                label: const Text("Open on Google Drive"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () => _openLink(widget.gdriveLink!),
              ),

            const SizedBox(height: 20),
            Text(
              "💡 Advice:\nPractice what you learn today before sleeping.",
              style: GoogleFonts.inter(color: AppTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
