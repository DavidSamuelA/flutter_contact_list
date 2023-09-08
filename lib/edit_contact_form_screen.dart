import 'package:flutter/material.dart';
import 'package:flutter_contact_list/contact_details.dart';
import 'package:flutter_contact_list/contact_list_screen.dart';
import 'package:flutter_contact_list/database_helper.dart';
import 'package:flutter_contact_list/main.dart';

class EditContactFormScreen extends StatefulWidget {
  const EditContactFormScreen({Key? key}) : super(key: key);

  @override
  State<EditContactFormScreen> createState() => _EditContactFormScreenState();
}

class _EditContactFormScreenState extends State<EditContactFormScreen> {
  var _nameController = TextEditingController();
  var _mobileNoController = TextEditingController();
  var _emailIdController = TextEditingController();
  var _addressController = TextEditingController();

  //Edit mode ###
  bool firstTimeFlag = false;
  int _selectedId = 0;

  //Delete mode ##
  _deleteFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await dbHelper.delete(_selectedId, DatabaseHelper.contactListTable);

                  debugPrint('--------> Deleted Row ID : $result');

                  if (result > 0) {
                    _showSucessSnackBar(context, 'Deleted');
                    Navigator.pop(context);

                    setState(() {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ContactListScreen()));
                    });
                  }
                },
                child: const Text('Delete'),
              ),
            ],
            title: Text('Are you want to delete this'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //Edit -> Receive Data
    if (firstTimeFlag == false) {
      print('--------> once execute');

      firstTimeFlag = true;

      final contactDetails =
          ModalRoute.of(context)!.settings.arguments as ContactDetails;

      print('--------> Received Data');

      print(contactDetails.id);
      print(contactDetails.name);
      print(contactDetails.mobileNo);
      print(contactDetails.emailId);
      print(contactDetails.address);

      _selectedId = contactDetails.id!;

      _nameController.text = contactDetails.name;
      _mobileNoController.text = contactDetails.mobileNo;
      _emailIdController.text = contactDetails.emailId;
      _addressController.text = contactDetails.address;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details Form'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text('Delete')),
            ],
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                print('--------> Delete - display dialog');
                _deleteFormDialog(context);
              }
            },
          ),
        ],
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
              ElevatedButton(
                onPressed: () {
                  print('-------> Update Clicked');
                  _update();
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _update() async {
    print('---------> _update');
    
    print('--------> Selected Id : $_selectedId');

    print('---------> Name ${_nameController.text}');
    print('---------> MobileNo ${_mobileNoController.text}');
    print('---------> EmailId ${_emailIdController.text}');
    print('---------> Address ${_addressController.text}');

    Map<String, dynamic> row = {
      //Edit
      DatabaseHelper.columnId: _selectedId,

      DatabaseHelper.columnName: _nameController.text,
      DatabaseHelper.columnMobileNo: _mobileNoController.text,
      DatabaseHelper.columnEmailId: _emailIdController.text,
      DatabaseHelper.columnAddress: _addressController.text,
    };

    final result = await dbHelper.update(row, DatabaseHelper.contactListTable);

    debugPrint('Updated Row Id : $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSucessSnackBar(context, 'Updated');
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
