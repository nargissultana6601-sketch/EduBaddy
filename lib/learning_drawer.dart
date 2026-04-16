import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';
import 'learning_scaffold.dart';

class LearningDrawer extends StatelessWidget {
  const LearningDrawer({
    super.key,
    required this.currentSection,
    required this.onSelectSection,
  });

  final LearningSection currentSection;
  final ValueChanged<LearningSection> onSelectSection;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppTheme.bgPrimary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1DAA8B), Color(0xFF0C5B62)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Learning App',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Switch between Daily Learn and Resources',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            _buildTile(
              context,
              icon: Icons.auto_stories_rounded,
              label: 'Daily Learn',
              selected: currentSection == LearningSection.dailyLearn,
              onTap: () => onSelectSection(LearningSection.dailyLearn),
            ),
            _buildTile(
              context,
              icon: Icons.menu_book_rounded,
              label: 'Resources',
              selected: currentSection == LearningSection.resources,
              onTap: () => onSelectSection(LearningSection.resources),
            ),
            const Divider(color: AppTheme.borderColor),
            _buildTile(
              context,
              icon: Icons.home_rounded,
              label: 'App Home',
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool selected = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? AppTheme.neonBlue : AppTheme.textPrimary,
      ),
      tileColor: selected ? AppTheme.bgCard : Colors.transparent,
      title: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      dense: true,
    );
  }
}
