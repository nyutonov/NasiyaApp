import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nasiya_app/data/model/client_model.dart';
import 'package:nasiya_app/presentation/components/custom_app_bar.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../utils/status.dart';
import 'add_sale_bloc.dart';

class AddSalePage extends StatefulWidget {
  AddSalePage({super.key});

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  late AddSaleBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<AddSaleBloc>(context);
    bloc.add(Init());
  }

  @override
  void dispose() {
    super.dispose();

    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Yangi sotuv qo'shish",
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocConsumer<AddSaleBloc, AddSaleState>(
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
                          onChanged: (value) => bloc.add(ChangeName(value)),
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                              labelText: 'Nomi',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              isDense: true,
                          ),
                          maxLines: 1,
                          maxLength: 30,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 8,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
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
                                          if (
                                            ((state.selectedGuarantor?.id ?? '') != client.id) &&
                                            ((state.selectedClient?.id ?? '') != client.id)
                                          )
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
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  style: GoogleFonts.poppins(),
                                  controller: TextEditingController(text: state.selectedGuarantor?.name),
                                  decoration: InputDecoration(
                                    labelText: 'Kafil',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    suffixIcon: PopupMenuButton<ClientModel>(
                                      icon: const Icon(Icons.expand_more),
                                      itemBuilder: (context) => [
                                        for (ClientModel client in state.clients ?? [])
                                          if (
                                            ((state.selectedClient?.id ?? '') != client.id) &&
                                            ((state.selectedGuarantor?.id ?? '') != client.id)
                                          )
                                            PopupMenuItem(
                                              onTap: () {
                                                bloc.add(SelectGuarantor(client));
                                              },
                                              child: Text('${client.name}'),
                                            )
                                      ],
                                    ),
                                    isDense: true,
                                  ),
                                  readOnly: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 8,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 4,
                                child: TextField(
                                  onChanged: (value) => bloc.add(ChangePrice(int.tryParse(value) ?? 0)),
                                  style: GoogleFonts.poppins(),
                                  decoration: InputDecoration(
                                    labelText: 'Narxi',
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
                                  controller: TextEditingController(text: state.selectedMoneyType),
                                  decoration: InputDecoration(
                                    labelText: 'Pul birligi',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    suffixIcon: PopupMenuButton<String>(
                                      icon: const Icon(Icons.expand_more),
                                      itemBuilder: (context) => [
                                        for (String client in Constants.moneyTypes)
                                          PopupMenuItem(
                                            onTap: () => bloc.add(SelectMoneyType(client)),
                                            child: Text(client),
                                          )
                                      ],
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
                          onChanged: (value) => bloc.add(ChangePercent(int.tryParse(value) ?? 0)),
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            labelText: 'Foiz',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            isDense: true,
                          ),
                          maxLines: 1,
                          maxLength: 2,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: TextEditingController(
                              text: (state.nasiyaPrice == null)
                                  ? ''
                                  : '${NumberFormat.currency(locale: 'uz').format(state.nasiyaPrice).substring(0, NumberFormat.currency(locale: 'uz').format(state.nasiyaPrice).length - 7)} ${(state.selectedMoneyType != null) ? state.selectedMoneyType : ''}'
                          ),
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            labelText: 'Nasiya narxi',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            isDense: true,
                          ),
                          readOnly: true,
                          maxLines: 1,
                          maxLength: 15,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          onChanged: (value) => bloc.add(ChangeStartingPrice(int.tryParse(value) ?? 0)),
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            labelText: 'Boshlang\'ich to\'lov',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            isDense: true,
                          ),
                          maxLines: 1,
                          maxLength: 10,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 8,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (value) => bloc.add(ChangeCountSale(int.tryParse(value) ?? 0)),
                                  style: GoogleFonts.poppins(),
                                  decoration: InputDecoration(
                                    labelText: 'To\'lovlar soni',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    isDense: true,
                                  ),
                                  maxLines: 1,
                                  maxLength: 2,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(
                                      text: (state.monthlyPrice == null)
                                          ? ''
                                          : '${NumberFormat.currency(locale: 'uz').format(state.monthlyPrice).substring(0, NumberFormat.currency(locale: 'uz').format(state.monthlyPrice).length - 7)} ${state.selectedMoneyType ?? ''}'
                                  ),
                                  style: GoogleFonts.poppins(),
                                  decoration: InputDecoration(
                                    labelText: 'Oylik to\'lov',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    isDense: true,
                                  ),
                                  readOnly: true,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 8,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  style: GoogleFonts.poppins(),
                                  controller: TextEditingController(text: state.startingDate),
                                  decoration: InputDecoration(
                                    labelText: 'Birinchi to\'lov sanasi',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        final picked = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2040),
                                          initialDate: DateFormat('dd-MM-yyyy')
                                              .parse(
                                                (state.startingDate == null)
                                                    ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                                                    : state.startingDate!
                                              ),

                                        );

                                        if (picked != null) {
                                          bloc.add(ChangeStartingDate(picked));
                                        }
                                      },
                                      icon: const Icon(Icons.date_range),
                                    ),
                                    isDense: true,
                                  ),
                                  readOnly: true,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  style: GoogleFonts.poppins(),
                                  controller: TextEditingController(text: state.endingDate),
                                  decoration: InputDecoration(
                                    labelText: 'Oxirgi to\'lov sanasi',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    isDense: true,
                                  ),
                                  readOnly: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextField(
                          style: GoogleFonts.poppins(),
                          controller: TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now())),
                          decoration: InputDecoration(
                            labelText: 'Sotuv yaratilayotgan sana',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            isDense: true,
                          ),
                          readOnly: true,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Sotuv yaratilgan vaqtda sms yuborilsinmi?',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).primaryColorDark
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => bloc.add(ChangeSmsSend(true)),
                              borderRadius: BorderRadius.circular(30),
                              child: Ink(
                                height: 48,
                                width: 100,
                                decoration: ShapeDecoration(
                                  color: (state.isSendSms!) ?  Colors.blue : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: (state.isSendSms!) ?  Colors.white : Colors.blue)
                                  )
                                ),
                                child: Center(
                                  child: Text(
                                    'Ha',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: (state.isSendSms!) ?  Colors.white : Colors.blue
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () => bloc.add(ChangeSmsSend(false)),
                              borderRadius: BorderRadius.circular(30),
                              child: Ink(
                                height: 48,
                                width: 100,
                                decoration: ShapeDecoration(
                                    color: (state.isSendSms!) ?  Colors.white : Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(color: (state.isSendSms!) ?  Colors.blue : Colors.white)
                                    )
                                ),
                                child: Center(
                                  child: Text(
                                    'Yo\'q',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: (state.isSendSms!) ?  Colors.blue : Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          onChanged: (value) => bloc.add(ChangeComment(value)),
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            labelText: 'Izoh',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 5,
                          maxLength: 100,
                        ),
                        const SizedBox(height: 100),
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
                                state.selectedClient == null ||
                                state.selectedGuarantor == null ||
                                state.selectedMoneyType == null ||
                                state.name == null ||
                                state.price == null ||
                                state.startingPrice == null ||
                                state.countSale == null ||
                                state.percent == null ||
                                state.startingDate == null
                              ) {
                                ScaffoldMessenger
                                    .of(context)
                                    .showSnackBar(const SnackBar(content: Text("Hamma ma'lumot to'ldirilmagan")));
                              } else {
                                bloc.add(AddSale());
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