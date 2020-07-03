import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: CuttlyForm(),
    );
  }
}

class CuttlyForm extends StatefulWidget {
  CuttlyForm({Key key}) : super(key: key);

  @override
  _CuttlyFormState createState() => _CuttlyFormState();
}

class _CuttlyFormState extends State<CuttlyForm> {
  final _formKey = GlobalKey<FormState>();
  String apiKey = '';
  final apiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    restore();
  }

  restore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      apiController.text = prefs.getString('api_key') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(32),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Row(
                children:<Widget>[
                Text("Shortening Service"),
                DropdownButton<String>(
                  items: <String>['Cuttly'].map((String value) {
                    return new DropdownMenuItem<String>(
                    
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                ]
              ),
              TextFormField(
                controller: apiController,
                onSaved: (String key) async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('api_key', key);
                  print(key);
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: "API Key",
                    hintText: "Enter API Key"),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              RaisedButton(
                child: Text("save"),
                onPressed: () {
                  _formKey.currentState.save();
                  final snackBar = SnackBar(
                    content: Text("Saved"),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                  print("saved");
                },
              )
            ])));
  }
}
