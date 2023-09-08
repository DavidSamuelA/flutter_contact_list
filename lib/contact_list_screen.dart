import 'package:flutter/material.dart';
import 'package:flutter_contact_list/database_helper.dart';
import 'package:flutter_contact_list/main.dart';
import 'contact_form_screen.dart';
import 'contact_details.dart';
import 'edit_contact_form_screen.dart';
import 'simple_contact_form_screen.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  late List<ContactDetails> _contactDetailsList;

  @override
  void initState() {
    super.initState();
    getAllContactDetails();
  }

  getAllContactDetails() async {
    _contactDetailsList = <ContactDetails>[];

    var contactDetails =
        await dbHelper.queryAllRows(DatabaseHelper.contactListTable);

    contactDetails.forEach((contactDetail) {
      setState(() {
        print(contactDetail['_id']);
        print(contactDetail['_name']);
        print(contactDetail['_mobileNo']);
        print(contactDetail['_emailId']);
        print(contactDetail['_address']);

        var contactDetailsModel = ContactDetails(
            contactDetail['_id'],
            contactDetail['_name'],
            contactDetail['_mobileNo'],
            contactDetail['_emailId'],
            contactDetail['_address']);

        _contactDetailsList.add(contactDetailsModel);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            new Expanded(
                child: new ListView.builder(
                    itemCount: _contactDetailsList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new InkWell(
                        child: ListTile(
                          onTap: () {
                            print(
                                '---------> Edit or Delete invoked : Send Data');

                            print(_contactDetailsList[index].id);
                            print(_contactDetailsList[index].name);
                            print(_contactDetailsList[index].mobileNo);
                            print(_contactDetailsList[index].emailId);
                            print(_contactDetailsList[index].address);
                            
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => SimpleContactFormScreen(),
                                settings: RouteSettings(
                                  arguments: _contactDetailsList[index],
                                )));
                          },
                          title: Text(_contactDetailsList[index].name +
                              '\n' +
                              _contactDetailsList[index].mobileNo +
                              '\n' +
                              _contactDetailsList[index].emailId +
                              '\n' +
                              _contactDetailsList[index].address),
                        ),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('--------> FAB Clicked');
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SimpleContactFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
