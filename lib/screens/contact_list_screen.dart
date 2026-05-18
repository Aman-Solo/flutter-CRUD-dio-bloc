import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_state.dart';
import '../bloc/contact_event.dart';
import '../models/contact_model.dart';
import 'contact_dialog.dart';

class ContactListScreen extends StatelessWidget {
    const ContactListScreen({Key? key}): super(key: key);

    void _showContactDialog(BuildContext context, {Contact? contact}){
        showDialog(
            context: context,
            builder: (context) => ContactDialog(contact: contact),
        );
    }
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: const Text('Contacts Manager'),
            ),
            // BlocBuilder listens to state change and rebuilds only this part of the UI
            body: BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state){
                    if (state is ContactLoading || state is ContactInitial){
                        return const Center(child: CircularProgressIndicator());
                    }else if (state is ContactError){
                        return Center(child: Text('Error: ${state.message}'));
                    }else if (state is ContactLoaded){
                        if(state.contacts.isEmpty){
                            return const Center(child: Text('No Contacts Found'));
                        }
                        //Build the List
                        return ListView.builder(
                            itemCount: state.contacts.length,
                            itemBuilder: (context, index){
                                final contact = state.contacts[index];
                                return ListTile(
                                    leading: CircleAvatar(
                                        child: Text(contact.name.isNotEmpty ? contact.name[0].toUpperCase(): '?'),
                                    ),
                                    title: Text(contact.name),
                                    subtitle: Text('${contact.email}\n${contact.phone}'),
                                    isThreeLine: true,
                                    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            //edit button
                                            IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.blue),
                                                onPressed: () => _showContactDialog(context, contact: contact),
                                            ),
                                            // delete button
                                            IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.blue),
                                                onPressed: () {
                                                    context.read<ContactBloc>().add(DeleteContact(contact.id!));
                                                },
                                            ),
                                        ],
                                    ),
                                );
                            },
                        );
                    }
                    return const SizedBox.shrink(); // fallback empty screen
                },
            ),
            // the Add button
            floatingActionButton: FloatingActionButton(
                onPressed: ()=> _showContactDialog(context),
                child: const Icon(Icons.add),
            ),
        );
    }
}