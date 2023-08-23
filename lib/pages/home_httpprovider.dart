import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themeDataAndBloc/provider/http_provider.dart';
import 'package:themeDataAndBloc/services/http_services.dart';

class HttpPageProvider extends StatefulWidget {
  HttpPageProvider({super.key});

  @override
  State<HttpPageProvider> createState() => _HttpPageProviderState();
}

class _HttpPageProviderState extends State<HttpPageProvider> {
  HttpProvider dataResponse = HttpProvider();

  final _nameController = TextEditingController();
  final _jobController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _jobFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    dataResponse = Provider.of<HttpProvider>(context, listen: false);
  }

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
              child: Consumer(
                builder: (context, value, child) => Text(
                  (dataResponse.data == '')
                      ? 'tidak ada id'
                      : dataResponse.data.toString(),
                ),
              )),
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
                  hintText: (dataResponse.data == '')
                      ? 'tidak ada nama'
                      : dataResponse.data.toString(),
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
              (dataResponse.data == '')
                  ? 'tidak ada createAt'
                  : dataResponse.data.toString(),
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
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                controller: _jobController,
                decoration: InputDecoration(
                  hintText: (dataResponse.data == '')
                      ? 'tidak ada job'
                      : dataResponse.data.toString(),
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
              HttpService.connectAPI('joni', 'baby');
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
