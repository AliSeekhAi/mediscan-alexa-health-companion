
1  import 'package:flutter/material.dart';
2  import 'package:purchases_flutter/purchases_flutter.dart';
3  import 'package:camera/camera.dart';
4  import 'package:flutter_tts/flutter_tts.dart';
5
6  void main() async {
7    WidgetsFlutterBinding.ensureInitialized();
8    await Purchases.configure(PurchasesConfiguration("test_key"));
9    runApp(MaterialApp(home: Home()));
10 }
11
12 class Home extends StatelessWidget {
13   final tts = FlutterTts();
14   Home({super.key});
15   @override
16   Widget build(BuildContext context) {
17     return Scaffold(
18       appBar: AppBar(title: Text("MediScan Alexa")),
19       body: Center(child: ElevatedButton(
20         onPressed: () => tts.speak("MediScan ready"),
21         child: Text("Test Alexa Voice"),
22       )),
23     );
24   }
25 }
