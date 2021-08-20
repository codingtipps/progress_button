import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ButtonState _state = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ProgressButton.icon(
            iconedButtons: {
              ButtonState.idle: IconedButton(
                  text: "Send",
                  icon: Icon(Icons.send, color: Colors.white),
                  color: Colors.deepPurple.shade500),
              ButtonState.loading: IconedButton(
                  text: "Loading", color: Colors.deepPurple.shade700),
              ButtonState.fail: IconedButton(
                  text: "Failed",
                  icon: Icon(Icons.cancel, color: Colors.white),
                  color: Colors.red.shade300),
              ButtonState.success: IconedButton(
                  text: "Success",
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  color: Colors.green.shade400)
            },
            onPressed: () {
              progressButton();
            },
            state: _state),
      ),
    );
  }

  Future progressButton() async {
    setState(() {
      //sets the  state of stateTextWithIcon to loading once button is pressed
      _state = ButtonState.loading;
    });
    var url = 'https://google.com';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        //sets the  state of stateTextWithIcon to success if whatever request made was successful
        _state = ButtonState.success;
      });
    } else {
      setState(() {
        //sets the  state of stateTextWithIcon to fail if the request was unsuccessful
        _state = ButtonState.fail;
      });
    }
  }
}
