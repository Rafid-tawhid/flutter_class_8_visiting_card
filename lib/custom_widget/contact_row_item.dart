import 'package:flutter/material.dart';
import 'package:visiting_card_contact_class5/custom_widget/sqlite_helper.dart';
import 'package:visiting_card_contact_class5/models/contact_model.dart';
import 'package:visiting_card_contact_class5/pages/contact_details_page.dart';

class ContactRowItem extends StatefulWidget {
  final ContactModel contact;

  ContactRowItem(this.contact);

  @override
  _ContactRowItemState createState() => _ContactRowItemState();
}

class _ContactRowItemState extends State<ContactRowItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.grey,
          alignment: Alignment.centerRight,
          child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
            Icons.delete,
            color: Colors.white60,
          ),
              )),
        ),
        confirmDismiss: _confirmDelete,
        child: Card(
          elevation: 5,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, ContactDetails.routeName,
                  arguments: widget.contact.id);
            },
            title: Text(widget.contact.name),
            tileColor: Colors.white,
            subtitle: Text(widget.contact.designation),
            leading: CircleAvatar(),
            trailing: IconButton(
              icon: Icon(
                widget.contact.isFav
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                color: Colors.red,
              ),
              onPressed: () {
                final value = widget.contact.isFav ? 0 : 1;
                SQliteHelper.updateContactFavourite(widget.contact.id!, value)
                    .then((_) {
                  setState(() {
                    widget.contact.isFav = !widget.contact.isFav;
                  });
                });
                // widget.refreshCallback();
              },
            ),
          ),
        ),
      ),
    );
  }
  Future<bool?> _confirmDelete(DismissDirection direction)
  {
    return showDialog(barrierDismissible: false, context: context, builder: (context)=> AlertDialog(
      title: Text("Delete ${widget.contact.name}?"),
      content: Text('Are you Sure to delete??'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context,false);
        }, child: Text('NO')),
        ElevatedButton(onPressed: (){
          Navigator.pop(context,true);
          SQliteHelper.deleteContactById(widget.contact.id!);
        }, child: Text('YES')),

      ],
    ));
  }
}
