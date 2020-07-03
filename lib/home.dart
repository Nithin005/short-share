import 'package:flutter/material.dart';
import 'package:short_share/api.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: MainForm(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {
                Navigator.pushNamed(context, '/help');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MainForm extends StatefulWidget {
  MainForm({Key key}) : super(key: key);

  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final urlController = TextEditingController();
  final surlController = TextEditingController();
  final prefNameController= TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    urlController.dispose();
    surlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(children: <Widget>[
        FormBuilder(
          key: _fbKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                controller: urlController,
                attribute: "url",
                decoration: InputDecoration(
                  labelText: "Enter URL:",
                ),
                validators: [
                  FormBuilderValidators.url(),
                ],
              ),
              FormBuilderTextField(
                controller: surlController,
                attribute: "surl",
                decoration: InputDecoration(
                  labelText: "Shortened URL:",
                ),
                validators: [
                  FormBuilderValidators.url(),
                ],
              ),
              FormBuilderTextField(
                controller: prefNameController,
                attribute: "prefName",
                decoration: InputDecoration(
                  labelText: "Preferred Name:",
                ),
                
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 16)),
        RaisedButton(
            child: Text("AutoShare"),
            onPressed: () async {
              String shortUrl = null;
              
              
              if (urlController.text.isEmpty) {
                urlController.text =
                    (await Clipboard.getData(Clipboard.kTextPlain)).text;
              }
              if(_fbKey.currentState.validate())
              
              { final snackBar = SnackBar(
                content: Text("Processing"),
              );
                Scaffold.of(context).showSnackBar(snackBar);
                shortUrl = await cuttlyShorten(urlController.text,prefNameController.text);
              }
              
              if(shortUrl == null){
                final snackBar = SnackBar(
                content: Text("Error"),
              );
              Scaffold.of(context).showSnackBar(snackBar);
                return null;
              }
              
              print(shortUrl);
              surlController.text = shortUrl;
              Share.share(surlController.text);
            })
      ]),
    );
  }
}
