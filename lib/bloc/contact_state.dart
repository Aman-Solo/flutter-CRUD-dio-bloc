import 'package:equatable/equatable.dart';
import '../models/contact_model.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}
class ContactInitial extends ContactState {}  // initial state before anything happening

class ContactLoading extends ContactState {} // a loading spinner while fetching data

// holds the sucessful list of contacts to display on the screen
class ContactLoaded extends ContactState {
  final List<Contact> contacts;
  const ContactLoaded(this.contacts);

  @override
  List<Object> get props => [contacts];
}

// holds error message if something fails like if no internet or others
class ContactError extends ContactState {
  final String message;
  const ContactError(this.message);

  @override
  List<Object> get props => [message];
}