import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testt_api/state.dart';

import 'data.dart';
import 'model.dart';


class ContactCubit extends Cubit<ContactState> {
  final ContactRepository repository;

  ContactCubit(this.repository) : super(ContactInitial());

  Future<void> sendContact({
    required String fullName,
    required String email,
    required String message,
  }) async {
    emit(ContactLoading());

    try {
      final response = await repository.sendContactRequest(
        ContactRequestModel(fullName: fullName, email: email, message: message),
      );

      emit(ContactSuccess(
        apiMessage: response['message'] ?? "Request sent successfully",
        responseData: response['data'],
      ));
    } on DioException catch (e) {

      final errorMessage = e.response?.data['message'] ??
          "Something went wrong";
      emit(ContactFailure(errorMessage));
    } catch (e) {
      emit(ContactFailure("Unexpected error: $e"));
    }
  }
}
