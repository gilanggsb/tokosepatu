import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokosepatu/models/message_model.dart';
import 'package:tokosepatu/models/product_model.dart';
import 'package:tokosepatu/models/user_model.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessagesByUserId({required int userId}) {
    try {
      return firestore
          .collection('messages')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
        print(list.docs.length);
        List<MessageModel> result =
            list.docs.map<MessageModel>((QueryDocumentSnapshot message) {
          print(message.data());
          // print('ini data ${message.data()}');
          return MessageModel.fromJson(message.data() as Map<String, dynamic>);
        }).toList();
        print('sebelum sort $result');
        result.sort((MessageModel a, MessageModel b) {
          print(a.message);
          return a.createdAt.compareTo(b.createdAt);
        });

        return result;
      });
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> addMessage(
      {required UserModel user,
      required bool isFromUser,
      required String message,
      required ProductModel product}) async {
    try {
      firestore.collection('messages').add({
        'userId': user.id,
        'userName': user.name,
        'userImage': user.profilePhotoUrl,
        'isFromUser': isFromUser,
        'message': message,
        'product': product is UnintializedProductModel ? {} : product.toJson(),
        'createdAt': DateTime.now().toString(),
        'updatedAt': DateTime.now().toString(),
      }).then(
        (value) => print('Pesan Berhasil Dikirim!'),
      );
    } catch (e) {
      print(e);
      throw Exception('Pesan Gagal Dikirim');
    }
  }
}
