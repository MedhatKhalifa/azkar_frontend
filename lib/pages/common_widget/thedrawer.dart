import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wazker/pages/actions/historyActions.dart';
import 'package:wazker/pages/subCategory.dart';
import 'package:wazker/translation/translation_page.dart';

import '../actions/viewTodayActions.dart';
import '../azkar_search.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Center(
              child: Text(
                'ًWazker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Azkar'),
            onTap: () {
              Get.to(() => SubCategoryPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.call_to_action),
            title: Text('Actions'),
            onTap: () {
              Get.to(
                () => LargeFormScreen(
                  selectedDate: DateTime.now(), // Pass the desired date here
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History Action'),
            onTap: () {
              Get.to(() => CalendarScreen());
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.favorite),
          //   title: Text('Tasbeeh'),
          //   onTap: () {},
          // ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () {
              Get.to(() => AzkarSearchPage());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Change Language'),
            onTap: () {
              Get.to(() => TrnaslationPage());
              ;
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.color_lens),
          //   title: Text('Change Theme'),
          //   onTap: () {},
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.web),
          //   title: Text('Islamic Websites & Apps'),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/websites');
          //   },
          // ),
        ],
      ),
    );
  }
}
