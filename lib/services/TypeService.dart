import 'package:cloud_firestore/cloud_firestore.dart';

class TypeService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<String>> getAllTypes() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('Type').get();
      List<String> types = querySnapshot.docs.map((doc) {
        return doc['typeName'] as String;
      }).toList();

      return types;
    } catch (e) {
      print('Error fetching types: $e');
      return [];
    }
  }

}
