import 'package:esptouch_example/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> SignIn() async {
    GoogleSignInAccount account = await googleSignIn.signIn();
    GoogleSignInAuthentication authentication = await account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);
    final user = (await _auth.signInWithCredential(credential)).user;
    if (user != null) {
      print("${user.email}");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Image(image: AssetImage('images/o.png'),height: 200,width: 200,),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                 ElevatedButton(
                    onPressed: () async {
                      await googleSignIn.signOut();
                      print("hamada");
                        
                    },
                    child: const Text('logout'),
                  ),
                  SizedBox(height: 60),
                  
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: ()async {
                      SignIn();
                      bool isSignedIn = await googleSignIn.isSignedIn();
    print(isSignedIn);
   
       Navigator.push (
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
   
                     

 

                         
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

