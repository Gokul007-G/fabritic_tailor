class Customer {
  final int? id;
  final String? customerCode;
  final String? name;
  final String? contactNumber;
  final String? password;
  final String? alternateContact;
  final String? whatsappNumber;
  final String? emailId;
  final String? city;
  final String? reference;
  final DateTime? dob;
  final DateTime? doa;
  final DateTime? createdAt;

  Customer({
    this.id,
    this.customerCode,
    this.name,
    this.contactNumber,
    this.password,
    this.alternateContact,
    this.whatsappNumber,
    this.emailId,
    this.city,
    this.reference,
    this.dob,
    this.doa,
    this.createdAt,
  });

  // Factory constructor to create Customer from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int?,
      customerCode: json['customer_code'] as String,
      name: json['name'] as String,
      contactNumber: json['contact_number'] as String,
      password: json['password'] as String,
      alternateContact: json['alternate_contact'] as String?,
      whatsappNumber: json['whatsapp_number'] as String?,
      emailId: json['email_id'] as String?,
      city: json['city'] as String?,
      reference: json['reference'] as String?,
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      doa: json['doa'] != null ? DateTime.parse(json['doa']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  // Convert Customer object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_code': customerCode,
      'name': name,
      'contact_number': contactNumber,
      'password': password,
      'alternate_contact': alternateContact,
      'whatsapp_number': whatsappNumber,
      'email_id': emailId,
      'city': city,
      'reference': reference,
      'dob': dob?.toIso8601String(),
      'doa': doa?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
