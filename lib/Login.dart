import 'package:flutter/material.dart';
import 'package:form_offline_db/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>
{
  List<Map<String,dynamic>> addNotebookDataList = [];
  var isLoading = false;
  late SharedPreferences LoginData;
  late bool newUser;

  final _formKey = GlobalKey<FormState>();
  late String email = "";
  late String password = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async
  {
    LoginData = await SharedPreferences.getInstance();
    newUser = (LoginData.getBool('login') ?? true);
    print(newUser);
    if(newUser == false)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  TextFormField(
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
                  ElevatedButton(
                      onPressed: ()
                      {
                        // checkUser();
                        final isValid = _formKey.currentState!.validate();
                        if(!isValid)
                          {
                            return;
                          }
                        else
                          {
                            _formKey.currentState?.save();
                            String emailID = email;
                            String Password = password;

                            if(emailID != "" && Password != "")
                              {
                                print("Success");
                                LoginData.setBool('login', false);
                                LoginData.setString('emailID', emailID);
                                LoginData.setString('Password', Password);
                              }
                          }
                      },
                      child: Text("Login")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // void checkUser()
  // {
  //   for(var i=0; i<addNotebookDataList.length; i++)
  //     {
  //       if(email.toString()==addNotebookDataList[i]["email"] && password.toString()==addNotebookDataList[i]["password"])
  //         {
  //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard()));
  //         }
  //       else
  //         {
  //           print("Enter Valid email and Password");
  //         }
  //     }
  // }

  void checkUser() {
    String storedEmail = LoginData.getString('emailID') ?? "";
    String storedPassword = LoginData.getString('Password') ?? "";

    if (email == storedEmail && password == storedPassword) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      print("Enter Valid email and Password");
    }
  }

}
