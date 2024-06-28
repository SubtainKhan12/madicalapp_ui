import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintScreen extends StatefulWidget {
  const FingerprintScreen({super.key});

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isauthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fingerprint Screen'),
        backgroundColor: Colors.blue,
      ),
      body: _BuildUI(),
      floatingActionButton: _authButton(),
    );
  }

  Widget _authButton() {
    return FloatingActionButton(
      onPressed: () async {
        if (!_isauthenticated) {
          final bool canAuthenticateWithBiometrics =
              await _auth.canCheckBiometrics;
          print(canAuthenticateWithBiometrics);
          if (canAuthenticateWithBiometrics) {
           try{
             final bool didAuthenticate = await _auth.authenticate(
               localizedReason: 'Please authenticate to show account balance',
               options: const AuthenticationOptions(
                 biometricOnly: false,
               ),);
             setState(() {
               _isauthenticated = didAuthenticate;
             });
           }catch(e){
             print(e);
           }
          }
        } else {
          setState(() {
            _isauthenticated = false;
          });
        }
      },
      child: Icon(_isauthenticated ? Icons.lock : Icons.lock_open),
    );
  }

  Widget _BuildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Account Ballance',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (_isauthenticated)
            const Text(
              "\$ 2500",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          if (!_isauthenticated)
            const Text(
              '******',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
