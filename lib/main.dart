import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/contact_repository.dart';
import 'bloc/contact_bloc.dart';
import 'bloc/contact_event.dart';
import 'screens/contact_list_screen.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){  //wraping our App in a BlocProvider so the ContactBloc is accessible from anywhere in the widget tree
    return BlocProvider(
      // start the background fetching exactly when the app is created
      create: (context)=>ContactBloc(
        repository: ContactRepository(),
      )..add(LoadContacts()),

      child: MaterialApp(
        title: 'Contact List App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const ContactListScreen(),
      ),
    );
  }
}