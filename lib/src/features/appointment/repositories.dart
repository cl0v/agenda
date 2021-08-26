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
  static Future<void> create(String uid, Appointment m) {
    //TODO: Adicionar uma collection do dia, que auxiliará na leitura(Evitar multiplas leituras para uma unica página) Basta ordenar pelo dia
    return FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection(appointmentFirestoreCollection)
        .add(m.toMap());
  }

  static Stream<List<Appointment>> todayAppointments(String uid) {
    //TODO: Trocar isso para stream
    return FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection(appointmentFirestoreCollection)
        .where('date.day', isEqualTo: DateTime.now().day)
        .where('date.month', isEqualTo: DateTime.now().month)
        .where('date.year', isEqualTo: DateTime.now().year)
        .snapshots()
        .map((event) => event.docs.map((e) => Appointment.fromMap(e.data())).toList());
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