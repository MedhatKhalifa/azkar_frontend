import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wazker/pages/common_widget/thedrawer.dart';
import '../controllers/azkar_controller.dart';
import 'AzkarListPage.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({super.key});

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

final AzkarController controller = Get.put(AzkarController());

class _SubCategoryPageState extends State<SubCategoryPage> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false; // State to toggle between title and search bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 43, 22),
        title: isSearching
            ? TextField(
                controller: searchController,
                textDirection: TextDirection.rtl,
                onChanged: (query) {
                  controller.performSearchSubCategory(query);
                },
                style: const TextStyle(
                  fontFamily: 'sebhafont',
                  fontSize: 20,
                  color: Colors.black, // Text color set to black
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white, // Background color set to white
                  hintText: 'بحث...',
                  hintStyle: TextStyle(
                    fontFamily: 'sebhafont',
                    fontSize: 18,
                    color: Colors.grey[600], // Slightly darker hint text
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    borderSide: const BorderSide(
                      color: Colors.grey, // Border color
                      width: 1, // Border width
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey, // Border color for enabled state
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color:
                          Color(0xFFDAA520), // Border color for focused state
                      width: 2, // Slightly thicker border
                    ),
                  ),
                ),
              )
            : const Text(
                'أحوال الأذكار',
                style: TextStyle(
                  fontFamily: 'sebhafont',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDAA520),
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.grey[300],
            ),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear(); // Clear search bar
                  controller.performSearchSubCategory(''); // Reset search
                }
                isSearching = !isSearching; // Toggle search mode
              });
            },
          ),
        ],
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      backgroundColor: Color.fromARGB(255, 194, 218, 200),
      body: Obx(() {
        if (controller.uniqueShowedSubCategories.isEmpty) {
          return Center(
            child: Text(
              'لا توجد نتائج مطابقة.',
              style: TextStyle(
                fontFamily: 'sebhafont',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.uniqueShowedSubCategories.length,
            itemBuilder: (context, index) {
              final subCategory = controller.uniqueShowedSubCategories[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                color: Color.fromARGB(255, 22, 43, 22),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  title: Text(
                    subCategory,
                    style: TextStyle(
                      fontFamily: 'sebhafont',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 240, 245, 244),
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: const Color.fromARGB(255, 240, 245, 244),
                  ),
                  onTap: () {
                    controller.azkarBySubCategory(subCategory);
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }

  /// Show Search Dialog
  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'بحث',
            style: TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: searchController,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'أدخل كلمة البحث...',
              hintStyle: TextStyle(fontFamily: 'AmiriQuran'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          actions: [
            // Search Button
            TextButton(
              onPressed: () {
                final query = searchController.text.trim(); // Get input
                if (query.isNotEmpty) {
                  performSearch(query); // Perform the search
                  // Navigator.pop(context); // Close dialog
                } else {
                  // Show a snackbar or message if the input is empty
                  Get.snackbar(
                    'خطأ',
                    'يرجى إدخال كلمة للبحث.',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text(
                'بحث',
                style: TextStyle(
                  fontFamily: 'AmiriQuran',
                  color: Colors.teal,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context); // Close dialog without performing search
              },
              child: Text(
                'إلغاء',
                style: TextStyle(
                  fontFamily: 'AmiriQuran',
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Perform Search
  void performSearch(String query) {
    if (query.isEmpty) {
      // Show a message if no query is entered
      Get.snackbar(
        'خطأ',
        'يرجى إدخال كلمة للبحث.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Normalize Arabic text for better matching
    final normalizedQuery = normalizeArabic(query);

    // Filter Azkar that match content, reward, or subCategory
    final matchingAzkar = controller.azkarList.where((azkar) {
      final normalizedContent = normalizeArabic(azkar.content ?? '');
      final normalizedReward = normalizeArabic(azkar.reward ?? '');
      final normalizedSubCategory = normalizeArabic(azkar.subCategory ?? '');

      return normalizedContent.contains(normalizedQuery) ||
          normalizedReward.contains(normalizedQuery) ||
          normalizedSubCategory.contains(normalizedQuery);
    }).toList();

    // Check if there are results
    if (matchingAzkar.isEmpty) {
      // Show a message if no matches are found
      Get.snackbar(
        'نتائج البحث',
        'لا توجد نتائج مطابقة.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Navigate to AzkarListPage with matching Azkar
      Get.to(AzkarListPage(
        matchingAzkar: matchingAzkar,
        isSearchResult: true,
      ));
      print('Test');
    }
  }

  String normalizeArabic(String text) {
    if (text.isEmpty) return text;

    return text
        // Replace common variations
        .replaceAll(RegExp(r'[أإآ]', caseSensitive: false),
            'ا') // Replace أ, إ, آ with ا
        .replaceAll('ى', 'ي') // Replace ى with ي
        .replaceAll('ة', 'ه') // Replace ة with ه

        // Remove diacritics
        .replaceAll(RegExp(r'[ًٌٍَُِّْ]'), '')

        // Remove Tatweel (ــ)
        .replaceAll('ـ', '')

        // Handle extra spaces
        .replaceAll(
            RegExp(r'\s+'), ' ') // Replace multiple spaces with a single space
        .trim(); // Remove leading/trailing spaces
  }
}
