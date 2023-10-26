import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/contacts_model.dart';
import 'add_contact.dart';
import 'add_user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Contacts",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ]),
      //add Future Builder to get contacts
      body: FutureBuilder<List<Contact>>(
        future: DBHelper.readContacts(), //read contacts list here
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          //if snapshot has no data yet
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
          //if snapshot return empty [], show text
          //else show contact list
          return snapshot.data!.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/open-cardboard-box.png",
                        height: 200),
                    SizedBox(height: 20),
                    Text(
                      "You don't have contacts yet",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ))
              : ListView(
                  children: snapshot.data!.map((contacts) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(
                          children: <Widget>[Container(
                            height: 100,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              elevation:10,
                              color: Colors.white,
                              shadowColor: Colors.black,
                              //shape: ShapeBorder(),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Icon(Icons.person),backgroundColor: Colors.pink[300]),
                                 //child: Text(contacts.name[0]),),
                                title: Text(contacts.name),
                                subtitle: Text(contacts.contact),
                                trailing: IconButton(
                                  icon: Icon(color:Colors.pink[300],Icons.delete),
                                  onPressed: () async {
                                    await DBHelper.deleteContacts(contacts.id!);
                                    setState(() {
                                      //rebuild widget after delete
                                    });
                                  },
                                ),
                                // onTap: () async {
                                //   debugPrint('Card tapped.');
                                //   //tap on ListTile, for update
                                //   final refresh = await Navigator.of(context)
                                //       .push(MaterialPageRoute(
                                //           builder: (_) => AddContacts(
                                //                 contact: Contact(
                                //                   id: contacts.id,
                                //                   name: contacts.name,
                                //                   contact: contacts.contact,
                                //                   email: contacts.email,
                                //                 ),
                                //               )));
                                //
                                //   if (refresh) {
                                //     setState(() {
                                //       //if return true, rebuild whole widget
                                //     });
                                //   }
                                // },
                              ),
                            ),
                          ),
                            Positioned(
                                bottom: 15,
                                right: 30,
                                width: 25,
                                height: 25,
                                child: FloatingActionButton(backgroundColor:Colors.white24,onPressed: () async {
                                  debugPrint('Card tapped.');
                                  //tap on ListTile, for update
                                  final refresh = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (_) => AddContacts(
                                        contact: Contact(
                                          id: contacts.id,
                                          name: contacts.name,
                                          contact: contacts.contact,
                                          email: contacts.email,
                                        ),
                                      )));

                                  if (refresh) {
                                    setState(() {
                                      //if return true, rebuild whole widget
                                    });
                                  }
                                },
                                child: Icon(color:Colors.pink[300],Icons.edit))),
                        ]),
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddContacts()));

          if (refresh) {
            setState(() {
              //if return true, rebuild whole widget
            });
          }
        },
      ),
    );
  }
}
