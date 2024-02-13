import 'package:nasiya_app/data/model/employee_model.dart';
import 'package:nasiya_app/data/model/payment_model.dart';
import 'package:nasiya_app/data/model/sale_model.dart';
import 'package:nasiya_app/data/sources/remote/firebase/firebase_helper.dart';

import '../data/model/client_model.dart';

class AppRepository {
  final _firebaseHelper = FirebaseHelper();

  Future<List<SaleModel>> getAllSales() async =>
      await _firebaseHelper.getAllSales();

  Future<List<ClientModel>> getAllClients() async =>
      await _firebaseHelper.getAllClients();

  Future<List<EmployeeModel>> getAllEmployees() async =>
      await _firebaseHelper.getAllEmployees();

  Future<List<PaymentModel>> getAllPayments() async =>
      await _firebaseHelper.getAllPayments();

  Future<List<SaleModel>> getAllSalesByClient(String clientId) async =>
      await _firebaseHelper.getAllSalesByClient(clientId);

  Future<List<PaymentModel>> getAllPaymentsBySale(String saleId) async =>
      await _firebaseHelper.getAllPaymentsBySale(saleId);

  Future<List<PaymentModel>> getAllPaymentsByClient(String clientId) async =>
      await _firebaseHelper.getAllPaymentsByClient(clientId);

  addClient(ClientModel clientModel) async => await _firebaseHelper.addClient(clientModel);
  addSale(SaleModel saleModel) async => await _firebaseHelper.addSale(saleModel);
  addEmployee(EmployeeModel employeeModel) async => await _firebaseHelper.addEmployee(employeeModel);
  addPayment(PaymentModel paymentModel) async => await _firebaseHelper.addPayment(paymentModel);
}