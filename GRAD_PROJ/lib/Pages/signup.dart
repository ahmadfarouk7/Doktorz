import 'package:flutter/material.dart';
import 'package:gradproject/Pages/Login.dart';
import 'package:gradproject/Pages/SignUpT.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

void _navigateToSecondSignUpPage(
    BuildContext context, Map<String, dynamic> userData) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUpT(userData: userData)),
  );
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String selectedGender = '';
  String selectedAge = '';

  final listItem = ["male", "female"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xFF3D8888),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0, bottom: 40),
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 27),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 27),
                child: Text(
                  ' Get ready to experience something amazing.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 35, bottom: 30, right: 35),
                      child: TextFormField(
                        controller: fullNameController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Full name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          errorStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromARGB(255, 255, 20, 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 35, bottom: 30, right: 35),
                      child: TextFormField(
                        controller: ageController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          errorStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromARGB(255, 255, 20, 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 35, bottom: 30, right: 35),
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          errorStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromARGB(255, 255, 20, 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 35, bottom: 30, right: 35),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors
                            .white, // Set dropdown background color to white
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                        icon: const Icon(
                          Icons.arrow_drop_down, // Icon for the drop-down arrow
                          color: Colors
                              .white, // Set the color of the drop-down icon
                        ),
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(25), // Set border radius
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(25), // Set border radius
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        items: listItem.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return listItem.map<Widget>((String value) {
                            return Text(
                              selectedGender.isEmpty
                                  ? 'Select Gender'
                                  : selectedGender,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If form is valid, collect user input
                        Map<String, dynamic> userData = {
                          'fullName': fullNameController.text,
                          'email': emailController.text,
                          'gender': selectedGender,
                          'age': int.parse(ageController.text),
                        };
                        // Navigate to the second sign-up page and pass user data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUpT(userData: userData)),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 0,
                      backgroundColor:
                          const Color.fromRGBO(203, 203, 203, 0.38),
                      minimumSize: const Size(130, 40),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account ? ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          color: Color(0xFFFFF400),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
