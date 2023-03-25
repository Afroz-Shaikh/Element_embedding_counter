import 'dart:async';
import 'package:slidable_button/slidable_button.dart';
import 'package:flutter/material.dart';
import 'package:js/js_util.dart' as js_util;
import 'package:js/js.dart' as js;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

@js.JSExport()
class _MyAppState extends State<MyApp> {
  final _streamController = StreamController<void>.broadcast();
  int _counterCount = 0;

  @override
  void initState() {
    super.initState();
    final export = js_util.createDartExport(this);
    js_util.setProperty(js_util.globalThis, '_appState', export);
    js_util.callMethod(js_util.globalThis, '_stateSet', []);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  //Functions to be called from JS
  @js.JSExport()
  void increaseCount() {
    setState(() {
      _counterCount++;
      _streamController.add(null);
    });
  }

@js.JSExport()
 void decreaseCount() {
    setState(() {
      _counterCount--;
      _streamController.add(null);
    });
  }
 
@js.JSExport()
 void reset() {
    setState(() {
      _counterCount = 0;
      _streamController.add(null);
    });
  }
 
 


  // Handler to Control the JS count
  @js.JSExport()
  void addHandler(void Function() handler) {
    _streamController.stream.listen((event) => handler());
  }

  @js.JSExport()
  int get count => _counterCount;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Counter Demo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //* Slidable Button
              HorizontalSlidableButton(
                isRestart: true,
                autoSlide: true,
                tristate: true,
                initialPosition: SlidableButtonPosition.sliding,
                width: MediaQuery.of(context).size.width / 3,
                buttonWidth: 60.0,
                color: Colors.black.withOpacity(0.3),
                buttonColor: Colors.black,
                dismissible: false,
                label: Center(child: Text('$_counterCount')),
                onChanged: (SlidableButtonPosition value) {
                  if (value == SlidableButtonPosition.start) {
                    //* Add decrese Count function
                  } else if (value == SlidableButtonPosition.end) {
                    increaseCount();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('-'),
                      Text('+'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: increaseCount,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}
