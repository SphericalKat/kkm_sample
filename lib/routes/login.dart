import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../models/login/login_request.dart';
import '../stores/login_store.dart';
import '../utils/device_info.dart';
import '../utils/ui.dart';

class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final LoginStore store = LoginStore();

  @override
  void initState() {
    super.initState();
    store.setupValidations(context);
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Observer(
                builder: (_) => TextField(
                  onChanged: (value) => store.username = value,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    errorText: store.error.username,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Observer(
                builder: (_) => TextField(
                  obscureText: true,
                  onChanged: (value) => store.password = value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    errorText: store.error.password,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Observer(
                builder: (_) => ElevatedButton(
                  onPressed: () async {
                    store.validateAll();
                    if (store.canLogin) {
                      try {
                        final deviceInfo = await getDeviceId();
                        final loginRequest = LoginRequest(
                          username: store.username,
                          password: store.password,
                          deviceId: deviceInfo.item1,
                          deviceName: deviceInfo.item2,
                        );

                        store.login(loginRequest);
                      } catch (e) {
                        showSnackBar(
                            context, 'Something went wrong, please try again!');
                      }
                    } else {
                      showSnackBar(context,
                          'Fix the errors in the form before proceeding!');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  child: store.isLoading
                      ? const SizedBox(
                          height: 12,
                          width: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      : const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
