import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nasiya_app/data/model/sale_model.dart';
import 'package:nasiya_app/presentation/components/custom_app_bar.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../data/model/client_model.dart';
import '../../../utils/status.dart';
import 'add_payment_bloc.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({super.key});

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  late AddPaymentBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<AddPaymentBloc>(context);
    bloc.add(Init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Yangi to\'lov qo\'shish',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<AddPaymentBloc, AddPaymentState>(
          listener: (context, state) {
            if (state.status == Status.SUCCESS) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                if (state.statusData == Status.LOADING) const Center(
                  child: CircularProgressIndicator(),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      TextField(
                        style: GoogleFonts.poppins(),
                        controller: TextEditingController(text: state.selectedClient?.name),
                        decoration: InputDecoration(
                          labelText: 'Mijoz',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          suffixIcon: PopupMenuButton<ClientModel>(
                            icon: const Icon(Icons.expand_more),
                            itemBuilder: (context) => [
                              for (ClientModel client in state.clients ?? [])
                                if ((state.selectedClient?.id ?? '') != client.id)
                                  PopupMenuItem(
                                    onTap: () {
                                      bloc.add(SelectClient(client));
                                    },
                                    child: Text('${client.name}'),
                                  )
                            ],
                          ),
                          isDense: true,
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        style: GoogleFonts.poppins(),
                        controller: TextEditingController(text: state.selectedProduct?.name),
                        decoration: InputDecoration(
                          labelText: 'Mahsulot',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          suffixIcon: PopupMenuButton<SaleModel>(
                            icon: const Icon(Icons.expand_more),
                            itemBuilder: (context) => [
                              for (SaleModel sale in state.sales ?? [])
                                if ((state.selectedProduct?.id ?? '') != sale.id)
                                  PopupMenuItem(
                                    onTap: () {
                                      bloc.add(SelectProduct(sale));
                                    },
                                    child: Text('${sale.name}'),
                                  )
                            ],
                          ),
                          isDense: true,
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 8,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 4,
                              child: TextField(
                                onChanged: (value) => bloc.add(ChangeQuantity(int.tryParse(value) ?? 0)),
                                style: GoogleFonts.poppins(),
                                decoration: InputDecoration(
                                    labelText: 'To\'lanayotgan miqdor',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    isDense: true
                                ),
                                maxLines: 1,
                                maxLength: 10,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              flex: 2,
                              child: TextField(
                                style: GoogleFonts.poppins(),
                                controller: TextEditingController(text: state.selectedProduct?.moneyType),
                                decoration: InputDecoration(
                                  labelText: 'Pul birligi',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  isDense: true,
                                ),
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      TextField(
                        style: GoogleFonts.poppins(),
                        controller: TextEditingController(text: state.selectedPaymentType),
                        decoration: InputDecoration(
                          labelText: 'To\'lov turi',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(Icons.expand_more),
                            itemBuilder: (context) => [
                              for (String paymentType in Constants.paymentTypes)
                                PopupMenuItem(
                                  onTap: () => bloc.add(SelectPaymentType(paymentType)),
                                  child: Text(paymentType),
                                )
                            ],
                          ),
                          isDense: true,
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 48),
                      TextField(
                        style: GoogleFonts.poppins(),
                        controller: TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now())),
                        decoration: InputDecoration(
                          labelText: 'To\'lov qilinayotgan sana',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          isDense: true,
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        style: GoogleFonts.poppins(),
                        controller: TextEditingController(text: 'Shahriyor'),
                        decoration: InputDecoration(
                          labelText: 'To\'lovni qabul qilayotgan hodim',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          isDense: true,
                        ),
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          if (
                            state.selectedClient == null ||
                            state.quantity == null ||
                            state.selectedPaymentType == null ||
                            state.selectedProduct == null
                          ) {
                            ScaffoldMessenger
                                .of(context)
                                .showSnackBar(const SnackBar(content: Text("Hamma ma'lumot to'ldirilmagan")));
                          } else {
                            bloc.add(AddPayment());
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColorDark
                            )
                        ),
                        child: (state.status == Status.LOADING)
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                          "Qo'shish",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
