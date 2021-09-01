import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biker Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Biker Prediction'),
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
  String solutionOne = "";
  String solutionTwo = "";
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController mySpeedController = TextEditingController();
  final TextEditingController theirSpeedController = TextEditingController();
  final TextEditingController theirDistanceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueField(mySpeedController, "mySpeed"),
              ValueField(distanceController, "distance"),
              ValueField(theirSpeedController, "their speed"),
              ValueField(theirDistanceController, "their distance"),
              ElevatedButton(
                onPressed: () {
                  int entgegenkommendeFahrer =
                      (int.parse(distanceController.text) *
                              (int.parse(mySpeedController.text) +
                                  int.parse(theirSpeedController.text)) /
                              (int.parse(mySpeedController.text) *
                                  int.parse(theirDistanceController.text)))
                          .round();
                  int ueberholteFahrer = (int.parse(distanceController.text) *
                          (int.parse(mySpeedController.text) -
                              int.parse(theirSpeedController.text)) /
                          (int.parse(mySpeedController.text) *
                              int.parse(theirDistanceController.text)))
                      .round();

                  setState(() {
                    solutionOne =
                        "Dir werden $entgegenkommendeFahrer Fahrradfahrer entgegenkommen";
                    if (ueberholteFahrer < 0) {
                      ueberholteFahrer = ueberholteFahrer.abs();
                      solutionTwo =
                          "Du wirst von $ueberholteFahrer Fahrradfahrern überholt werden";
                    } else {
                      solutionTwo =
                          "Du wirst $ueberholteFahrer Fahrradfahrer überholen";
                    }
                  });
                },
                child: Text("Calculate"),
              ),
              SolutionText(solutionOne),
              SolutionText(solutionTwo),
            ],
          ),
        ));
  }
}

class ValueField extends StatelessWidget {
  const ValueField(this.textEditingController, this.hint, {Key? key})
      : super(key: key);
  final TextEditingController textEditingController;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: hint),
    );
  }
}

class SolutionText extends StatelessWidget {
  const SolutionText(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
