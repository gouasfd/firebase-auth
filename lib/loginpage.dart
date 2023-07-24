import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginepage/texts.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _abscure = true;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  void changescure() {
    setState(() {
      _abscure = !_abscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          color: const Color.fromRGBO(214, 238, 39, 1),
                          child: const Center(
                              child: Icon(Icons.star_outline_sharp))),
                      Creattext(text: 'Welcom back'),
                      Creattext(
                        text:
                            'we happy to see you again ,enter your email and password',
                        big: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _email,
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          label: Text('email'),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 10),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _password,
                        autocorrect: false,
                        obscureText: _abscure,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                changescure();
                              },
                              icon: Icon(Icons.password)),
                          label: Text('password'),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 10),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              backgroundColor:
                                  const Color.fromRGBO(214, 238, 39, 1),
                            ),
                            onPressed: () async {
                              final email = _email.text.trim();
                              final password = _password.text.trim();
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: password);
                                Navigator.pushNamed(context, 'result');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          'The operation is successful',
                                        )));
                              } on Exception catch (e) {
                                String errorMessage = 'An error occurred';
                                if (e is FirebaseAuthException) {
                                  if (e.code == 'user-not-found') {
                                    errorMessage = 'User not found';
                                  } else if (e.code == 'wrong-password') {
                                    errorMessage = 'Invalid password';
                                  } else {
                                    errorMessage = e
                                        .message!; // Use the general error message
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                          errorMessage,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: Colors.red),
                                  );
                                }
                                // TODO
                              }
                            },
                            child: Creattext(text: 'log in ')),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Creattext(
                          text: '-------------------or------------------',
                          big: false,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'sign in', (route) => false);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'creat an acount',
                                style: GoogleFonts.outfit(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]))));
  }
}
