import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:kontrol_lampu_rumah/KontrolSwitch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanAwal extends StatefulWidget {
  const HalamanAwal({Key? key}) : super(key: key);

  @override
  State<HalamanAwal> createState() => _HalamanAwalState();
}

class _HalamanAwalState extends State<HalamanAwal> {

  final db = FirebaseDatabase.instance.ref('Switch');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Kontrol Lampu",
          style: TextStyle(
              fontSize: 30, color: Colors.black54, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.lightBlueAccent[100],
        elevation: 22,
        shadowColor: Colors.deepPurple[100],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Column(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                padding: const EdgeInsets.all(20.0),
                query: db,
                itemBuilder: (context, snapshot, animation, index) {
                  return KontrolSwitch(
                      key: ValueKey(snapshot.key),
                      title: snapshot.child('Nama Ruangan').value.toString(),
                      description: snapshot.child('Status lampu').value.toString(),
                      jumlah: snapshot.child('Jumlah Lampu').value.toString(),
                      on: "${snapshot.key}",
                      off: "${snapshot.key}",
                      delete: "${snapshot.key}",
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
