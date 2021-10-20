import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visiting_card_contact_class5/custom_widget/sqlite_helper.dart';
import 'package:visiting_card_contact_class5/models/contact_model.dart';
import 'package:visiting_card_contact_class5/utils/helper_function.dart';
import 'package:visiting_card_contact_class5/utils/utils.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName='/new_contact';


  @override
  _NewContactPageState createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final _nameControler=TextEditingController();
  final _designationControler=TextEditingController();
  final _addressControler=TextEditingController();
  final _mailControler=TextEditingController();
  final _phoneControler=TextEditingController();
  final _webControler=TextEditingController();
  final _companyControler=TextEditingController();
  final _fromKey=GlobalKey<FormState>();

  @override
  void didChangeDependencies() {

    final contact=ModalRoute.of(context)!.settings.arguments as ContactModel;
    _setPropertiesToTextField(contact);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameControler.dispose();
    _designationControler.dispose();
    _addressControler.dispose();
    _mailControler.dispose();
    _phoneControler.dispose();
    _webControler.dispose();
    _companyControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Contact"),
        actions: [
          IconButton(onPressed: _saveContact, icon: Icon(Icons.save)),

        ],
      ),
      
      body: Form(
        key: _fromKey,
        child: ListView(
          padding: EdgeInsets.all(8),
          children: [
            TextFormField(
              controller: _nameControler,
              decoration: InputDecoration(
                labelText: "Contact Name",

                prefixIcon: Icon(Icons.person),
              ),
              validator: (value)
              {
                if(value==null||value.isEmpty)
                  {
                    return msg;
                  }

                    return null;

              },

            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: _designationControler,
              decoration: InputDecoration(
                labelText: "Designation",

                prefixIcon: Icon(Icons.person),
              ),
              validator: (value)
              {
                if(value==null||value.isEmpty)
                {
                  return msg;
                }

                return null;

              },

            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: _companyControler,
              decoration: InputDecoration(
                labelText: "Coompany Name",

                prefixIcon: Icon(Icons.person),
              ),
              validator: (value)
              {
                if(value==null||value.isEmpty)
                {
                  return msg;
                }

                return null;

              },

            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: _mailControler,
              decoration: InputDecoration(
                labelText: "E-mail",

                prefixIcon: Icon(Icons.person),
              ),
              validator: (value)
              {
                if(value==null||value.isEmpty)
                {
                  return msg;
                }

                return null;

              },

            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: _phoneControler,
              decoration: InputDecoration(
                labelText: "Phone No",

                prefixIcon: Icon(Icons.person),
              ),
              validator: (value)
              {
                if(value==null||value.isEmpty)
                {
                  return msg;
                }

                return null;

              },

            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: _webControler,
              decoration: InputDecoration(
                labelText: "Website",

                prefixIcon: Icon(Icons.person),
              ),
              validator: (value)
              {
                if(value==null||value.isEmpty)
                {
                  return msg;
                }

                return null;

              },

            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: _addressControler,
              decoration: InputDecoration(
                labelText: "Address",

                prefixIcon: Icon(Icons.person),
              ),
              validator: (value)
              {
                if(value==null||value.isEmpty)
                {
                  return msg;
                }

                return null;

              },

            ),
            
          ],
        ),
      ),
    );
  }

  void _saveContact() async {

    if(_fromKey.currentState!.validate())
      {
        final contact =ContactModel(
          name: _nameControler.text,
          companyName: _companyControler.text,
          designation: _designationControler.text,
          address: _addressControler.text,
          mobile: _phoneControler.text,
          email: _mailControler.text,
          website: _webControler.text
        );
        // ignore: avoid_print
        print(contact);

        // contactList.add(contact);
      final rowId= await SQliteHelper.insertNewContact(contact);
      if(rowId>0)
        {
          Navigator.pop(context,true);
        }
      else{
        showMessage(context, "Failed to Save");
      }

      }
  }

  void _setPropertiesToTextField(ContactModel contact) {
    setState(() {
      _nameControler.text=contact.name;
      _designationControler.text=contact.designation;
      _companyControler.text=contact.companyName;
      _addressControler.text=contact.address;
      _phoneControler.text=contact.mobile;
      _mailControler.text=contact.email;
      _webControler.text=contact.website;
    });
  }
}
