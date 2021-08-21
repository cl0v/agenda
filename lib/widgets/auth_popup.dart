import 'package:agenda/utils/navigator.dart';
import 'package:flutter/material.dart';

import '../user_auth.dart';

class AuthPopUp extends StatelessWidget {
  AuthPopUp({
    Key? key,
    this.login = true,
    required this.auth,
  }) : super(key: key);

  final bool login;
  final UserAuth auth;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController(text: 'marcelo@email.com');
  final TextEditingController senhaController =
      TextEditingController(text: 'marcelo@email.com');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        children: <Widget>[
          Positioned(
              right: -40.0,
              top: -40.0,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close))),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: senhaController,
                    decoration: InputDecoration(labelText: 'Senha'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Conectar"),
                    onPressed: () async {
                      login
                          ? await auth.login(
                              emailController.text, senhaController.text)
                          : await auth.create(
                              emailController.text, senhaController.text);
                      pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
