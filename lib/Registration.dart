import 'package:flutter/material.dart';
import 'package:form_offline_db/Login.dart';
import 'package:intl/intl.dart';

import 'Database/sqflite.dart';

enum genderSelect {Male, Female}
class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>
{
  List<Widget>addWidgetsList = [];
  List<Map<String,dynamic>> addNotebookDataList = [];
  Future<void>addData()async{
    await SQLiteDatabase.createData(firstName.text, lastName.text, address.text, city.text, email.text, password.text, confirmPassword.text, mobileNo.text);
    _refreshData();
  }

  void _refreshData() async {
    final data = await SQLiteDatabase.getAllData();
    setState(() {
      addNotebookDataList = data;
    });
  }

  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  final _formKey = GlobalKey<FormState>();
  genderSelect _gender = genderSelect.Male;
  DateTime selectedDate = DateTime.now();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController mobileNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Text("Registration"),
                TextFormField(
                  controller: firstName,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "First Name",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                      {
                        return "Enter FirstName";
                      }
                  },
                ),
                TextFormField(
                  controller: lastName,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "Last Name",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return "Enter LastName";
                    }
                  },
                ),
                TextFormField(
                  controller: dob,
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                    labelText: "Date of Birth",
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return "Enter Date of Birth";
                    }
                  },
                  onTap: () async{
                  DateTime? pickedDate = await showDatePicker(
                  context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),    //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

                  if(pickedDate != null ){
                  print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                  dob.text = formattedDate; //set output date to TextField value.
                  });
                    // _selectDate(context);
                  }
                  }
                ),

                TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                    icon: Icon(Icons.home),
                    labelText: "Address",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return "Enter Address";
                    }
                  },
                ),
                TextFormField(
                  controller: city,
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_on),
                    labelText: "City",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return "Enter City";
                    }
                  },
                ),
                Row(
                    children: [
                      SizedBox(width: 50,),
                      Text("Male"),
                      Radio(
                    value: genderSelect.Male,
                    groupValue: _gender,
                    onChanged: (genderSelect? value)
                    {
                      setState(() {
                        _gender = value!;
                      });
                    }
                ),
                      Text("Female"),
                      Radio(
                    value: genderSelect.Female,
                    groupValue: _gender,
                    onChanged: (genderSelect? value)
                    {
                      setState(() {
                        _gender = value!;
                      });
                    }),
                ]),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return "Enter EmailID";
                    }
                    else if(!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value))
                      {
                        return "Please Enter Valid Email";
                      }
                  },
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_on),
                    labelText: "Password",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return "Enter Password";
                    }
                    else if(!RegExp(r"(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$").hasMatch(value))
                      {
                        return "Please Enter Password with at least eight characters, including at least one number and includes both lower and uppercase letters and special characters, for example #, ?, !.";
                      }
                  },
                ),
                TextFormField(
                  controller: confirmPassword,
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_on),
                    labelText: "ConfirmPassword",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return "Enter ConfirmPassword";
                    }
                  },
                ),
                TextFormField(
                  controller: mobileNo,
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_on),
                    labelText: "MobileNo",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return "Enter MobileNo";
                    }
                  },
                ),
              // Checkbox(
              //   checkColor: Colors.white,
              //   value: isChecked,
              //   onChanged: (bool? value) {
              //     setState(() {
              //       isChecked = value!;
              //     });
              //   },
              // ),
                Row(
                  children: [
                    SizedBox(width: 50,),
                    Text("Hobbies:"),
                    SizedBox(width: 30,),
                    myCheckBox(
                        text: "Dancing",
                        value: isChecked,
                        onChanged:(value){
                        setState(() {
                              isChecked = value!;
                            });
                        } ),
                    myCheckBox(
                        text: "Cooking",
                        value: isChecked1,
                        onChanged:(value){
                          setState(() {
                            isChecked1 = value!;
                          });
                        } ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 130,),
                    myCheckBox(
                        text: "Travelling",
                        value: isChecked2,
                        onChanged:(value){
                        setState(() {
                              isChecked2 = value!;
                            });
                        } ),


                    myCheckBox(
                    text: "Singing",
                    value: isChecked3,
                    onChanged:(value){
                      setState(() {
                        isChecked3 = value!;
                      });
                    } ),
                ]
                ),

                ElevatedButton(
                    onPressed: ()
                    {
                      if(_formKey.currentState!.validate())
                        {
                          addData();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        }
                    },
                    child: Text("Register")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _selectDate(BuildContext context) async
  {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1907),
        lastDate: DateTime(2100));
    if(picked != null && picked != selectedDate)
      {
        setState(() {
          selectedDate = picked;
        });
      }
  }

  Widget myCheckBox({
    required String text,
    Color? checkColor,
    required bool? value,
    required void Function(bool?)? onChanged})

  {
    return Row(
      children: [
        Text(text),
        Checkbox(
          checkColor: checkColor,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

