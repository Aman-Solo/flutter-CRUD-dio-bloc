import 'package:equatable/equatable.dart';
import '../models/contact_model.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
  @override
  List<Object> get props => [];
}

// called when we want to fetch list of contacts from API
class LoadContacts extends ContactEvent {}

// called when we want to add a new contact
class AddContact extends ContactEvent{
  final Contact contact;
  const AddContact(this.contact);

  @override
  List<Object> get props => [contact];
}
// called when we want to edit an existing contact
class UpdateContact extends ContactEvent{
  final Contact contact;
  const UpdateContact(this.contact);

  @override
  List<Object> get props => [contact];
}
// called when we want to delte a contact
class DeleteContact extends ContactEvent{
  final int contactId;
  const DeleteContact(this.contactId);

  @override
  List<Object> get props => [contactId];
}