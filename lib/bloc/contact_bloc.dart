import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState>{
  final ContactRepository repository;
  ContactBloc({required this.repository}) : super(ContactInitial()){
    // Registering event handlers
    on<LoadContacts>(_onLoadContacts);
    on<AddContact>(_onAddContact);
    on<UpdateContact>(_onUpdateContact);
    on<DeleteContact>(_onDeleteContact); 
  }
  // Handle loading COntacts
  Future<void> _onLoadContacts(LoadContacts event, Emitter<ContactState> emit) async{
    emit(ContactLoading());
    try{
      final contacts = await repository.fetchContacts();
      emit(ContactLoaded(contacts));
    } catch (e){
      emit(ContactError(e.toString()));
    }
  }
  // handle adding a new contact
  Future<void> _onAddContact(AddContact event, Emitter<ContactState> emit) async{
    if (state is ContactLoaded){
      final currentState = state as ContactLoaded;
      try{
        final newContact = await repository.createContact(event.contact);
        emit(ContactLoaded([...currentState.contacts, newContact]));
      }catch (e){
        emit(ContactError(e.toString()));
      }
    }
  }
  // handle updating a contact
  Future<void> _onUpdateContact(UpdateContact event, Emitter<ContactState> emit) async{
    if (state is ContactLoaded){
      final currentState = state as ContactLoaded;
      try{
        final updatedContact = await repository.updateContact(event.contact);
        final updateContacts = currentState.contacts.map((c){
          return c.id == updatedContact.id ? updatedContact : c;
        }).toList();
        emit(ContactLoaded(updateContacts));
      }catch (e){
        emit(ContactError(e.toString()));
      }
    }
  }
  // handle deleting a contact
  Future<void> _onDeleteContact(DeleteContact event, Emitter<ContactState> emit) async{
    if(state is ContactLoaded){
      final currentState = state as ContactLoaded;
      try{
        await repository.deleteContact(event.contactId);
        final updateContacts = currentState.contacts.where((c) => c.id != event.contactId). toList();
        emit(ContactLoaded(updateContacts));
      }catch (e){
        emit(ContactError(e.toString()));
      }
    }
  }
}