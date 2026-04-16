import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'Screen/notification_screen.dart';
import 'Screen/ask_doubt_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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
                gradient: AppTheme.primaryGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'StudyHive Menu',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Quick access to learning features',
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
              icon: Icons.notifications_rounded,
              label: 'Notification',
              onTap: () => _navigateTo(context, const NotificationScreen()),
            ),
            _buildTile(
              context,
              icon: Icons.question_answer_rounded,
              label: 'Doubt Solving',
              onTap: () => _navigateTo(context, const AskDoubtScreen()),
            ),
            _buildTile(
              context,
              icon: Icons.how_to_vote_rounded,
              label: 'Voting',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Voting feature coming soon!'),
                ));
              },
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

  Widget _buildTile(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textPrimary),
      title: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
      ),
      onTap: onTap,
      hoverColor: AppTheme.bgCard,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      dense: true,
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}
