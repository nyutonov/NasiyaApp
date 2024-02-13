import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasiya_app/data/model/client_model.dart';

import '../../../utils/my_utils.dart';
import '../../../utils/status.dart';
import '../../components/custom_app_bar.dart';
import 'add_client_bloc.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController(text: '+998 ');

  late AddClientBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<AddClientBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Yangi mijoz qo'shish",
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocConsumer<AddClientBloc, AddClientState>(
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
                          controller: phoneNumberController,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            labelText: 'Telefon raqami',
                            hintStyle: GoogleFonts.poppins(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            isDense: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            PhoneNumberTextInputFormatter()
                          ],
                          maxLength: 17,
                          maxLines: 1,
                          keyboardType: TextInputType.phone,
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
                                  phoneNumberController.text.length == 17
                              ) {
                                bloc.add(AddClient(ClientModel(
                                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                                  name: nameController.text,
                                  phoneNumber: phoneNumberController.text
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