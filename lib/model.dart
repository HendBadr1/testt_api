class ContactRequestModel {
  final String fullName;
  final String email;
  final String message;

  ContactRequestModel({
    required this.fullName,
    required this.email,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "message": message,
    };
  }
}
