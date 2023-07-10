import "package:flutter/material.dart";

class AddressBookScreen extends StatefulWidget {
  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  List<String> addresses = [
    '199, 3rd floor,swamy vivekananda main road,whitefield, Bangalore',
    '456 Elm St',
    '789 Oak St',
  ];

  TextEditingController _newAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Adresses"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(address),
                  ),
                  TextButton(onPressed: () {}, child: Text("Delete")),
                  Divider(
                    height: 5,
                    thickness: 1,
                  )
                ],
              );
            }),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           title: Text('Add New Address'),
      //           content: TextField(
      //             controller: _newAddressController,
      //             decoration: InputDecoration(
      //               hintText: 'Enter address',
      //             ),
      //           ),
      //           actions: [
      //             TextButton(
      //               child: Text('Cancel'),
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //             ),
      //             TextButton(
      //               child: Text('Add'),
      //               onPressed: () {
      //                 setState(() {
      //                   addresses.add(_newAddressController.text);
      //                 });
      //                 _newAddressController.clear();
      //                 Navigator.pop(context);
      //               },
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
