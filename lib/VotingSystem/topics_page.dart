import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CTType { none, ct1, ct2, ct3, ct4 }

extension CTTypeExtension on CTType {
  Color get color {
    switch (this) {
      case CTType.ct1:
        return Colors.red.shade100;
      case CTType.ct2:
        return Colors.green.shade100;
      case CTType.ct3:
        return Colors.orange.shade100;
      case CTType.ct4:
        return Colors.blue.shade100;
      case CTType.none:
        return Colors.transparent;
    }
  }

  String get displayName {
    switch (this) {
      case CTType.ct1:
        return 'CT1';
      case CTType.ct2:
        return 'CT2';
      case CTType.ct3:
        return 'CT3';
      case CTType.ct4:
        return 'CT4';
      case CTType.none:
        return '';
    }
  }
}

class Topic {
  Topic({
    required this.id,
    required this.name,
    this.isSelected = false,
    this.ctType = CTType.none,
    required this.createdAt,
  });

  String id;
  String name;
  bool isSelected;
  CTType ctType;
  DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isSelected': isSelected,
        'ctType': ctType.index,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json['id'] as String,
        name: json['name'] as String,
        isSelected: json['isSelected'] as bool? ?? false,
        ctType: CTType.values[json['ctType'] as int? ?? 0],
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}

class Course {
  Course({
    required this.id,
    required this.code,
    required this.name,
    required this.topics,
  });

  String id;
  String code;
  String name;
  List<Topic> topics;

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'topics': topics.map((t) => t.toJson()).toList(),
      };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['id'] as String,
        code: json['code'] as String,
        name: json['name'] as String,
        topics: (json['topics'] as List)
            .map((t) => Topic.fromJson(t as Map<String, dynamic>))
            .toList(),
      );
}

class UserRole {
  static const String student = 'student';
  static const String cr = 'cr';

  UserRole({this.role = student});

  String role;

  bool get canAddTopic => role == cr;
  bool get canDeleteTopic => role == cr;
  bool get canAddCourse => role == cr;
  bool get canDeleteCourse => role == cr;
}

class CurriculumData {
  static Map<String, Map<String, Map<String, List<Course>>>> data = {};

  static void initialize() {
    if (data.isNotEmpty) return;

    data['CSE'] = {
      '1st': {
        'Odd': [
          Course(
            id: 'cse_1st_odd_1',
            code: 'CSE 1101',
            name: 'Structured Programming',
            topics: [
              Topic(
                id: '1',
                name: 'Algorithm',
                createdAt: DateTime.now(),
              ),
              Topic(
                id: '2',
                name: 'Writing Programs',
                createdAt: DateTime.now(),
              ),
              Topic(
                id: '3',
                name: 'Debugging Programs',
                createdAt: DateTime.now(),
              ),
            ],
          ),
        ],
        'Even': [
          Course(
            id: 'cse_1st_even_1',
            code: 'CSE 1201',
            name: 'Data Structure',
            topics: [
              Topic(
                id: '10',
                name: 'Linear Array',
                createdAt: DateTime.now(),
              ),
              Topic(
                id: '11',
                name: 'Stack',
                createdAt: DateTime.now(),
              ),
            ],
          ),
        ],
      },
      '2nd': {'Odd': [], 'Even': []},
      '3rd': {'Odd': [], 'Even': []},
      '4th': {'Odd': [], 'Even': []},
    };

    data['EEE'] = {
      '1st': {
        'Odd': [
          Course(
            id: 'eee_1st_odd_1',
            code: 'EEE 1101',
            name: 'Basic Electrical Engineering',
            topics: [
              Topic(
                id: '101',
                name: 'Ohm\'s Law',
                createdAt: DateTime.now(),
              ),
              Topic(
                id: '102',
                name: 'Kirchhoff\'s Laws',
                createdAt: DateTime.now(),
              ),
            ],
          ),
        ],
        'Even': [],
      },
      '2nd': {'Odd': [], 'Even': []},
      '3rd': {'Odd': [], 'Even': []},
      '4th': {'Odd': [], 'Even': []},
    };

    data['CE'] = {
      '1st': {
        'Odd': [
          Course(
            id: 'ce_1st_odd_1',
            code: 'CE 1101',
            name: 'Engineering Mechanics',
            topics: [
              Topic(
                id: '201',
                name: 'Force Systems',
                createdAt: DateTime.now(),
              ),
              Topic(
                id: '202',
                name: 'Equilibrium',
                createdAt: DateTime.now(),
              ),
            ],
          ),
        ],
        'Even': [],
      },
      '2nd': {'Odd': [], 'Even': []},
      '3rd': {'Odd': [], 'Even': []},
      '4th': {'Odd': [], 'Even': []},
    };

    data['ME'] = {
      '1st': {
        'Odd': [
          Course(
            id: 'me_1st_odd_1',
            code: 'ME 1101',
            name: 'Basic Mechanical Engineering',
            topics: [
              Topic(
                id: '301',
                name: 'Thermodynamics',
                createdAt: DateTime.now(),
              ),
              Topic(
                id: '302',
                name: 'Fluid Mechanics',
                createdAt: DateTime.now(),
              ),
            ],
          ),
        ],
        'Even': [],
      },
      '2nd': {'Odd': [], 'Even': []},
      '3rd': {'Odd': [], 'Even': []},
      '4th': {'Odd': [], 'Even': []},
    };
  }
}

