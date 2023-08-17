import 'package:flutter/material.dart';
import 'package:themeDataAndBloc/models/http_req_post.dart';
// import '../models/textformfield.dart';

class HttpPage extends StatefulWidget {
  HttpPage({super.key});

  @override
  State<HttpPage> createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  HttpStatefull dataResponse = HttpStatefull();

  final _nameController = TextEditingController();
  final _jobController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _jobFocusNode = FocusNode();

  void _submitForm() {
    _nameController.clear();
    _jobController.clear();
    _nameFocusNode.unfocus();
    _jobFocusNode.unfocus();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    _nameFocusNode.dispose();
    _jobFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              (dataResponse.id == '') ? 'tidak ada id' : dataResponse.id,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              onFieldSubmitted: (value) {
                //ketika sudah ngisi maka akan langung diarahin ngisi field ke 2
                FocusScope.of(context).requestFocus(_jobFocusNode);
              },
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: (dataResponse.name == '')
                      ? 'tidak ada nama'
                      : dataResponse.name,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  filled: true,
                  fillColor: Colors.green[100],
                  border: InputBorder.none),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              (dataResponse.createAt == '')
                  ? 'tidak ada createAt'
                  : dataResponse.createAt,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              onFieldSubmitted: (value) {
                //ketika sudah ngisi maka akan langung diarahin ngisi field ke 2
                FocusScope.of(context).requestFocus();
              },
              controller: _jobController,
              decoration: InputDecoration(
                  hintText: (dataResponse.job == '')
                      ? 'tidak ada job'
                      : dataResponse.job,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  filled: true,
                  fillColor: Colors.green[100],
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              HttpStatefull.connectAPI(
                      _nameController.text, _jobController.text)
                  .then((value) {
                setState(() {
                  dataResponse = value;
                  _submitForm();
                });
              });
            },
            child: Text('Post Data'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Colors.blue.shade50,
            )),
          )
        ],
      ),
    );
  }
}
