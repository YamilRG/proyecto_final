import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class VisualizacionFb extends StatefulWidget {
  const VisualizacionFb({Key? key}) : super(key: key);

  @override
  State<VisualizacionFb> createState() => _VisualizacionFbState();
}

class _VisualizacionFbState extends State<VisualizacionFb> {
  String? todoDesc;
  String? todotile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("MyTodos").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                QueryDocumentSnapshot<Object?>? documentSnapshot =
                    snapshot.data?.docs[index];
                return Dismissible(
                    key: Key(index.toString()),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text((documentSnapshot != null)
                            ? (documentSnapshot["todoTitle"])
                            : ""),
                        subtitle: Text((documentSnapshot != null)
                            ? ((documentSnapshot["todoDesc"] != null)
                                ? documentSnapshot["todoDesc"]
                                : "")
                            : ""),
                      ),
                    ));
              });
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.red,
            ),
          ),
        );
      },
    ));
  }
}
