import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visiting_card_contact_class5/custom_widget/sqlite_helper.dart';
import 'package:visiting_card_contact_class5/models/contact_model.dart';
import 'package:visiting_card_contact_class5/utils/helper_function.dart';

class ContactDetails extends StatefulWidget {
  static const String routeName = '/details';

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  int? id;
  bool _isLoading = true;
  late ContactModel _contactModel;
  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int;
    SQliteHelper.getContactById(id!).then((contact) {
      _contactModel = contact;
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final contact=ModalRoute.of(context)!.settings.arguments as ContactModel;
    // print(contact.name);
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                 Card(
                   elevation: 5,
                   child:  ListTile(
                     title: Text(_contactModel.name),
                     subtitle: Text(_contactModel.designation),
                   ),
                 ),
                  Card(
                    elevation: 5,
                    child:  ListTile(
                      title: Text(_contactModel.mobile),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: _callNumber, icon: Icon(Icons.call)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.sms)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child:  ListTile(
                      title: Text(_contactModel.email),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.mail)),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child:  ListTile(
                      title: Text(_contactModel.address),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.location_on)),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child:  ListTile(
                      title: Text(_contactModel.website),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.airplanemode_on_outlined)),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
  void _callNumber() async {

    final uri='tel:${_contactModel.mobile}';
    if(await canLaunch(uri))
      {
       await launch(uri);
      }
    else
      {
        showMessage(context, 'Sorry Cant Lounch');
      }


}
}


