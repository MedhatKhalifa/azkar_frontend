import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/azkar_controller.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  final AzkarController controller = Get.put(AzkarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'أذكاري',
          style: TextStyle(
            fontFamily: 'AmiriQuran', // Arabic font
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          DropdownButton<String>(
            value: controller.selectedLanguage.value,
            onChanged: (value) {
              if (value != null) controller.changeLanguage(value);
            },
            underline: SizedBox(), // Removes the underline from the dropdown
            icon: Icon(Icons.language, color: Colors.white),
            dropdownColor: Colors.teal,
            items: SUPPORTED_LANGUAGES.map((lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(
                  lang == 'ar' ? 'عربي' : 'English',
                  style: TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.filteredAzkar.isEmpty) {
          return Center(
            child: Text(
              NO_AZKAR_MESSAGE,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'AmiriQuran', // Arabic font
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.filteredAzkar.length,
            itemBuilder: (context, index) {
              var azkar = controller.filteredAzkar[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  tileColor: Colors.teal[50],
                  title: Text(
                    azkar.content ?? 'Azkar',
                    style: TextStyle(
                      fontFamily: 'AmiriQuran', // Arabic font
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                  subtitle: Text(
                    azkar.category ?? '',
                    style: TextStyle(
                      fontFamily: 'AmiriQuran',
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.teal[700],
                  ),
                  onTap: () {
                    Get.toNamed('/azkar_details', arguments: azkar);
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
