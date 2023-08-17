import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scout/public.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
final controlleremail = TextEditingController();
final controllerepass = TextEditingController();
var email , password;

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  Future signin() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: controlleremail.text.trim(),
            password: controllerepass.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {

          AlertDialog alert = AlertDialog(
            title: const Text('Error'),
            content: const Text('No user found for that email.'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          );
          return showDialog(
              context: context,
              builder: (context) {
                return alert;
              });
        }
        else if (e.code == 'wrong-password') {
          AlertDialog lert = AlertDialog(
            title: const Text('Error'),
            content: const Text('Wrong password provided for that user.'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          );
          return showDialog(
              context: context,
              builder: (context) {
                return lert;
              });
        }
        if (e.code == 'weak-password') {
          AlertDialog ert = AlertDialog(
            title: const Text('Error'),
            content: const Text('The password provided is too weak.'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          );
          return showDialog(
              context: context,
              builder: (context) {
                return ert;
              });
        }
        else if (e.code == 'email-already-in-use') {
          AlertDialog alert = AlertDialog(
            title: const Text('Error'),
            content: const Text('The account already exists for that email.'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          );
          return showDialog(
              context: context,
              builder: (context) {
                return alert;
              });
        }
      } catch (e) {
        debugPrint(e.toString());
      }


  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
        child:Scaffold(
      appBar: AppBar(
        title: const Text("login"),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PublicPeople())
            );
          },
          child: const Icon(
            Icons.arrow_back_sharp,
          ),
        ),

      ),
      body: ListView(
        children: [
          const SizedBox(height: 50,),
          Center(
            child: Image.asset('assets/scou.png',
              height: 300,),),
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(child: Column(
              key: formstate,
              children: [ const SizedBox(height: 40,),
                TextFormField(
                  onSaved: (val){
                    email = val;
                  },
                  validator: (val){
                    if(val!.isEmpty)
                    {
                      return "Email Must Not Be Empty";
                    }
                    return null;
                  },
                  cursorColor:Colors.white ,
                  controller: controlleremail,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: "Your Email",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 1))
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  onSaved: (val){
                    password = val;
                  },
                  validator: (val){
                    if(val!.isEmpty)
                    {
                      return "Password Must Not Be Empty";
                    }
                    return null;
                  },
                  controller: controllerepass,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: "password",
                      prefixIcon: Icon(Icons.password),
                      hintText: "Your Password",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 1))
                  ),
                  obscureText: true,),
                const SizedBox(height: 40,),
                ElevatedButton.icon(onPressed: signin,
                    icon: const Icon(Icons.lock_open,size: 32,),
                    label: const Text("sign in" , style: TextStyle(fontSize: 24),),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)
                    )
                )],),
            ),
          )
        ],
      ),
    ));
  }

}
