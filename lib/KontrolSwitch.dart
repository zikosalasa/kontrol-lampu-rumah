import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KontrolSwitch extends StatefulWidget {
  const KontrolSwitch({
    Key? key,
    required this.title,
    required this.description,
    required this.jumlah,
    required this.on,
    required this.off,
    required this.delete,
  }) : super(key: key);

  final String title, description, jumlah;
  final String on;
  final String off;
  final String delete;

  @override
  State<KontrolSwitch> createState() => _KontrolSwitchState();
}

class _KontrolSwitchState extends State<KontrolSwitch> {
  final db = FirebaseDatabase.instance.ref('Switch');
  bool statusSwitch = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  getValue() async {
    prefs = await _prefs;
    setState(() {
      statusSwitch =
      (prefs.containsKey("switchValue") ? prefs.getBool("switchValue") : false)!;
    });
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // padding: EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      elevation: 10,
      shadowColor: Colors.cyan,
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.only(left: 40.0),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20),
        ),
        // subtitle: Text("Jumlah lampu : ${widget.jumlah}"),
        leading: IconButton(
          onPressed: () {
            db.child(widget.delete).remove();
          },
          icon: const Icon(Icons.delete),
        ),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(20.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            tileColor: Colors.indigo,
            textColor: Colors.white,
            iconColor: Colors.white,
            title: Text(
              "Status Lampu   : ${widget.description}",
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              "Jumlah Lampu : ${widget.jumlah}",
              style: const TextStyle(fontSize: 20),
            ),
            trailing: Switch(
                value: statusSwitch,
                onChanged: (value) {
                  statusSwitch = value;
                  setState(() {
                    // statusSwitch = !statusSwitch;
                    if (statusSwitch) {
                      db.child(widget.on).update({"Status lampu": "on"});
                    } else {
                      db.child(widget.off).update({"Status lampu": "off"});
                    }
                  });
                  prefs.setBool("switchValue", statusSwitch);
                }),
          ),
        ],
      ),
    );
  }
}
