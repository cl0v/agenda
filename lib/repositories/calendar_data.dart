import 'package:agenda/models/calendar_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String calendarDataFirestoreCollection = 'calendarData';

abstract class ICalendarDataRepository {
  Future<void> create(CalendarDataModel m); // Ou id caso eu precise
  Stream<List<CalendarDataModel>> readAll(String id);
  Future<void> update(CalendarDataModel m);
  Future<void> delete(String id);
}

class CalendarDataRepository implements ICalendarDataRepository {
  @override
  Future<void> create(CalendarDataModel m) {
    return FirebaseFirestore.instance
        .collection(calendarDataFirestoreCollection)
        .add(m.toMap());
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<List<CalendarDataModel>> readAll(String id) {
    return FirebaseFirestore.instance
        .collection(calendarDataFirestoreCollection)
        .where('uid', isEqualTo: id)
        .snapshots()
        .map((q) =>
            q.docs.map((e) => CalendarDataModel.fromMap(e.data())).toList());
  }

  @override
  Future<void> update(CalendarDataModel m) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

class MockCalendarDataRepository implements ICalendarDataRepository {
  @override
  Future<void> create(CalendarDataModel m) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<List<CalendarDataModel>> readAll(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> update(CalendarDataModel m) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
