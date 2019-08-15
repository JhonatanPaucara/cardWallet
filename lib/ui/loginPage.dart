import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../helpers/cardDrawer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  Widget _buildListCard(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              document['name'],
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              document['cvv'].toString(),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
      onTap: () {
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot newSnap = await transaction.get(document.reference);
          await transaction.update(
            newSnap.reference,
            {'cvv': document['cvv'] + 1},
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      drawer: cardDrawer(context),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Cards').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('...Loading');
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildListCard(context, snapshot.data.documents[index]),
          );
        },
      ),
    );
  }
}
