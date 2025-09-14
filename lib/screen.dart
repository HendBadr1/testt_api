import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testt_api/state.dart';

import 'cubit.dart';

class RequestContactScreen extends StatefulWidget {
  const RequestContactScreen({Key? key}) : super(key: key);

  @override
  State<RequestContactScreen> createState() => _RequestContactScreenState();
}

class _RequestContactScreenState extends State<RequestContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Request Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ContactCubit, ContactState>(
          listener: (context, state) {
            if (state is ContactSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.apiMessage)),
              );
              _nameController.clear();
              _emailController.clear();
              _messageController.clear();
            } else if (state is ContactFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Please enter your name" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Please enter your email" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: "Your Message",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Please enter your message" : null,
                  ),
                  const SizedBox(height: 20),
                  state is ContactLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ContactCubit>().sendContact(
                          fullName: _nameController.text,
                          email: _emailController.text,
                          message: _messageController.text,
                        );
                      }
                    },
                    child: const Text("Send Message"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
