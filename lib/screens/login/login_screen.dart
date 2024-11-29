import 'package:engineer/app_router.dart';
import 'package:engineer/services/authenticate_api.dart';
import 'package:engineer/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  AuthenticateApi authenticateApi = AuthenticateApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset("assets/images/main_top.png", width: 120),
            ),
            SafeArea(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "login".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 8,
                            child: SvgPicture.asset(
                              "assets/icons/Tablet login-amico.svg",
                              height: 320.0,
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding * 2,
                      )
                    ],
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding * 2),
                          child: TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: primary,
                            onSaved: (newValue) {},
                            decoration: const InputDecoration(
                                hintText: "Your username",
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Icon(Icons.person)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(36.0)),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding,
                              horizontal: defaultPadding * 2),
                          child: TextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            cursorColor: primary,
                            decoration: const InputDecoration(
                              hintText: "Your password",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(defaultPadding),
                                child: Icon(Icons.lock),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(36.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              String username = usernameController.text;
                              String password = passwordController.text;
                              if (username.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please fill all fields')));
                              } else {
                                var user = await authenticateApi.login(
                                    username, password);
                                if (user.employeeCode != 0) {
                                  Navigator.pushNamed(context, AppRouter.home);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Login failed')));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              shadowColor: primaryDark,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36.0)),
                              minimumSize: const Size(380, 50),
                            ),
                            child: Text(
                              "login".toUpperCase(),
                              style: const TextStyle(color: icons),
                            )),
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Don’t have an Account ? ",
                              style: TextStyle(color: primary, fontSize: 16.0),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ])),
    );
  }
}
