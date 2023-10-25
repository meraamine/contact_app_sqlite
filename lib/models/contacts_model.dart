class Contact {
  int? id;
  String name;
  String contact;
  String email;

  Contact({this.id, required this.name, required this.contact,required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json['id'],
    name: json['name'],
    contact: json['contact'],
    email: json['email']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'contact': contact,
    'email': email,
  };
}