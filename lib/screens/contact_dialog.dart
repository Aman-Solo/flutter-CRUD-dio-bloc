import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';

class ContactDialog extends StatefulWidget {
  final Contact? contact; //if null => we create, if passing a contact => we editing.
  const ContactDialog({Key? key, this.contact}) : super(key : key);

  @override
  State<ContactDialog> createState() => _ContactDialogState();
}
class _ContactDialogState extends State<ContactDialog>{
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState(){
    super.initState();
    // fill the controllers with current data if we are editing
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
  }
  @override
  Widget build(BuildContext context){
    final isEditing = widget.contact != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Contacct' : 'New Contact'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v!.isEmpty ? 'Enter a name' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v!.isEmpty ? 'Enter an email' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (v) => v!.isEmpty ? 'Enter a phone number' : null,
              ),
            ],
          ),
        ),
      ),
      actions:[
        TextButton(
          onPressed: ()=> Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: (){
            if (_formKey.currentState!.validate()){
              final newContact = Contact(
                id: widget.contact?.id,  // keep old ID if editing or let API handle it
                name: _nameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
              );

              // tell the Bloc what to do
              if (isEditing){
                context.read<ContactBloc>().add(UpdateContact(newContact));
              } else {
                context.read<ContactBloc>().add(AddContact(newContact));
              }
              Navigator.of(context).pop(); // closing the dialig safely
            }
          },
          child: Text(isEditing ? 'Save Changes' : 'Create'),
        ),
      ],
    );
  }
}