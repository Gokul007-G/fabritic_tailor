class User {
  final int? id;
  final String branchId;
  final String name;
  final String? empCode;
  final String? mobileNumber;
  final String? password;
  final DateTime? createdAt;
  final String? userRole;

  User({
    this.id,
    required this.branchId,
    required this.name,
    this.empCode,
    this.mobileNumber,
    this.password,
    this.createdAt,
    this.userRole,
  });

  // Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      branchId: json['branch_id'] as String,
      name: json['name'] as String,
      empCode: json['emp_code'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      password: json['password'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      userRole: json['user_role'] as String?,
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branch_id': branchId,
      'name': name,
      'emp_code': empCode,
      'mobile_number': mobileNumber,
      'password': password,
      'created_at': createdAt?.toIso8601String(),
      'user_role': userRole,
    };
  }
}
