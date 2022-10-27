

import 'package:inmobiliariaapp/domain/entities/user.dart';
class AdministratorRequestAgent{
  String id;
  User administrator;
  String requestDate;
  String responseDate;
  String requestType;
  String response;
  String observations;
  String requestBackupLink;
  String responseBackupLink;
  bool requestFinished;
  int month;
  String paymentMedium;
  int planNumber;
  int paymentAmount;
  AdministratorRequestAgent({
    required this.id,
    required this.administrator,
    required this.requestDate,
    required this.responseDate,
    required this.requestType,
    required this.response,
    required this.observations,
    required this.requestBackupLink,
    required this.responseBackupLink,
    required this.requestFinished,
    required this.month,
    required this.paymentMedium,
    required this.planNumber,
    required this.paymentAmount
  });
}