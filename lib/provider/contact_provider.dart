import 'package:flutter/foundation.dart';
import 'package:visiting_card_contact_class5/custom_widget/sqlite_helper.dart';
import 'package:visiting_card_contact_class5/models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList=[];

  void getAllContacts() async
  {
    contactList=await SQliteHelper.getAllContacts();
    notifyListeners();
  }

  Future<int> addNewContact(ContactModel contactModel) async{
    return await SQliteHelper.insertNewContact(contactModel);
  }
}