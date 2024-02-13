import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/model/employee_model.dart';
import '../../../../utils/status.dart';
import '../../../components/custom_app_bar.dart';
import 'add_employee_bloc.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailOrPhoneNumberController = TextEditingController();

  late AddEmployeeBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<AddEmployeeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Yangi hodim qo'shish",
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocConsumer<AddEmployeeBloc, AddEmployeeState>(
              listener: (context, state) {
                if (state.status == Status.SUCCESS) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(children: [
                        const SizedBox(height: 12),
                        TextField(
                          controller: nameController,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            labelText: 'Ismi',
                            hintStyle: GoogleFonts.poppins(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            isDense: true,
                          ),
                          maxLines: 1,
                          maxLength: 20,
                        ),
                        TextField(
                          controller: emailOrPhoneNumberController,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            labelText: 'Telefon raqam yoki email pochta',
                            hintStyle: GoogleFonts.poppins(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            isDense: true,
                          ),
                          inputFormatters: const <TextInputFormatter>[

                          ],
                          maxLength: 30,
                          maxLines: 1,
                        ),
                      ]),
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
                                nameController.text.isNotEmpty &&
                                emailOrPhoneNumberController.text.length > 5
                              ) {
                                bloc.add(AddEmployee(EmployeeModel(
                                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                                    name: nameController.text,
                                    emailOrPhoneNumber: emailOrPhoneNumberController.text
                                )));
                              } else {
                                ScaffoldMessenger
                                    .of(context)
                                    .showSnackBar(const SnackBar(content: Text("Hamma ma'lumot to'ldirilmagan")));
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
            )
        )
    );
  }
}
