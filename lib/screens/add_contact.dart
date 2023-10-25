import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/contacts_model.dart';

class AddContacts extends StatefulWidget {
  AddContacts({Key? key, this.contact}) : super(key: key);
  //here i add a variable
  //it is not a required, but use this when update
  final Contact? contact;

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  //for TextField
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController =TextEditingController();

  @override
  void initState() {
    //when contact has data, mean is to update
    //instead of create new contact
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _contactController.text = widget.contact!.contact;
      _emailController.text = widget.contact!.email;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add & Update Contacts'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(false),
          //to prevent back button pressed without add/update
        ),
      ),
      body: SingleChildScrollView(
        //create two text field to key in name and contact
        child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border:  OutlineInputBorder(borderRadius:BorderRadius.circular(20) ),
                        hintText: 'Enter Full Name ',
                        labelText: 'Full Name'
                    )),
                SizedBox(
                  height: 30,),
                TextField(
                    keyboardType:TextInputType.number,
                    maxLength: 11,
                    controller: _contactController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border:  OutlineInputBorder(borderRadius:BorderRadius.circular(20)),
                      hintText: 'Enter Mobile Number',
                      labelText: 'Mobile Number',
                    )),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border:  OutlineInputBorder(borderRadius:BorderRadius.circular(20)),
                      hintText: 'Enter Email ',
                      labelText: 'Email',
                    )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  //this button is pressed to add contact
                  onPressed: () async {
                    //if contact has data, then update existing list
                    //according to id
                    //else create a new contact
                    if (widget.contact != null) {
                      await DBHelper.updateContacts(Contact(
                        id: widget.contact!.id, //have to add id here
                        name: _nameController.text,
                        contact: _contactController.text,
                        email: _emailController.text,
                      ));

                      Navigator.of(context).pop(true);
                    } else {
                      await DBHelper.createContacts(Contact(
                        name: _nameController.text,
                        contact: _contactController.text,
                        email: _emailController.text,
                      ));

                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Text(' Save '),
                ),
              ],)
        ),
      ),
    );
  }
}

