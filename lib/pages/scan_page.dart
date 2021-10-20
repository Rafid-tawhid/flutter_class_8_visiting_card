import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visiting_card_contact_class5/models/contact_model.dart';
import 'package:visiting_card_contact_class5/pages/new_contact_page.dart';
import 'package:visiting_card_contact_class5/utils/utils.dart';
List<String> _margeLineList=[];
class ScanPage extends StatefulWidget {
  static const String routeName='/scan_page';


  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final _contactModel=ContactModel();

  List <String> _linesS=[];
  ImageSource _imageSource=ImageSource.camera;
  String? _imgPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Visiting Card"),
        actions: [
          TextButton(onPressed: (){
            print(_contactModel);
            Navigator.pushReplacementNamed(context, NewContactPage.routeName,arguments: _contactModel);
          }, child: Text("Next",style: TextStyle(color: Colors.white),),)
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey,width: 2),
              ),
              child: _imgPath==null ?null:Image.file(File(_imgPath!),fit: BoxFit.cover,),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                _imageSource=ImageSource.camera;
                _pickImage();
              }, child: Text("Camera")),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: (){
                _imageSource=ImageSource.gallery;
                _pickImage();
              }, child: Text("Gallery")),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder( itemCount: _linesS.length,
                itemBuilder: (context,index) => LineItems(_linesS[index])),
          ),
          SizedBox(
            height: 40,
            width: double.maxFinite,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _propertyButtons(ContactProperties.name),
                _propertyButtons(ContactProperties.company),
                _propertyButtons(ContactProperties.designation),
                _propertyButtons(ContactProperties.address),
                _propertyButtons(ContactProperties.mobile),
                _propertyButtons(ContactProperties.email),
                _propertyButtons(ContactProperties.web),


              ],
            ),
          )
        ],
      ),
    );


  }
  Widget _propertyButtons(String property)
  {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton(onPressed: (){
        _assignValuesToContactModel(property);
      }, child: Text(property)),
    );
  }

  void _pickImage() async {
    final pickedFile=await ImagePicker().pickImage(source: _imageSource);
    setState(() {
      _imgPath=pickedFile!.path;
    });

    final testDetector=GoogleMlKit.vision.textDetector();
    final inputImage=InputImage.fromFilePath(_imgPath!);
   final recognisedText= await testDetector.processImage(inputImage);
   print("This is text :"+recognisedText.text);
   var lines=<String>[];
   for(var block in recognisedText.blocks)
     {
       for(var line in block.lines)
         {
           lines.add(line.text);
         }
     }
   setState(() {
     _linesS=lines;
   });

  }

  void _assignValuesToContactModel(String property) {

    final item=_margeLineList.join(' ');
    switch(property)
    {
      case ContactProperties.name:
        _contactModel.name=item;
        break;
      case ContactProperties.designation:
        _contactModel.designation=item;
        break;
      case ContactProperties.company:
        _contactModel.companyName=item;
        break;
      case ContactProperties.address:
        _contactModel.address=item;
        break;
      case ContactProperties.mobile:
        _contactModel.mobile=item;
        break;
      case ContactProperties.email:
        _contactModel.email=item;
        break;
      case ContactProperties.web:
        _contactModel.website=item;
        break;
    }
    _margeLineList.clear();
  }
}

class LineItems extends StatefulWidget {

  final String line;

  LineItems(this.line);

  @override
  State<LineItems> createState() => _LineItemsState();
}

class _LineItemsState extends State<LineItems> {
  bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
              title: Text(widget.line),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (value)
        {
          setState(() {
            isChecked=value!;

          });
         value! ? _margeLineList.add(widget.line):_margeLineList.remove(widget.line);
        },
      ),
            );
  }
}
