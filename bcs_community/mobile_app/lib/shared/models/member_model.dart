import 'package:cloud_firestore/cloud_firestore.dart';

class MemberModel {
  final String id;
  final String userId;
  final String fullName;
  final String currentWorkLocation;
  final String currentResidenceLocation;
  final DateTime joiningDate;
  final String designation;
  final DateTime dateOfBirth;
  final String department;
  final String email;
  final String emergencyContact;
  final String? profilePictureUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  MemberModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.currentWorkLocation,
    required this.currentResidenceLocation,
    required this.joiningDate,
    required this.designation,
    required this.dateOfBirth,
    required this.department,
    required this.email,
    required this.emergencyContact,
    this.profilePictureUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      fullName: json['full_name'] ?? '',
      currentWorkLocation: json['current_work_location'] ?? '',
      currentResidenceLocation: json['current_residence_location'] ?? '',
      joiningDate: DateTime.parse(json['joining_date']),
      designation: json['designation'] ?? '',
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      department: json['department'] ?? '',
      email: json['email'] ?? '',
      emergencyContact: json['emergency_contact'] ?? '',
      profilePictureUrl: json['profile_picture_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'full_name': fullName,
      'current_work_location': currentWorkLocation,
      'current_residence_location': currentResidenceLocation,
      'joining_date': joiningDate.toIso8601String(),
      'designation': designation,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'department': department,
      'email': email,
      'emergency_contact': emergencyContact,
      'profile_picture_url': profilePictureUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory MemberModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MemberModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      fullName: data['fullName'] ?? '',
      currentWorkLocation: data['currentWorkLocation'] ?? '',
      currentResidenceLocation: data['currentResidenceLocation'] ?? '',
      joiningDate: (data['joiningDate'] as Timestamp).toDate(),
      designation: data['designation'] ?? '',
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      department: data['department'] ?? '',
      email: data['email'] ?? '',
      emergencyContact: data['emergencyContact'] ?? '',
      profilePictureUrl: data['profilePictureUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'fullName': fullName,
      'currentWorkLocation': currentWorkLocation,
      'currentResidenceLocation': currentResidenceLocation,
      'joiningDate': Timestamp.fromDate(joiningDate),
      'designation': designation,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
      'department': department,
      'email': email,
      'emergencyContact': emergencyContact,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  MemberModel copyWith({
    String? id,
    String? userId,
    String? fullName,
    String? currentWorkLocation,
    String? currentResidenceLocation,
    DateTime? joiningDate,
    String? designation,
    DateTime? dateOfBirth,
    String? department,
    String? email,
    String? emergencyContact,
    String? profilePictureUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MemberModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      currentWorkLocation: currentWorkLocation ?? this.currentWorkLocation,
      currentResidenceLocation: currentResidenceLocation ?? this.currentResidenceLocation,
      joiningDate: joiningDate ?? this.joiningDate,
      designation: designation ?? this.designation,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      department: department ?? this.department,
      email: email ?? this.email,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'MemberModel(id: $id, fullName: $fullName, email: $email, department: $department)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MemberModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
