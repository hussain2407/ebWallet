import 'package:cloud_firestore/cloud_firestore.dart';

class Resturant {
  String id;
  String name;
  String telephone;

  Resturant({this.id, this.name, this.telephone });
  Resturant.fromDocument(DocumentSnapshot doc) {
    if (doc.exists) {
      this.id = doc.documentID;
      this.name = doc.data["name"];
      this.telephone = doc.data['telephone'];
    }
  }
  toJson() {
    return {
      "name": name,
      "telephone": telephone,
    };
  }
  @override
    String toString() {
      return "name :$name id:$id";
    }
}
