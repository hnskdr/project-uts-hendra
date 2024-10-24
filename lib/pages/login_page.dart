import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Masuk"),
        backgroundColor: Colors.orange,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 40),
                const Icon(
                  Icons.person, size: 80),
                const SizedBox(
                  height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Email Diperlukan'),
                    EmailValidator(errorText: 'Masukkan Alamat Email yang Benar'),
                  ]).call,
                ),
          
                const SizedBox(height: 20,),
          
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: RequiredValidator(errorText: 'Password Diperlukan').call,
                ),
          
                const SizedBox(height: 40),
                
                ElevatedButton(
                  onPressed: () {
                    
                    if (_formKey.currentState!.validate()) {
                      bool loginSuccess = false;
                      String? fullname;
          
                      for (var user in registeredUsers) {
                        if (user.email == _emailController.text &&
                            user.password == _passwordController.text) {
                          loginSuccess = true;
                          fullname = user.fullName;
                          break;
                        }
                      }
          
                      if (loginSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage(fullname: fullname.toString())),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email atau Password Salah')),
                        );
                      }
                    }
                  },
                  child: const Text("Masuk"),
                ),
                
                const SizedBox(height: 20,),
                
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text("Belum Memiliki Akun? Daftar Sekarang"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
