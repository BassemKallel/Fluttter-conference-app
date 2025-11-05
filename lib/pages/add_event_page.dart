import 'package:conf_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final confNameController = TextEditingController();
  final speakerNameController = TextEditingController();

  // TAF 1: Variable pour la liste déroulante Type
  String selectedConfType = 'talk';

  // TAF 2: Variables pour la date/heure
  final _dateController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void dispose() {
    confNameController.dispose();
    speakerNameController.dispose();
    _dateController.dispose(); // <-- Ne pas oublier
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return; // L'utilisateur a annulé

    setState(() {
      _selectedDateTime = DateTime(
        date.year, date.month, date.day,
        time.hour, time.minute,
      );
      _dateController.text = "Date et heure sélectionnées !";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conference App",style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              // Champ Nom Conférence
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: confNameController,
                  decoration: InputDecoration(
                      labelText: 'Nom de Conference',
                      hintText: 'Entrer le name de la conférence',
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "tu dois compléter ce champ";
                    }
                    return null;
                  },
                ),
              ),
              // Champ Nom Speaker
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: speakerNameController,
                  decoration: InputDecoration(
                      labelText: 'Nom de conferant',
                      hintText: 'Entrer le nom de conferant',
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "tu dois compléter ce champ";
                    }
                    return null;
                  },
                ),
              ),

              // TAF 2: Champ Date/Heure
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Date & Heure',
                    hintText: 'Choisir la date et l\'heure',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: _selectDateTime,
                  validator: (value) {
                    if (_selectedDateTime == null) {
                      return "Veuillez choisir une date";
                    }
                    return null;
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Type de conférence',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedConfType,
                  items: [
                    DropdownMenuItem(value: 'talk', child: Text("Talk show")),
                    DropdownMenuItem(value: 'demo', child: Text("Demo Code")),
                    DropdownMenuItem(value: 'partner', child: Text("Partner")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedConfType = value!;
                    });
                  },
                ),
              ),

              // Bouton Envoyer
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          // Version simple: on affiche dans la console
                          print("Nom: ${confNameController.text}");
                          print("Speaker: ${speakerNameController.text}");
                          print("Type: $selectedConfType");
                          print("Date: $_selectedDateTime");

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Envoi en cours... (vérifiez la console)")));
                        }
                      },
                      child: Text("Envoyer"))),
            ]),
          ),
        ),
      ),
    );
  }
}