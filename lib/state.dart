abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {
  final String apiMessage;
  final dynamic responseData;

  ContactSuccess({required this.apiMessage, this.responseData});
}

class ContactFailure extends ContactState {
  final String message;


  ContactFailure(this.message);
}
