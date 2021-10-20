
import 'package:flutter/material.dart';
import 'package:visiting_card_contact_class5/custom_widget/contact_row_item.dart';
import 'package:visiting_card_contact_class5/custom_widget/sqlite_helper.dart';

import 'package:visiting_card_contact_class5/models/contact_model.dart';
import 'package:visiting_card_contact_class5/pages/new_contact_page.dart';
import 'package:visiting_card_contact_class5/pages/scan_page.dart';

class ContactListPage extends StatefulWidget {

  static const String routeName='/';

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {

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
      body:FutureBuilder<List<ContactModel>>(
        future: SQliteHelper.getAllContacts(),
        builder: (context,snapshot){
          if(snapshot.hasData) {
            final contactList=snapshot.data!;
            return ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                final contacts = contactList[index];
                return ContactRowItem(contacts);
              },
            );
          }
          if(snapshot.hasError)
            {
              return Center(child: Text("Error to load Data"));
            }

          return Center(child: CircularProgressIndicator());

        },
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
