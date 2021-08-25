import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

const String appointmentFirestoreCollection = 'appointment';

// abstract class IAppointmentRepository {
//          Future<void> create(StringAppointment m); // Ou id caso eu precise
//          Future<Appointment> read(String id);
//          Future<void> update(Appointment m);
//          Future<void> delete(String id);
// }

class AppointmentRepository {
  @override
  static Future<void> create(String userId, Appointment m) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .collection(appointmentFirestoreCollection)
        .add(m.toMap());
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Appointment> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> update(Appointment m) {
    // TODO: implement update
    throw UnimplementedError();
  }
}




// class MockAppointmentRepository implements IAppointmentRepository {
//     @override
//     Future<void> create(Appointment m) {
//         // TODO: implement create
//         throw UnimplementedError();
//     }
//     @override
//     Future<void> delete(String id) {
//         // TODO: implement delete
//         throw UnimplementedError();
//     }
//     @override
//     Future<Appointment> read(String id) {
//         // TODO: implement read
//         throw UnimplementedError();
//     }
//     @override
//     Future<void> update(Appointment m) {
//         // TODO: implement update
//         throw UnimplementedError();
//     }
// }