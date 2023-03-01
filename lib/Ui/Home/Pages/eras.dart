import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
class Listview extends StatefulWidget {
  const Listview({Key? key}) : super(key: key);

  @override
  State<Listview> createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  final CollectionReference students = FirebaseFirestore.instance.collection('students');
  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  Future<void> _update([DocumentSnapshot? documentSnapshot])async{
    if(documentSnapshot != null){
      namecontroller.text = documentSnapshot['name'];
      agecontroller.text = documentSnapshot['age'].toString();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
        return Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
         child: Column(
           mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              TextField(
                keyboardType: TextInputType.text,
                controller:namecontroller ,
                decoration:const  InputDecoration(
                  labelText: "Name",
                ),
              ),
             const SizedBox(height: 5,),
              TextField(
                keyboardType: TextInputType.text,
                controller:agecontroller ,
                decoration:const  InputDecoration(
                  labelText: "Age",
                ),
              ),
             const  SizedBox(height: 15,),
              ElevatedButton(onPressed: ()async{
                final String name = namecontroller.text;
                final String age = agecontroller.text.toString();
                if(age!=null){
                  await students .doc(documentSnapshot!.id)
                                  .update({"name": name , "age" : age});
                  namecontroller.text ='';
                  agecontroller.text = '';
                }
              },
                  child: const Text("Update")),
            ],
        ),
        );
        });
  }
  Future<void> _create([DocumentSnapshot? documentSnapshot])async{
    if(documentSnapshot != null){
      namecontroller.text = documentSnapshot['name'];
      agecontroller.text = documentSnapshot['age'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                TextField(
                  keyboardType: TextInputType.text,
                  controller:namecontroller ,
                  decoration:const  InputDecoration(
                    labelText: "Name",
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  keyboardType: TextInputType.text,
                  controller:agecontroller ,
                  decoration:const  InputDecoration(
                    labelText: "Age",
                  ),
                ),
                const  SizedBox(height: 15,),
                ElevatedButton(onPressed: ()async{
                  final String name = namecontroller.text;
                  final String age = agecontroller.text.toString();
                  if(age!=null){
                    await students .add({"name": name , "age" : age});
                    namecontroller.text ='';
                    agecontroller.text = '';
                  }
                },
                    child: const Text("Update")),
              ],
            ),
          );
        });
  }
  Future<void> _delete(String studentId)async{
    await students.doc(studentId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
       const  SnackBar(
        content: Text('Succesfully deleted a memebr'),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _create();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text("Member details",
        style: GoogleFonts.roboto(color: Colors.brown,fontWeight: FontWeight. bold,fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context ,AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context,index){
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle:Text(documentSnapshot['age'].toString()),
                    trailing: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: (){
                                _update(documentSnapshot);
                              },
                              icon:const  Icon(Icons.edit)),
                          IconButton(
                              onPressed: (){
                                _delete(documentSnapshot.id);
                              },
                              icon:const  Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                );
                },
            );
          }
          else if(streamSnapshot.hasError){
            return const Center(
              child: Text("Something went wrong"),
            );
          }else if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return const Center(
              child: Text("Something went wrong"),
            );
          }

        },
      ),
    );
  }
}