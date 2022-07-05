import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repositories/data_auth_repository.dart';
import '../../../data/utils/constants.dart';
import '../../components/ensure_focus.dart';
import '../../components/input_field.dart';
import '../../utils/constant.dart';
import 'login_controller.dart';

class LoginPage extends View {
  LoginPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends ViewState<LoginPage, LoginController> {
  static const String emailPrompt = 'Email Address';
  static const String passwordPrompt = 'Password';
  static const String loginButtonText = 'Sign In';
  static const String forgotPassswordButtonText = 'Forgot password?';
  static const String registerButtonText = 'No account? Create one.';

  final FocusNode _emailFocusNode;
  final FocusNode _passwordFocusNode;

  LoginPageState()
      : _emailFocusNode = FocusNode(),
        _passwordFocusNode = FocusNode(),
        super(LoginController(DataAuthRepository()));

  @override
  Widget get view {
    final controller = FlutterCleanArchitecture.getController<LoginController>(context);
    return Scaffold(
      key: globalKey,
      body: controller.isLoading ? const CircularProgressIndicator() : body,
    );
  }

  // Scaffold body
  Stack get body => Stack(
        children: <Widget>[
          background,
          ListView(
            physics: const PageScrollPhysics(),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ControlledWidgetBuilder(builder: (context, controller) {
                        num height = MediaQuery.of(context).size.height;
                        return Padding(
                          padding: EdgeInsets.only(top: height / 8, bottom: 10.0),
                          child: const Image(
                            image: AssetImage(Resources.logo),
                            width: 200.0,
                          ),
                        );
                      }),
                      const Text(
                        UIConstants.appName,
                        style: TextStyle(
                          color: Color.fromRGBO(230, 38, 39, 1.0),
                          fontSize: 32.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2.0,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        emailField,
                        passwordField,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[forgotPasswordButton],
                          ),
                        ),
                        Space.horizontalMedium,
                        loginButton,
                        Space.horizontalSmall,
                        registerButton
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  Widget get background => ControlledWidgetBuilder(
        builder: (context, controller) => Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            Resources.background,
            fit: BoxFit.cover,
          ),
        ),
      );

  // Fields and Buttons

  /// Email input field
  Widget get emailField => ControlledWidgetBuilder<LoginController>(
        builder: (context, controller) => EnsureVisibleWhenFocused(
          focusNode: _emailFocusNode,
          child: InputField(
            controller.emailTextController,
            emailPrompt,
            _emailFocusNode,
            type: TextInputType.emailAddress,
          ),
        ),
      );

  /// Password input field
  Widget get passwordField => ControlledWidgetBuilder<LoginController>(
        builder: (context, controller) => EnsureVisibleWhenFocused(
          focusNode: _passwordFocusNode,
          child: InputField(
            controller.passwordController,
            passwordPrompt,
            _passwordFocusNode,
            isPassword: true,
          ),
        ),
      );

  Widget get forgotPasswordButton => ControlledWidgetBuilder<LoginController>(
        builder: (context, controller) => GestureDetector(
          onTap: controller.forgotPassword,
          child: const Text(
            forgotPassswordButtonText,
            style: TextStyle(
              color: Color.fromRGBO(230, 38, 39, 0.8),
              fontSize: 14.0,
            ),
          ),
        ),
      );

  Widget get loginButton => ControlledWidgetBuilder<LoginController>(
        builder: (context, controller) => GestureDetector(
          onTap: () {
            controller.login();
          },
          child: Container(
            width: 320.0,
            height: 50.0,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(230, 38, 39, 1.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: const Text(loginButtonText, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300, letterSpacing: 0.4)),
          ),
        ),
      );

  Widget get registerButton => ControlledWidgetBuilder<LoginController>(
        builder: (context, controller) => GestureDetector(
          onTap: controller.register,
          child: const Text(
            registerButtonText,
            style: TextStyle(
              color: Color.fromRGBO(230, 38, 39, 0.8),
              fontSize: 14.0,
            ),
          ),
        ),
      );
}
