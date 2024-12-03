import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/azkar_controller.dart';
import '../models/azkar_model.dart';

class AzkarListPage extends StatefulWidget {
  final String? subCategory; // Subcategory name (optional)
  final List<Azkar>? matchingAzkar; // Search results (optional)
  final bool isSearchResult; // True if this is a search result

  AzkarListPage({
    this.subCategory,
    this.matchingAzkar,
    this.isSearchResult = false,
  });

  @override
  _AzkarListPageState createState() => _AzkarListPageState();
}

class _AzkarListPageState extends State<AzkarListPage>
    with TickerProviderStateMixin {
  final Map<int, AnimationController> _controllers = {};
  final Map<int, Animation<double>> _scaleAnimations = {};
  final AzkarController azkarController = Get.put(AzkarController());

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onTileClick(int index, Azkar azkar) {
    if (azkar.count! > 0) {
      setState(() {
        azkar.count = azkar.count! - 1;
      });

      // Trigger the animation for the clicked item
      final controller = _controllers[index];
      if (controller != null) {
        controller.forward().then((_) => controller.reverse());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 22, 43, 22),
        title: Text(
          azkarController.subCategoryAzkar[0].subCategory!,
          style: TextStyle(
            fontFamily: 'sebhafont',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFDAA520),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, //Color.fromARGB(255, 194, 218, 200),
      body: azkarController.subCategoryAzkar.isEmpty
          ? Center(
              child: Text(
                'لا توجد نتائج مطابقة.',
                style: TextStyle(
                  fontFamily: 'myarabic',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDAA520),
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: azkarController.subCategoryAzkar.length,
              itemBuilder: (context, index) {
                final azkar = azkarController.subCategoryAzkar[index];

                // Initialize animation controller and animation for this index if not already initialized
                if (!_controllers.containsKey(index)) {
                  final controller = AnimationController(
                    vsync: this, // Now using TickerProviderStateMixin
                    duration: Duration(milliseconds: 200),
                  );
                  _controllers[index] = controller;
                  _scaleAnimations[index] =
                      Tween<double>(begin: 1.0, end: 1.1).animate(
                    CurvedAnimation(parent: controller, curve: Curves.easeOut),
                  );
                }

                return ScaleTransition(
                  scale: _scaleAnimations[index]!,
                  child: GestureDetector(
                    onTap: () => _onTileClick(index, azkar),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      color: azkar.count == 0
                          ? Colors.grey[400]
                          : Color.fromARGB(255, 22, 43, 22),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        title: Text(
                          azkar.content ?? '',
                          style: TextStyle(
                            fontFamily: 'myarabic',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: azkar.count == 0
                                ? Colors.grey[700]
                                : Color.fromARGB(255, 241, 241, 238),
                          ),
                        ),
                        trailing: Text(
                          '${azkar.count}',
                          style: TextStyle(
                            fontSize: 16,
                            color: azkar.count == 0
                                ? Colors.grey[600]
                                : Colors.white,
                          ),
                        ),
                        subtitle: azkar.reward != null
                            ? Text(
                                'الأجر: ${azkar.reward}',
                                style: TextStyle(
                                  fontFamily: 'myarabic',
                                  fontSize: 16,
                                  color: azkar.count == 0
                                      ? Colors.grey[600]
                                      : Colors.grey[300],
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  /// Filter Azkar for the given subcategory
  List<Azkar> filteredAzkarForSubCategory(String subCategory) {
    // Filter logic for subCategory
    return [];
  }
}
