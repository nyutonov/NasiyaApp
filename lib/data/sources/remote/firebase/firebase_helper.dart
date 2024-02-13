import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nasiya_app/data/model/employee_model.dart';
import 'package:nasiya_app/data/model/sale_model.dart';

import '../../../model/client_model.dart';
import '../../../model/payment_model.dart';

class FirebaseHelper {
  final _firestore = FirebaseFirestore.instance;

  Future<List<SaleModel>> getAllSales() async {
    final querySnapshot = await _firestore
        .collection('sales')
        .get();

    return List.generate(
        querySnapshot.docs.length,
        (index) => SaleModel.fromJson(
            querySnapshot.docs[index],
            querySnapshot.docs[index].id
        )
    );
  }

  Future<List<ClientModel>> getAllClients() async {
    final querySnapshot = await _firestore
        .collection('clients')
        .get();

    return List.generate(
        querySnapshot.docs.length,
        (index) => ClientModel.fromJson(
          querySnapshot.docs[index],
          querySnapshot.docs[index].id
        )
    );
  }

  Future<List<EmployeeModel>> getAllEmployees() async {
    final querySnapshot = await _firestore
        .collection('employees')
        .get();

    return List.generate(
        querySnapshot.docs.length,
            (index) => EmployeeModel.fromJson(
            querySnapshot.docs[index],
            querySnapshot.docs[index].id
        )
    );
  }

  Future<List<PaymentModel>> getAllPayments() async {
    final querySnapshot = await _firestore
        .collection('payments')
        .get();

    return List.generate(
        querySnapshot.docs.length,
            (index) => PaymentModel.fromJson(
            querySnapshot.docs[index],
            querySnapshot.docs[index].id
        )
    );
  }

  Future<List<SaleModel>> getAllSalesByClient(String clientId) async {
    final querySnapshot = await _firestore
        .collection('sales')
        .get();

    final sales = List.generate(
        querySnapshot.docs.length,
            (index) => SaleModel.fromJson(
            querySnapshot.docs[index],
            querySnapshot.docs[index].id
        )
    );

    sales.removeWhere((element) => element.clientId != clientId);

    return sales;
  }

  Future<List<PaymentModel>> getAllPaymentsBySale(String saleId) async {
    final querySnapshot = await _firestore
        .collection('payments')
        .get();

    final payments = List.generate(
        querySnapshot.docs.length,
            (index) => PaymentModel.fromJson(
            querySnapshot.docs[index],
            querySnapshot.docs[index].id
        )
    );

    payments.removeWhere((element) => element.saleId != saleId);

    return payments;
  }

  Future<List<PaymentModel>> getAllPaymentsByClient(String clientId) async {
    final querySnapshot = await _firestore
        .collection('payments')
        .get();

    final payments = List.generate(
        querySnapshot.docs.length,
            (index) => PaymentModel.fromJson(
            querySnapshot.docs[index],
            querySnapshot.docs[index].id
        )
    );

    payments.removeWhere((element) => element.clientId != clientId);

    return payments;
  }

  addClient(ClientModel clientModel) async {
    await _firestore
        .collection('clients')
        .doc(clientModel.id)
        .set(clientModel.toJson());
  }

  addSale(SaleModel saleModel) async {
    await _firestore
        .collection('sales')
        .doc(saleModel.id)
        .set(saleModel.toJson());
  }

  addEmployee(EmployeeModel employeeModel) async {
    await _firestore
        .collection('employees')
        .doc(employeeModel.id)
        .set(employeeModel.toJson());
  }

  addPayment(PaymentModel paymentModel) async {
    await _firestore
        .collection('payments')
        .doc(paymentModel.id)
        .set(paymentModel.toJson());
  }
}