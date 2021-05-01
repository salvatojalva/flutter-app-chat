import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService{

  final _fireStore = FirebaseFirestore.instance;

  void save(String collectionName, Map< String, dynamic> collectionValues ) async{
    collectionValues['updated'] = DateTime.now().millisecondsSinceEpoch;
    _fireStore.collection(collectionName).add(collectionValues);
  }

  Future <QuerySnapshot> getMessage() async{
    return await _fireStore.collection("messages").get();
  }

  Stream <QuerySnapshot> getMessagesStream(){
    return _fireStore.collection("messages").snapshots();
  }

}