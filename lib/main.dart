import 'package:agenda/utils/navigator.dart';
import 'package:agenda/pages/calendar.dart';
import 'package:agenda/user_auth.dart';
import 'package:agenda/widgets/auth_popup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/create_calendar_data.dart';

//TODO: Testar se no celular ta criando toda hora o user anonimo

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(CalendarApp());
}

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final auth = UserAuth();

  @override
  void initState() {
    auth.fetchLogedUserId();
    super.initState();
  }

  @override
  void dispose() {
    auth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: auth.stream,
        builder: (context, snapshot) {
          // if (!snapshot.hasData) return Text('Verifique a internet');
          print(snapshot.data);
          if (snapshot.hasData && snapshot.data != null) {
            final uid = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        auth.signOut();
                      },
                      icon: Icon(Icons.exit_to_app)),
                  IconButton(
                    onPressed: () =>
                        push(context, CrateCalendarDataPage(uid: uid)),
                    icon: Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
              body: CalendarPage(uid: uid),
            );
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Entrar'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AuthPopUp(
                        auth: auth,
                      );
                    },
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AuthPopUp(
                        auth: auth,
                        login: false,
                      );
                    },
                  );
                },
                child: Text('Cadastrar'),
              )
            ],
          ));
        });
  }
}
