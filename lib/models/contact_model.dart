const String tblContact='table_contact';
const String tblContactColId='id';
const String tblContactColName='name';
const String tblContactColCompany='company';
const String tblContactColDesignation='designation';
const String tblContactColAddress='address';
const String tblContactColEmail='email';
const String tblContactColMobile='mobile';
const String tblContactColWeb='website';
const String tblContactColFav='favorite';

class ContactModel {
  int? id;
  String name;
  String companyName;
  String designation;
  String address;
  String mobile;
  String email;
  String website;
  bool isFav;

  ContactModel(
      {this.id,
      this.name='',
      this.companyName='',
      this.designation='',
      this.address='',
      this.mobile='',
      this.email='',
      this.website='',
      this.isFav=false});

  Map<String,dynamic> toMap() //key and value
  {

    var map=<String,dynamic>{
      tblContactColName:name,
      tblContactColCompany:companyName,
      tblContactColDesignation:designation,
      tblContactColAddress:address,
      tblContactColEmail:email,
      tblContactColMobile:mobile,
      tblContactColWeb:website,
      tblContactColFav:isFav ? 1:0,
    };
    if(id!=null)
      {
        map[tblContactColId]=id;
      }
    return map;
  }

  factory ContactModel.fromMap(Map<String,dynamic> map) =>ContactModel(
    id: map[tblContactColId],
    name: map[tblContactColName],
    companyName: map[tblContactColCompany],
    designation: map[tblContactColDesignation],
    address: map[tblContactColAddress],
    mobile: map[tblContactColMobile],
    email: map[tblContactColEmail],
    website: map[tblContactColWeb],
    isFav: map[tblContactColFav] ==0?false:true,
  );


  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, companyName: $companyName, designation: $designation, address: $address, mobile: $mobile, email: $email, website: $website, isFav: $isFav}';
  }
}
