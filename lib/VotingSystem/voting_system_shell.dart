import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class VotingSystemShell extends StatefulWidget {
  const VotingSystemShell({super.key});

  @override
  State<VotingSystemShell> createState() => _VotingSystemShellState();
}

class _VotingSystemShellState extends State<VotingSystemShell> {
  bool _isLoading = true;
  bool _isCR = false;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final data = doc.data();
      if (!mounted) return;
      setState(() {
        _isCR = data?['isCR'] == true;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return VotingHomeScreen(isCR: _isCR);
  }
}
