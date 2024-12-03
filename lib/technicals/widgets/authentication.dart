import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenServ {
  //stores user data in cloud firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //for user auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

//for user sign up
 Future<String> signUpUser(
    { required String email,
    required String password,
    required String name}) async {
  String res ="An error occured!";
  try{
    if(email.isNotEmpty || password.isNotEmpty || name.isNotEmpty){
       //Registers user in firebase using email  n password
       UserCredential credential = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
    );
    //adds user to cloud firestore among other errors
    await _firestore.collection("users").doc(credential.user!.uid).set({
      'name':name,
      "email":email,
      'uid': credential.user!.uid,
    });
    res = "Success!";
    }
 
  } catch (e) {
    return e.toString();
  }
  return res;
 }
 //For the log in page
 Future<String> loginUser({
  required String email,
  required String password,
 }) async {
   String res ="An error occured!";
  try{
    if(email.isNotEmpty || password.isNotEmpty){
      //Log in user with email and password
      await _auth.signInWithEmailAndPassword(
        email: email, password: password);
         res = "Success!";
    } else{
      res = "Please enter all the fields";
    }
  }catch(e){
    return e.toString();
  }
  return res;
 }
 //For log out sequence
 Future<void> signOut() async {
  await _auth.signOut();
 }
}