class TopicStorage {
  static Future<void> saveTopics(
    String department,
    String year,
    String semester,
    List<Course> courses,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${department}_${year}_$semester';
      final coursesJson = courses.map((c) => c.toJson()).toList();
      await prefs.setString(key, jsonEncode(coursesJson));
    } catch (_) {}
  }

  static Future<List<Course>?> loadTopics(
    String department,
    String year,
    String semester,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${department}_${year}_$semester';
      final data = prefs.getString(key);
      if (data != null) {
        final coursesJson = jsonDecode(data) as List;
        return coursesJson
            .map((c) => Course.fromJson(c as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
    return null;
  }
}

class TopicsPage extends StatefulWidget {
  const TopicsPage({
    super.key,
    required this.department,
    required this.year,
    required this.semester,
    this.isCR = false,
  });

  final String department;
  final String year;
  final String semester;
  final bool isCR;

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  List<Course> _courses = [];
  Course? _selectedCourse;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _newTopicController = TextEditingController();
  final TextEditingController _newCourseCodeController =
      TextEditingController();
  final TextEditingController _newCourseNameController =
      TextEditingController();
  bool _isLoading = true;
  late UserRole _userRole;
  final Set<String> _selectedTopicIds = {};

  @override
  void initState() {
    super.initState();
    _userRole = UserRole(role: widget.isCR ? UserRole.cr : UserRole.student);
    _initializeData();
  }

  Future<void> _initializeData() async {
    setState(() => _isLoading = true);
    CurriculumData.initialize();

    final savedCourses = await TopicStorage.loadTopics(
      widget.department,
      widget.year,
      widget.semester,
    );

    _courses = savedCourses ??
        (CurriculumData.data[widget.department]?[widget.year]?[widget.semester] ??
            []);

    if (_courses.isNotEmpty) {
      _selectedCourse = _courses.first;
    }

    if (_courses.isNotEmpty) {
      await TopicStorage.saveTopics(
        widget.department,
        widget.year,
        widget.semester,
        _courses,
      );
    }

    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  List<Topic> get _visibleTopics {
    if (_selectedCourse == null) return [];
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _selectedCourse!.topics;
    return _selectedCourse!.topics
        .where((topic) => topic.name.toLowerCase().contains(query))
        .toList();
  }

  void _toggleTopicSelection(String topicId) {
    setState(() {
      if (_selectedTopicIds.contains(topicId)) {
        _selectedTopicIds.remove(topicId);
      } else {
        _selectedTopicIds.add(topicId);
      }
    });
  }

  Future<void> _persistCourses() async {
    await TopicStorage.saveTopics(
      widget.department,
      widget.year,
      widget.semester,
      _courses,
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _addCourse() async {
    final code = _newCourseCodeController.text.trim();
    final name = _newCourseNameController.text.trim();
    if (code.isEmpty || name.isEmpty) {
      _showSnackBar('Please enter both course code and name', isError: true);
      return;
    }

    final newCourse = Course(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      code: code,
      name: name,
      topics: [],
    );

    setState(() {
      _courses.add(newCourse);
      _selectedCourse = newCourse;
    });
    await _persistCourses();
    _showSnackBar('Course added successfully');
  }

  Future<void> _deleteCourse() async {
    if (_selectedCourse == null) return;
    setState(() {
      _courses.removeWhere((c) => c.id == _selectedCourse!.id);
      _selectedCourse = _courses.isNotEmpty ? _courses.first : null;
      _selectedTopicIds.clear();
    });
    await _persistCourses();
    _showSnackBar('Course deleted successfully');
  }

  Future<void> _addTopic() async {
    if (_selectedCourse == null) return;
    final topicName = _newTopicController.text.trim();
    if (topicName.isEmpty) {
      _showSnackBar('Topic name cannot be empty', isError: true);
      return;
    }

    final newTopic = Topic(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: topicName,
      createdAt: DateTime.now(),
    );

    setState(() {
      _selectedCourse!.topics.insert(0, newTopic);
    });
    await _persistCourses();
    _showSnackBar('Topic added successfully');
  }

  Future<void> _deleteSelectedTopics() async {
    if (_selectedTopicIds.isEmpty) return;
    setState(() {
      for (final course in _courses) {
        course.topics.removeWhere((t) => _selectedTopicIds.contains(t.id));
      }
      _selectedTopicIds.clear();
    });
    await _persistCourses();
    _showSnackBar('Topics deleted successfully');
  }

  Future<void> _applyCTToSelected(CTType type) async {
    setState(() {
      for (final course in _courses) {
        for (final topic in course.topics) {
          if (_selectedTopicIds.contains(topic.id)) {
            topic.ctType = type;
          }
        }
      }
    });
    await _persistCourses();
    _showSnackBar('${type.displayName} applied');
  }

  void _showAddCourseDialog() {
    _newCourseCodeController.clear();
    _newCourseNameController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Course'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _newCourseCodeController,
              decoration: const InputDecoration(
                labelText: 'Course Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newCourseNameController,
              decoration: const InputDecoration(
                labelText: 'Course Name',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _addCourse();
            },
            child: const Text('Add Course'),
          ),
        ],
      ),
    );
  }

  void _showAddTopicDialog() {
    _newTopicController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Topic'),
        content: TextField(
          controller: _newTopicController,
          decoration: const InputDecoration(
            labelText: 'Topic Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _addTopic();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildCTButton(CTType type, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed:
            _selectedTopicIds.isEmpty ? null : () => _applyCTToSelected(type),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _selectedTopicIds.isEmpty ? Colors.grey.shade300 : color,
          foregroundColor:
              _selectedTopicIds.isEmpty ? Colors.grey.shade600 : Colors.white,
        ),
        child: Text(type.displayName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.department} - ${widget.year} Year ${widget.semester}',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          if (_userRole.canDeleteCourse && _selectedCourse != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _deleteCourse,
            ),
          if (_selectedTopicIds.isNotEmpty && _userRole.canDeleteTopic)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteSelectedTopics,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _courses.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        'No courses available',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      if (_userRole.canAddCourse)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton.icon(
                            onPressed: _showAddCourseDialog,
                            icon: const Icon(Icons.add),
                            label: const Text('Add First Course'),
                          ),
                        ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<Course>(
                                value: _selectedCourse,
                                isExpanded: true,
                                underline: const SizedBox(),
                                items: _courses.map((course) {
                                  return DropdownMenuItem(
                                    value: course,
                                    child: Text('${course.code} - ${course.name}'),
                                  );
                                }).toList(),
                                onChanged: (course) {
                                  setState(() {
                                    _selectedCourse = course;
                                    _selectedTopicIds.clear();
                                  });
                                },
                              ),
                            ),
                          ),
                          if (_userRole.canAddCourse)
                            IconButton(
                              icon: const Icon(Icons.add_circle,
                                  color: Colors.blue),
                              onPressed: _showAddCourseDialog,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Search topics...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    if (_selectedTopicIds.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            _buildCTButton(CTType.ct1, Colors.red),
                            const SizedBox(width: 8),
                            _buildCTButton(CTType.ct2, Colors.green),
                            const SizedBox(width: 8),
                            _buildCTButton(CTType.ct3, Colors.orange),
                            const SizedBox(width: 8),
                            _buildCTButton(CTType.ct4, Colors.blue),
                          ],
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _visibleTopics.length,
                        itemBuilder: (context, index) {
                          final topic = _visibleTopics[index];
                          final isSelected = _selectedTopicIds.contains(topic.id);
                          return Card(
                            color: topic.ctType.color,
                            child: ListTile(
                              leading: Checkbox(
                                value: isSelected,
                                onChanged: (_) =>
                                    _toggleTopicSelection(topic.id),
                              ),
                              title: Text(topic.name),
                              subtitle: topic.ctType != CTType.none
                                  ? Text('Selected as: ${topic.ctType.displayName}')
                                  : null,
                              onTap: () => _toggleTopicSelection(topic.id),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: _userRole.canAddTopic && _selectedCourse != null
          ? FloatingActionButton.extended(
              onPressed: _showAddTopicDialog,
              icon: const Icon(Icons.add),
              label: const Text('Add Topic'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            )
          : null,
    );
  }
}
