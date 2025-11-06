import 'package:conf_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatelessWidget {

  ListPage({Key? key}) : super(key: key);

  final DateFormat formatter = DateFormat('le dd/MM/yyyy à HH:mm', 'fr_FR');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Conference App",style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("events").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Aucune conférence pour le moment."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {

              final DocumentSnapshot eventDoc = snapshot.data!.docs[index];
              final Map<String, dynamic> conf = eventDoc.data() as Map<String, dynamic>;

              final Timestamp timestamp = conf['date'];
              final DateTime confDate = timestamp.toDate();


              final String avatarName = conf['avatar']?.toString().toLowerCase() ?? 'default';

              return Card(
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/$avatarName.jpg'),
                    onBackgroundImageError: (exception, stackTrace) {
                    },
                    child: Image.asset(
                      'assets/images/avatar-homme.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person);
                      },
                    ),
                  ),
                  title: Text(conf['subject'] ?? 'Sans titre', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Par: ${conf['speaker'] ?? 'N/A'}"),
                      Text("Type: ${conf['type'] ?? 'N/A'}"),
                      Text(formatter.format(confDate)),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.green,)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}