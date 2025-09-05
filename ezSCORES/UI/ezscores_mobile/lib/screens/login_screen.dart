import 'package:ezscores_mobile/providers/UserProvider.dart';
import 'package:ezscores_mobile/providers/auth_provider.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';
import 'package:ezscores_mobile/screens/main_navigation_screen.dart';
import 'package:ezscores_mobile/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>
{
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController  = TextEditingController();
  bool _obscurePassword = true;
   @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  "assets/images/ezlogo5.png",
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Korisničko ime",
                  prefixIcon: const Icon(Icons.supervised_user_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Lozinka",
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    AuthProvider.username = _usernameController.text;
                    AuthProvider.password = _passwordController.text;
                    try {
                      var userProvider = UserProvider();
                      var user = await userProvider.login(
                        AuthProvider.username,
                        AuthProvider.password,
                      );
                      AuthProvider.id = user.id;
                      AuthProvider.firstName = user.firstName;
                      AuthProvider.lastName = user.lastName;
                      AuthProvider.userName = user.userName;
                      AuthProvider.picture = user.picture;
                      AuthProvider.email = user.email;
                      AuthProvider.phoneNumber = user.phoneNumber;
                      AuthProvider.organization = user.organization;
                      AuthProvider.roleID = user.role?.id;
                      AuthProvider.roleName = user.role?.name;
                      AuthProvider.roleDecription = user.role?.description;

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => MainNavigationScreen()),
                      );
                    } on UserException catch (exception) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Greška prilikom prijave"),
                          content: Text(exception.exMessage),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Prijavi se",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: const Text(
                  "Nemate račun? Kreirajte ga ovdje!",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainNavigationScreen()),
                  );
                },
                child: const Text(
                  "Nastavi kao gost",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}