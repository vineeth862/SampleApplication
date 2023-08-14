import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_application/src/authentication/user_repository.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/profile/change_mobileNumber.dart';

enum Gender { Male, Female, Other }

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  GlobalService globalservice = GlobalService();
  var Controller = Get.put((UserRepository()));
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _mobilenumbercontroller;

  File? _profileImage;
  var items = ['Male', 'Female', 'Others', 'Not to disclose'];
  Map<String, dynamic> sampleData = {};
  //Gender _selectedGender = Gender.Male;
  String _selectedGender = "Male";
  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  void dispose() {
    _nameController!.dispose();
    _emailController!.dispose();
    _mobilenumbercontroller!.dispose();

    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  Future<Map<String, dynamic>> getData() async {
    Map<String, dynamic> sampleDatatemp =
        await UserRepository.instance.getUserData();
    setState(() {
      _nameController = TextEditingController(text: sampleDatatemp['userName']);
      if (sampleDatatemp['email'] != null) {
        _emailController = TextEditingController(text: sampleDatatemp['email']);
      } else {
        _emailController = TextEditingController();
      }
      _mobilenumbercontroller =
          TextEditingController(text: sampleDatatemp['mobile']);
      if (sampleDatatemp['gender'] != null) {
        _selectedGender = sampleDatatemp['gender'];
      }
    });

    //setState(() {
    sampleData = sampleDatatemp;
    //});
    return sampleDatatemp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        //padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          // border: Border.all(
                          //     width: 3,
                          //     color: Theme.of(context).colorScheme.primary),
                          //borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                              image: AssetImage(
                                "./assets/images/Lab_Single_Person.jpg",
                              ),
                              fit: BoxFit.cover),
                        )),
                  ),
                  Positioned(
                    top: 150 -
                        65, // 200 is cover image height and 65 is tried and tested number,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Set Profile Image',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 20,
                                      ),
                                      label: Text(
                                        "Take a picture",
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);

                                        _pickImage(ImageSource.camera);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // Set the border radius value
                                        ),
                                        primary: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        //   padding:
                                        //       EdgeInsets.symmetric(horizontal: 100.0),
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.filter,
                                        size: 20,
                                      ),
                                      label: const Text('Choose from gallery'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _pickImage(ImageSource.gallery);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // Set the border radius value
                                        ),
                                        primary: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        //   padding:
                                        //       EdgeInsets.symmetric(horizontal: 100.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 64.0,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? const Icon(Icons.add_a_photo, size: 40.0)
                            : null,
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              SingleChildScrollView(
                child: Container(
                  width: 320,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _mobilenumbercontroller,
                          decoration: InputDecoration(
                            suffix: InkWell(
                              child: Text("change",
                                  style: TextStyle(color: Colors.red.shade600)),
                              onTap: () {
                                globalservice.navigate(
                                    context, changeMobileNumber());
                              },
                            ),
                            labelText: 'Mobile Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          validator: (value) {
                            if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                .hasMatch(value.toString())) {
                              return 'Please enter a valid email';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        DropdownButtonFormField(
                          value: _selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue! as String;
                            });
                          },
                          items: items
                              .map((e) => DropdownMenuItem(
                                    child: Container(child: Text(e)),
                                    value: e,
                                  ))
                              .toList(),
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),

                          decoration: InputDecoration(
                            labelText: "Gender",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          // items: const [
                          //   DropdownMenuItem<Gender>(
                          //     value: Gender.Male,
                          //     child: Text('Male'),
                          //   ),
                          //   DropdownMenuItem<Gender>(
                          //     value: Gender.Female,
                          //     child: Text('Female'),
                          //   ),
                          //   DropdownMenuItem<Gender>(
                          //     value: Gender.Other,
                          //     child: Text('Other'),
                          //   ),
                          // ],
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: () {
                            // Save profile changes
                            _saveProfileChanges();
                          },
                          child: const Text('Save Changes'),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfileChanges() async {
    if (_formKey.currentState!.validate()) {
      final _db = FirebaseFirestore.instance;
      // Save the changes made to the user's profile
      String name = _nameController!.text;
      String email = _emailController!.text;

      String mobilenumber = _mobilenumbercontroller!.text;
      String gender = _selectedGender;

      String userKey = globalservice.getCurrentUserKey();
      await _db
          .collection("user")
          .doc(userKey)
          .update({'userName': name, "email": email, 'gender': gender});

      // Perform the necessary actions to save the changes
      // to the user's profile, such as making an API request.
      Get.snackbar("Success", "Profile changes saved.",
          colorText: Colors.black);
      // Show a snackbar or navigate back to the previous screen
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Profile changes saved.'),
      //   ),
    }
  }
}
