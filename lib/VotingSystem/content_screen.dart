import 'package:flutter/material.dart';

import 'topics_page.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key, required this.isCR});

  final bool isCR;

  @override
  State<StatefulWidget> createState() {
    return _SelectionPageState();
  }
}

class _SelectionPageState extends State<ContentScreen> {
  final List<String> departments = ['CSE', 'EEE', 'CE', 'ME'];
  String selectedDepartment = 'CE';
  final List<String> years = ['1st', '2nd', '3rd', '4th'];
  String selectedYear = '1st';
  final List<String> semesters = ['Odd', 'Even'];
  String selectedSemester = 'Odd';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdownSection(
              title: 'Select Department',
              value: selectedDepartment,
              items: departments,
              onChanged: (value) {
                setState(() => selectedDepartment = value!);
              },
            ),
            _buildDropdownSection(
              title: 'Select Year',
              value: selectedYear,
              items: years,
              onChanged: (value) {
                setState(() => selectedYear = value!);
              },
            ),
            _buildDropdownSection(
              title: 'Select Semester',
              value: selectedSemester,
              items: semesters,
              onChanged: (value) {
                setState(() => selectedSemester = value!);
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Results Showing For:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Department: $selectedDepartment'),
                  const SizedBox(height: 5),
                  Text('Year: $selectedYear'),
                  const SizedBox(height: 5),
                  Text('Semester: $selectedSemester'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopicsPage(
                      department: selectedDepartment,
                      year: selectedYear,
                      semester: selectedSemester,
                      isCR: widget.isCR,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownSection({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
