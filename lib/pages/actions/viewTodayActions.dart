import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'actions_predefine.dart';
import 'database_helper.dart';

class LargeFormScreen extends StatefulWidget {
  final DateTime selectedDate;

  LargeFormScreen({required this.selectedDate});

  @override
  _LargeFormScreenState createState() => _LargeFormScreenState();
}

class _LargeFormScreenState extends State<LargeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String formattedDate;
  late String dayName;
  final List<Map<String, dynamic>> categories = predefinedActions;
  Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    dayName = DateFormat('EEEE', 'ar').format(widget.selectedDate);
    _initializeControllers();
    _loadFormData();
  }

  void _initializeControllers() {
    for (var category in categories) {
      for (var subcategory in category["subcategories"]) {
        String key = '${category["category"]}_${subcategory["name"]}';
        _controllers[key] = TextEditingController();
      }
    }
  }

  Future<void> _loadFormData() async {
    final data = await DBHelper.instance.fetchFormData(formattedDate);

    print('Fetched data for $formattedDate: $data');

    for (var entry in data) {
      final categoryName = entry['category'];
      final subcategoryName = entry['subcategory'];
      final done = entry['done'] == 1;
      final comment = entry['comment'];

      String key = '${categoryName}_${subcategoryName}';

      for (var category in categories) {
        if (category['category'] == categoryName) {
          for (var subcategory in category['subcategories']) {
            if (subcategory['name'] == subcategoryName) {
              subcategory['done'] = done;
              _controllers[key]?.text = comment; // Apply the comment
            }
          }
        }
      }
    }

    setState(() {});
  }

  Future<void> _saveForm() async {
    for (var category in categories) {
      for (var subcategory in category["subcategories"]) {
        String key = '${category["category"]}_${subcategory["name"]}';
        final entry = {
          "category": category["category"],
          "subcategory": subcategory["name"],
          "done": subcategory["done"] ? 1 : 0,
          "comment": _controllers[key]?.text ?? "",
          "date": formattedDate,
        };

        print('Saving entry: $entry');

        await DBHelper.instance.updateFormEntry(entry).then((rowsAffected) {
          if (rowsAffected == 0) {
            DBHelper.instance.insertFormEntry(entry);
          }
        });
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Form saved successfully!')),
    );
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$dayName, $formattedDate'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ...categories.map((category) {
                return ExpansionTile(
                  title: Text(
                    category["category"],
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  children:
                      category["subcategories"].map<Widget>((subcategory) {
                    String key =
                        '${category["category"]}_${subcategory["name"]}';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _controllers[key],
                              decoration: InputDecoration(
                                labelText: subcategory["name"],
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Checkbox(
                            value: subcategory["done"],
                            onChanged: (value) {
                              setState(() {
                                subcategory["done"] = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
