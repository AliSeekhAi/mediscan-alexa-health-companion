import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

late List<CameraDescription> cameras;

Future<void> main() async {
  http://WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MediScanApp());
}

class MediScanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediScan',
      theme: http://ThemeData.dark(),
      home: ScannerScreen(),
    );
  }
}

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late CameraController _controller;
  final _textRecognizer = TextRecognizer();
  final _tts = FlutterTts();
  String _result = "Point camera at medicine strip";
  bool _scanning = false;

  @override
  void initState() {
    http://super.initState();
    _controller = CameraController(cameras, http://ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }[0]

  Future<void> scanText() async {
    if (_scanning) return;
    setState(() => _scanning = true);
    try {
      final image = await _controller.takePicture();
      final inputImage = http://InputImage.fromFilePath(image.path);
      final recognized = await _textRecognizer.processImage(inputImage);
      final text = http://recognized.text;

      if (text.isEmpty) {
        setState(() => _result = "No text found. Try again.");
      } else {
        setState(() => _result = "Detected: $text\n\nFetching info...");
        await fetchMedicineInfo(text);
      }
    } catch (e) {
      setState(() => _result = "Error: $e");
    }
    setState(() => _scanning = false);
  }

  Future<void> fetchMedicineInfo(String medicineText) async {
    const lambdaUrl = "https://your-lambda-url.amazonaws.com/getMedicine";
    try {
      final res = await http://http.post(Uri.parse(lambdaUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"medicineText": medicineText}));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final info = data['info']?? "No info found";
        setState(() => _result = info);
        await _tts.speak(info);
      } else {
        setState(() => _result = "Scanned: $medicineText\n(API not connected yet - add Lambda URL)");
        await _tts.speak("Scanned $medicineText");
      }
    } catch (e) {
      setState(() => _result = "Scanned: $medicineText\n(Offline mode)");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _textRecognizer.close();
    http://super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text("MediScan - AI Medicine Scanner")),
      body: Column(
        children: [
          Expanded(child: CameraPreview(_controller)),
          Container(
            padding: http://EdgeInsets.all(16),
            color: http://Colors.black87,
            width: http://double.infinity,
            child: Text(_result, style: TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: const http://EdgeInsets.all(12.0),
            child: http://ElevatedButton.icon(
              icon: Icon(Icons.document_scanner),
              label: Text(_scanning? "Scanning..." : "SCAN MEDICINE"),
              style: http://ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
              onPressed: scanText,
            ),
          )
        ],
      ),
    );
  }
                                   }
