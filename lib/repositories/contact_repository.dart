import 'package:dio/dio.dart';
import '../models/contact_model.dart';

class ContactRepository {
  final Dio _dio;

  final String _baseUrl = 'https://jsonplaceholder.typicode.com/users';
  ContactRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<Contact>> fetchContacts() async {
    try{
      final response = await _dio.get(_baseUrl);
      List<dynamic> data = response.data;
      return data.map((json) => Contact.fromJson(json)).toList();
    } on DioException catch (e){
      throw Exception('Failed to load contacts: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
  Future<Contact> createContact(Contact contact) async{
    try{
      final response = await _dio.post(
        _baseUrl,
        data: contact.toJson(),
      );
      return Contact.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception ('Failed to create contact: ${e.message}');
    }
  }
  Future<Contact> updateContact(Contact contact) async {
    try{
      if (contact.id == null) throw Exception("Contact ID cannot be null for updates ");
      final response = await _dio.put(
        '$_baseUrl/${contact.id}',
        data: contact.toJson(),
      );
      return Contact.fromJson(response.data);
    } on DioException catch(e){
      throw Exception('Failed to update contact: ${e.message}');
    }
  }
  Future<void> deleteContact(int id) async{
    try{
      await _dio.delete('$_baseUrl/$id');
    }on DioException catch(e){
      throw Exception('Failed to delete contact: ${e.message}');
    }
  }
}