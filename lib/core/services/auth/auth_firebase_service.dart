import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/models/chat_user.dart';
import 'dart:io';

import 'package:firebase_chat/core/services/auth/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );
    debugPrint("Im here before auth");
    final auth = FirebaseAuth.instanceFor(app: signup);
    debugPrint("Im here before credential");
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    debugPrint("Im here before if");

    if (credential.user != null) {
      //1. Upload da imagem
      debugPrint("Im here before imagename");

      final imageName = "${credential.user!.uid}.jpg";
      debugPrint("Im here before imageurl");
      final imageURL = await _uploadUserImage(image, imageName);
      debugPrint("Im here before updateDisplayName");
      //2. Atualizar os atributos do usuário
      await credential.user?.updateDisplayName(name);
      debugPrint("Im here before updatePhotoUrl");
      await credential.user?.updatePhotoURL(imageURL);
      debugPrint("Im here before _saveChatUser");
      //3. Salvar on usuário no banco de dados(opcional)
      await _saveChatUser(_toChatUser(credential.user!));
    }
    debugPrint("Im here before signup delete");
    await signup.delete();
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection("users").doc(user.id);

    await docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageUrl,
    });
  }

  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: user.photoURL ?? "assets/images/avatar.png",
    );
  }
}
