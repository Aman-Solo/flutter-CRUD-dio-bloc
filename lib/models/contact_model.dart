import 'package:equatable/equatable.dart';
class Contact extends Equatable {
  final int? id;
  final String name;
  final String email;
  final String phone;

  const Contact({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });
  factory Contact.fromJson(Map<String, dynamic> json){
    return Contact(
      id: json['id'] as int?,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
  Map<String, dynamic> toJson(){
    return{
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
  Contact copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
  @override
  List<Object?> get props => [id, name, email, phone];
  } 
