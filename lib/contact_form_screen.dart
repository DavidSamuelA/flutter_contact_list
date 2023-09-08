import 'package:flutter/material.dart';
import 'package:flutter_contact_list/contact_list_screen.dart';
import 'package:flutter_contact_list/database_helper.dart';
import 'package:flutter_contact_list/main.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({Key? key}) : super(key: key);

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  var _nameController = TextEditingController();
  var _mobileNoController = TextEditingController();
  var _emailIdController = TextEditingController();
  var _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details Form'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SizedBox(
                  height: 50,
                  width: 350,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Name'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  height: 50,
                  width: 350,
                  child: TextFormField(
                    controller: _mobileNoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Mobile No',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  height: 50,
                  width: 350,
                  child: TextFormField(
                    controller: _emailIdController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Email Id',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  height: 50,
                  width: 350,
                  child: TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Address',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: () {
                print('-------> Save Clicked');
                _save();
              },
              child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    print('---------> _save');
    print('---------> Name ${_nameController.text}');
    print('---------> MobileNo ${_mobileNoController.text}');
    print('---------> EmailId ${_emailIdController.text}');
    print('---------> Address ${_addressController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.columnName: _nameController.text,
      DatabaseHelper.columnMobileNo: _mobileNoController.text,
      DatabaseHelper.columnEmailId: _emailIdController.text,
      DatabaseHelper.columnAddress: _addressController.text,
    };

    final result = await dbHelper.insert(row, DatabaseHelper.contactListTable);

    debugPrint('Inserted Row Id : $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSucessSnackBar(context, 'Saved');
    }

    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ContactListScreen()));
    });
  }

  void _showSucessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
