import 'package:conf_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Requis pour formater la date

class ListPage extends StatelessWidget {

  ListPage({Key? key}) : super(key: key);

  // On crée une fausse liste pour l'aperçu
  final List<Map<String, dynamic>> fakeConferences = [
    {
      'name': 'Conférence Android',
      'speaker': 'Bassem',
      'type': 'Demo Code',
      'dateTime': DateTime.now().add(Duration(days: 5)),
      'speakerImage': 'assets/images/avatar-homme.png',
    },{
      'name': 'Conférence Flutter',
      'speaker': 'Imed',
      'type': 'Demo Code',
      'dateTime': DateTime.now().add(Duration(days: 5)),
      'speakerImage': 'assets/images/avatar-homme.png',
    },
    {
      'name': 'Le futur de l AI',
      'speaker': 'Meriem',
      'type': 'Talk show',
      'dateTime': DateTime.now().add(Duration(days: 10)),
      'speakerImage': 'assets/images/mere.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('le dd/MM/yyyy à HH:mm', 'fr_FR');

    return Scaffold(
      appBar: AppBar(
        title: Text("Conference App",style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: fakeConferences.length,
        itemBuilder: (context, index) {
          final conf = fakeConferences[index];

          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(conf['speakerImage']),
              ),
              // TAF 4: Nom de la conférence
              title: Text(conf['name'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TAF 4: Nom du speaker [cite: 593]
                  Text("Par: ${conf['speaker']}"),
                  // TAF 4: Type de la conférence [cite: 594]
                  Text("Type: ${conf['type']}"),
                  // TAF 4: Date et heure [cite: 595]
                  Text(formatter.format(conf['dateTime'])),
                ],
              ),
              isThreeLine: true, // Important pour un sous-titre plus grand
            ),
          );
        },
      ),
    );
  }
}