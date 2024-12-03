import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/azkar_controller.dart';

class AzkarSearchPage extends StatefulWidget {
  @override
  _AzkarSearchPageState createState() => _AzkarSearchPageState();
}

class _AzkarSearchPageState extends State<AzkarSearchPage> {
  // Azkar list (simulating the azkarController.matchingAzkar)
  List<String> allAzkar = [
    'الاستغفار',
    'الصلاة علي النبي',
    'الحمد',
    'الحبیبتان',
    'التھلیل',
    'الباقیات الصالحات',
    'أذكار الصباح',
    'أذكار المساء',
  ];

  List<String> matchingAzkar = [];
  String query = '';
  TextEditingController azkarSearchController = TextEditingController();
  final AzkarController azkarController = Get.put(AzkarController());

  void _searchAzkar() {
    query = azkarSearchController.text;

    azkarController.performSearch2(query);
  }

  @override
  void dispose() {
    azkarSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150), // AppBar height
        child: AppBar(
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "بحث في الأذكار",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                // Row for TextField and Search Button side by side
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: azkarSearchController,
                        decoration: InputDecoration(
                          hintText: "ابحث عن ذكر...",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                        onSubmitted: (_) {
                          _searchAzkar();
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _searchAzkar,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('ابحث', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying matching azkar or empty message

           Obx(() {
                return azkarController.matchingAzkar.isEmpty
                    ? Center(child: Text("أدخل كلمة البحث للبحث"))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: azkarController.matchingAzkar.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text(
                                azkarController.matchingAzkar[index].content!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }
            )
          ],
        ),
      ),
    );
  }
}
