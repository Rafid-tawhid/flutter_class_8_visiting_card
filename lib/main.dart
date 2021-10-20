import 'package:flutter/material.dart';
import 'package:visiting_card_contact_class5/pages/contact_details_page.dart';
import 'package:visiting_card_contact_class5/pages/contact_list_page.dart';
import 'package:visiting_card_contact_class5/pages/new_contact_page.dart';
import 'package:visiting_card_contact_class5/pages/scan_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactListPage.routeName,
      routes: {
        ContactListPage.routeName:(context)=>ContactListPage(),
        NewContactPage.routeName:(context)=>NewContactPage(),
        ContactDetails.routeName:(context)=>ContactDetails(),
        ScanPage.routeName:(context)=>ScanPage(),
      },
    );
  }
}


