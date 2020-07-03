//import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsForm(),
    );
  }
}

class SettingsForm extends StatefulWidget {
  SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final apiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    restore();
  }

  restore() async {
    final prefs = await SharedPreferences.getInstance();
    apiController.text = prefs.getString('api_key') ?? '';
    //_fbKey.currentState.fields["api_key"].currentState.didChange(prefs.getString("api_key") ?? '');
    //_fbKey.currentState.setAttributeValue("api_key", prefs.getString("api_key") ?? "");
    //apiController.text = prefs.getString('') ?? '';
    //_fbKey.currentState.setAttributeValue("service", prefs.getString("service") ?? "");
    _fbKey.currentState.fields["service"].currentState.didChange(prefs.getString("service"));
    
  }

  save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          FormBuilder(
              key: _fbKey,
              autovalidate: true,
              child: Column(children: <Widget>[
                FormBuilderTextField(
                  controller: apiController,
                  onSaved: (key) async {
                   
                    save('api_key', key.toString());
                    print(key);
                  },
                  attribute: "api_key",
                  decoration: InputDecoration(labelText: "Enter Api Key:"),
                ),
                FormBuilderDropdown(
                  onSaved: (service) async {
                    save("service", service.toString());
                    print(service.toString());
                  },
                  attribute: "service",
                  decoration: InputDecoration(labelText: "Shortening Service"),
                  items: ['Cuttly']
                      .map((service) => DropdownMenuItem(
                          value: service, child: Text("$service")))
                      .toList(),
                )
              ])),
          RaisedButton(
            
            child: Text("save"),
            onPressed: () {
              _fbKey.currentState.save();
              final snackBar = SnackBar(
                content: Text("Saved"),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              print("saved");
            },
          ),
        ],
      ),
    );
  }
}
