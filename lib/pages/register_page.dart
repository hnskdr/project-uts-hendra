import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_uts_hendra/models/user.dart';

List<User> registeredUsers = [];

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Pendaftaran"),
        backgroundColor: Colors.orange,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 80,),
          
                const SizedBox(height: 20,),
          
                TextFormField(
                  controller: _fullnameController,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
                  validator:
                      RequiredValidator(errorText: 'Nama Lengkap Diperlukan').call,
                ),
          
                const SizedBox(height: 20,),
          
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
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Password Diperlukan'),
                    MinLengthValidator(8,
                        errorText: 'Password Harus Terdiri Dari Minimal 8 Digit'),
                  ]).call,
                ),
          
                const SizedBox(height: 20,),
          
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration:
                      const InputDecoration(labelText: 'Konfirmasi Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Password Tidak Sesuai';
                    }
                    return null;
                  },
                ),
          
                const SizedBox(height: 40),
          
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registeredUsers.add(User(
                          fullName: _fullnameController.text,
                          email: _emailController.text,
                          password: _passwordController.text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pendaftaran Berhasil!')),
                      );
          
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  child: const Text("Daftar"),
                ),
          
                const SizedBox(height: 20,),
          
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Sudah Memiliki Akun? Masuk Sekarang"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
