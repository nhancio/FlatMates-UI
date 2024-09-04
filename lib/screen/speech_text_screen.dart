import 'package:flatmates/screen/flate_mates.dart';
import 'package:flatmates/screen/speech_details/speech_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/widgets/custom_button.dart';
import 'package:flatmates/screen/user_info_screen.dart';
import '../database/database.dart';

class SpeechTextScreen extends StatefulWidget {
  @override
  _SpeechTextScreenState createState() => _SpeechTextScreenState();
}

class _SpeechTextScreenState extends State<SpeechTextScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = '';
  TextEditingController _textController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _spokenText = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      // Store spoken text in the database
      await _dbHelper.insertUserInput(_spokenText);
    }
  }

  void _saveTextInput() async {
    if (_textController.text.isNotEmpty) {
      await _dbHelper.insertUserInput(_textController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tell Us More',style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () async {
              List<Map<String, dynamic>> userInput = await _dbHelper.getUserInput();
              Get.to(() => UserInfoScreen(), arguments: userInput);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.lightBackground
                : AppColors.darkBackground,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Tell Us More About Your Requirements',
                style: AppTextStyles.titleStyle(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _listen,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.purple[100],
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    size: 50,
                    color: Colors.purple,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'OR',
                style: AppTextStyles.bodyStyle(context).copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _textController,
                maxLines: 3,
                style: TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  hintText: 'write about flatmate preference...',
                  hintStyle: TextStyle(color: Colors.white70), // Hint text color
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveTextInput,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {

                        Get.to(() => FlatmateRoomScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
