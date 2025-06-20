import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplier_connect_flutter/providers/supplier_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/my_textbox.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final __loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade100,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Supplier Connect",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                        child: Form(
                          key: __loginFormKey,
                          child: Column(
                            children: [
                              MyTextBox(controller: email, text: "Email"),
                              const SizedBox(height: 10),
                              MyTextBox(
                                  controller: password,
                                  text: "Password",
                                  isPassword: true),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                // child: ElevatedButton(
                                //   onPressed: () {
                                //     // Navigator.pushNamed(context, '/signup');
                                //     // Navigator.pushNamed(
                                //     //     context, HomeScreen.routeName);
                                //     Provider.of<SupplierProvider>(context,
                                //             listen: false)
                                //         .fetchSuppliers();
                                //   },
                                //   style: ElevatedButton.styleFrom(
                                //     foregroundColor: Colors.white,
                                //     backgroundColor: Colors.blue.shade400,
                                //     padding: const EdgeInsets.all(13),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(25),
                                //     ),
                                //   ),
                                //   child: const Text(
                                //     'Login',
                                //     style: TextStyle(
                                //       fontFamily: 'OpenSans',
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (__loginFormKey.currentState!
                                        .validate()) {
                                      final authProvider =
                                          Provider.of<AuthProvider>(context,
                                              listen: false);

                                      bool success = await authProvider.login(
                                          email.text.trim(),
                                          password.text.trim());

                                      if (success) {
                                        context.go('/suppliers');
                                      } else {
                                        // ⚡️ Show error
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Invalid email or password!')),
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue.shade400,
                                    padding: const EdgeInsets.all(13),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // child: ElevatedButton(
                                //   bColor: Theme.of(context).primaryColor,
                                //   buttonText: "LOGIN",
                                //   onclick: () {},
                                //   mfontSize: 15,
                                // ),
                                // child: Text("Login panra"),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, SignUpScreen.routeName);
                                  },
                                  child: Text(
                                    "I don't have an account",
                                    style: TextStyle(
                                      color: Colors
                                          .blue, // or any other color you prefer
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
