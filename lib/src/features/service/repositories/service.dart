import 'package:agenda/src/features/service/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String serviceFirestoreCollection = 'service';

abstract class IServiceRepository {
  Future<void> create(ServiceModel m); // Ou id caso eu precise
  Stream<List<ServiceModel>> read(String id);
  Future<void> update(ServiceModel m);
  Future<void> delete(String id);
}

class ServiceRepository {
  final String uid;

  ServiceRepository(this.uid);
  @override
  Future<void> create(ServiceModel m) {
    return FirebaseFirestore.instance
        .collection(serviceFirestoreCollection)
        .add(m.toMap()..addEntries([MapEntry('uid', uid)]));
  }

  @override
  Future<void> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<ServiceModel>> read() {
    return FirebaseFirestore.instance
        .collection(serviceFirestoreCollection)
        .where('uid', isEqualTo: uid)
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