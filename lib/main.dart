import 'package:agenda/navigator.dart';
import 'package:agenda/pages/calendar.dart';
import 'package:agenda/services/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/create_calendar_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(CalendarApp());
}

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Agenda',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// The hove page which hosts the calendar
class MyHomePage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final String uid;
  late Stream<String> streamUid;
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      SharedLocalStorageService().get('uid').then((value) {
        if (value == null) {
          FirebaseAuth.instance.signInAnonymously();
          streamUid = Stream.fromFuture(
              FirebaseAuth.instance.signInAnonymously().then((value) {
            SharedLocalStorageService().put('uid', value);
            return value.user?.uid ?? '';
          }));
        } else {
          uid = value;
        }
      });
    } else
      uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => push(context, CrateCalendarDataPage(uid: uid)),
              icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<String>(
        stream: streamUid,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Text(
                  'Sem conexão com a internet! Tente novamente mais tarde'),
            );
          } else if (snapshot.data == null) {
            uid = snapshot.data!;
            return CalendarPage(uid: uid);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
