import 'package:agenda/src/features/service/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String serviceFirestoreCollection = 'service';

class ServiceRepository {
  final String uid;

  ServiceRepository(this.uid);
  static Future<void> create(String uid, ServiceModel m) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection(serviceFirestoreCollection)
        .add(m.toMap());
  }

  static Stream<List<ServiceModel>> readAll(String uid) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection(serviceFirestoreCollection)
        .snapshots()
        .map((q) => q.docs.map((e) => ServiceModel.fromMap(e.data())).toList());
  }

  @override
  Future<void> update(ServiceModel m) {
    // TODO: implement update
    throw UnimplementedError();
  }
}




// class MockServiceRepository implements IServiceRepository {
//     @override
//     Future<void> create(ServiceModel m) {
//         // TODO: implement create
//         throw UnimplementedError();
//     }
//     @override
//     Future<void> delete(String id) {
//         // TODO: implement delete
//         throw UnimplementedError();
//     }
//     @override
//     Future<ServiceModel> read(String id) {
//         // TODO: implement read
//         throw UnimplementedError();
//     }
//     @override
//     Future<void> update(ServiceModel m) {
//         // TODO: implement update
//         throw UnimplementedError();
//     }
// }