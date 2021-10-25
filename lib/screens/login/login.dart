import 'package:chat_app_bloc/bloc/authentication/authentication_bloc.dart';
import 'package:chat_app_bloc/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        children: const [
                          Text('Logging failure ...'),
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      backgroundColor: const Color(0xffffae88),
                    ),
                  );
              }
              if (state is LoginSuccess) {
                context.read<AuthenticationBloc>().add(AuthenticationLoaded());
              }
            },
            child: Form(
              child: Column(
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<LoginBloc>().add(LoggedInWithGoogle());
                    },
                    label: const Text('Sign up with Google'),
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      minimumSize: const Size(double.infinity, 50.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
