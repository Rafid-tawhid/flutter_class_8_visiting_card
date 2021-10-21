
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiting_card_contact_class5/custom_widget/contact_row_item.dart';
import 'package:visiting_card_contact_class5/custom_widget/sqlite_helper.dart';

import 'package:visiting_card_contact_class5/models/contact_model.dart';
import 'package:visiting_card_contact_class5/pages/new_contact_page.dart';
import 'package:visiting_card_contact_class5/pages/scan_page.dart';
import 'package:visiting_card_contact_class5/provider/contact_provider.dart';

class ContactListPage extends StatefulWidget {

  static const String routeName='/';

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {

  late ContactProvider _provider;

  @override
  void didChangeDependencies() {

    _provider= Provider.of<ContactProvider>(context);
    _provider.getAllContacts();
    super.didChangeDependencies();
  }
  // void _refresh()
  // {
  //   setState(() {
  //
  //   });
  // }
  // @override
  // void initState() {
  //   SQliteHelper.getAllContacts().then((value) => contactList=value);
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Contact List"),),
      body:Center(
        child: _provider.contactList.isEmpty ? CircularProgressIndicator():
        ListView.builder(
          itemCount: _provider.contactList.length,
          itemBuilder: (context, index) {
            final contacts = _provider.contactList[index];
            return ContactRowItem(contacts);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
         final status= await Navigator.pushNamed(context, ScanPage.routeName);
         print('something');
         // if(status != null)
         //   {
         //     if(status is bool)
         //       {
         //         setState(() {
         //
         //         });
         //       }
         //   }

        },
        child: Icon(Icons.add),

      ),
    );
  }
}
