import 'package:flutter/material.dart';
import '../ui/myHomePage.dart';
import '../ui/loginPage.dart';
import '../ui/cardPage.dart';
import '../ui/firestorePage.dart';

Widget cardDrawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Páginas de ejemplo'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Home Page: Formulary'),
          onTap: () {
            Navigator.of(context).push(_createRouteHome());
          },
        ),
        ListTile(
          title: Text('Login Page: Formulary'),
          onTap: () {
            Navigator.of(context).push(_createRouteLogin());
          },
        ),
        ListTile(
          title: Text('Firestore Page: Formulary'),
          onTap: () {
            Navigator.of(context).push(_createRouteFirestore());
          },
        ),
        ListTile(
          title: Text('Card Page: Formulary'),
          onTap: () {
            Navigator.of(context).push(_createRouteCard());
          },
        )
      ],
    ),
  );
}

Route _createRouteHome() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

Route _createRouteFirestore() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FirestorePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

Route _createRouteLogin() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

Route _createRouteCard() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CardPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}
