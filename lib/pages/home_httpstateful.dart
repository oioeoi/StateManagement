import 'package:flutter/material.dart';
import 'package:themeDataAndBloc/services/httpstateful.dart';
// import '../models/textformfield.dart';

class HttpPageStateful extends StatefulWidget {
  HttpPageStateful({super.key});

  @override
  State<HttpPageStateful> createState() => _HttpPageStatefulState();
}

class _HttpPageStatefulState extends State<HttpPageStateful> {
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
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
                  border: InputBorder.none,
                ),
              ),
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                color: Colors.blue[50],
              ),
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
                  border: InputBorder.none,
                ),
              ),
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
                  dataResponse = value as HttpStatefull;
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
