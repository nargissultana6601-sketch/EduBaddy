import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Drawer/daily_learn_screen.dart';
import 'Drawer/resources_screen.dart';
import 'app_theme.dart';
import 'learning_drawer.dart';

enum LearningSection { dailyLearn, resources }

class LearningScaffold extends StatefulWidget {
  const LearningScaffold({
    super.key,
    this.initialSection = LearningSection.dailyLearn,
  });

  final LearningSection initialSection;

  @override
  State<LearningScaffold> createState() => _LearningScaffoldState();
}

class _LearningScaffoldState extends State<LearningScaffold> {
  late LearningSection _currentSection;

  @override
  void initState() {
    super.initState();
    _currentSection = widget.initialSection;
  }

  void showSection(LearningSection section) {
    setState(() {
      _currentSection = section;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final title = _currentSection == LearningSection.dailyLearn
        ? 'Daily Learn'
        : 'Resources';

    return Scaffold(
      backgroundColor: AppTheme.bgPrimary,
      drawer: LearningDrawer(
        currentSection: _currentSection,
        onSelectSection: showSection,
      ),
      appBar: AppBar(
        backgroundColor: AppTheme.bgPrimary,
        title: Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _currentSection == LearningSection.dailyLearn
            ? const DailyLearnScreen()
            : const ResourcesScreen(),
      ),
    );
  }
}
