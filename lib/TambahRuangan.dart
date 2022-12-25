import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TambahRuangan extends StatefulWidget {
  const TambahRuangan({Key? key}) : super(key: key);

  @override
  State<TambahRuangan> createState() => _TambahRuanganState();
}

class _TambahRuanganState extends State<TambahRuangan> {

  final db = FirebaseDatabase.instance.ref();

  final _formkey = GlobalKey<FormState>();

  TextEditingController namaR = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController jml = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tambah Ruangan",
          style: TextStyle(
              fontSize: 30,
              color: Colors.black54,
              fontStyle: FontStyle.italic
          ),
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



      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[

                new TextFormField(
                  controller : pin,
                  decoration: new InputDecoration(
                      hintText: "Pin",
                      labelText: "Pin",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)
                      )
                  ),
                  validator: (value){
                    if (value!.isEmpty){
                      return "Pin tidak boleh Kosong";
                    }
                    return null;
                  },
                ),

                new Padding(padding: new EdgeInsets.only(top: 20.0),),
                new TextFormField(
                  controller : namaR,
                  decoration: new InputDecoration(
                      hintText: "Nama Ruangan",
                      labelText: "Nama Ruangan",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)
                      )
                  ),
                  validator: (value){
                    if (value!.isEmpty){
                      return "Nama Ruangan tidak boleh Kosong";
                    }
                    return null;
                  },
                ),

                new Padding(padding: new EdgeInsets.only(top: 20.0),),
                new TextFormField(
                  controller: status,
                  decoration: new InputDecoration(
                      hintText: "Status Lampu",
                      labelText: "Status Lampu",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)
                      )
                  ),
                  validator: (value){
                    if (value!.isEmpty){
                      return "Status Lampu tidak boleh Kosong";
                    }
                    return null;
                  },
                ),

                new Padding(padding: new EdgeInsets.only(top: 20.0),),
                new TextFormField(
                  controller: jml,
                  decoration: new InputDecoration(
                      hintText: "Jumlah Lampu",
                      labelText: "Jumlah Lampu",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)
                      )
                  ),
                  validator: (value){
                    if (value!.isEmpty){
                      return "Jumlah Lampu tidak boleh Kosong";
                    }
                    return null;
                  },
                ),

                new Padding(padding: new EdgeInsets.only(top: 20.0),),
                new OutlinedButton(
                  onPressed: () {

                    if(_formkey.currentState!.validate()){
                      db.child("Switch/${pin.text}").set({
                        "Pin" : pin.text,
                        "Nama Ruangan" : namaR.text,
                        "Status lampu" : status.text,
                        "Jumlah Lampu" : jml.text,
                      }).asStream();
                      Navigator.of(context).pop();
                    };


                  },
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                    ),
                  ),

                )

              ],
            ),
          ),
        ),
      ),

    );
  }
}
