import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasiya_app/presentation/components/custom_app_bar.dart';
import 'package:nasiya_app/presentation/pages/sale_detail/sale_detail_bloc.dart';

import '../../../data/model/sale_model.dart';
import '../../../utils/status.dart';

class SaleDetailPage extends StatefulWidget {
  SaleModel? saleModel;

  SaleDetailPage({super.key, required this.saleModel});

  @override
  State<SaleDetailPage> createState() => _SaleDetailPageState();
}

class _SaleDetailPageState extends State<SaleDetailPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider
        .of<SaleDetailBloc>(context)
        .add(Init(widget.saleModel?.id ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Sotuv haqida ma'lumot",
      ),
      body: BlocBuilder<SaleDetailBloc, SaleDetailState>(
        builder: (context, state) {
          return Builder(builder: (context) {
            switch (state.status) {
              case Status.LOADING: {
                return const Center(
                    child: CircularProgressIndicator()
                );
              }
              case Status.ERROR: {
                return Center(
                  child: Text(
                    'ERROR',
                    style: GoogleFonts.poppins(
                        fontSize: 32
                    ),
                  ),
                );
              }
              case Status.SUCCESS: {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomi: ${widget.saleModel?.name}'
                        ),
                        Row(
                          children: [
                            Text('Mijoz: '),
                            TextButton(
                                onPressed: () {},
                                child: Text(widget.saleModel?.client ?? '')
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Kafil: '),
                            TextButton(
                                onPressed: () {},
                                child: Text(widget.saleModel?.guarantor ?? '')
                            ),
                          ],
                        ),
                        Text(
                            'Pul birligi: ${widget.saleModel?.moneyType}'
                        ),
                        Text(
                            'Narxi: ${widget.saleModel?.price} ${widget.saleModel?.moneyType}'
                        ),
                        Text(
                            'Nasiya Narxi: ${widget.saleModel?.nasiyaPrice} ${widget.saleModel?.moneyType}'
                        ),
                        Text(
                            'Boshlang\'ich to\'lov: ${widget.saleModel?.startingPrice} ${widget.saleModel?.moneyType}'
                        ),
                        Text(
                            'To\'lovlar soni: ${widget.saleModel?.countSale} marta'
                        ),
                        Text(
                            'Oylik to\'lov: ${widget.saleModel?.monthlyPrice} ${widget.saleModel?.moneyType}'
                        ),
                        Text(
                            'Birinchi to\'lov sanasi: ${widget.saleModel?.startingDate}'
                        ),
                        Text(
                            'Oxirgi to\'lov sanasi: ${widget.saleModel?.endingDate}'
                        ),
                        Text(
                            'Sotilgan sana: ${widget.saleModel?.creatingDate}'
                        ),
                        Text(
                            'Izoh: ${widget.saleModel?.comment}'
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          child: DataTable2(
                              columnSpacing: 12,
                              horizontalMargin: 12,
                              columns: const [
                                DataColumn2(
                                  label: Text('Miqdor'),
                                ),
                                DataColumn(
                                  label: Text('Xodim'),
                                ),
                                DataColumn(
                                  label: Text('Sana'),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                  state.payments?.length ?? 0,
                                      (index) => DataRow(cells: [
                                        DataCell(Text('${state.payments?[index].quantity ?? ''}')),
                                        DataCell(Text(state.payments?[index].employee ?? '')),
                                        DataCell(Text(state.payments?[index].date ?? '')),
                                      ])
                              )
                          ),
                        ),
                      ],
                      // children: [
                      //   Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 16),
                      //       child: Column(children: [
                      //         for (SaleModel product in state.products ?? [])
                      //           Row(
                      //             children: [
                      //               Text(
                      //                 product.name ?? '',
                      //                 style: GoogleFonts.poppins(
                      //                     fontWeight: FontWeight.w600),
                      //               ),
                      //               const SizedBox(width: 12),
                      //               // Text(
                      //               //   "${product.count ?? 0} dona",
                      //               //   style: GoogleFonts.poppins(fontSize: 12),
                      //               // ),
                      //               const Spacer(),
                      //               Text(
                      //                 "${NumberFormat.currency(locale: 'uz').format(product.price).substring(0, NumberFormat.currency(locale: 'uz').format(product.price).length - 7)} so'm",
                      //                 style: GoogleFonts.poppins(),
                      //               ),
                      //             ],
                      //           ),
                      //         const SizedBox(height: 24),
                      //         Row(
                      //           children: [
                      //             Text(
                      //               "Umumiy narx: ",
                      //               style: GoogleFonts.poppins(
                      //                   fontSize: 18, fontWeight: FontWeight.w600),
                      //             ),
                      //             const Spacer(),
                      //             Text(
                      //               "${NumberFormat.currency(locale: 'uz').format(state.price).substring(0, NumberFormat.currency(locale: 'uz').format(state.price).length - 7)} so'm",
                      //               style: GoogleFonts.poppins(),
                      //             )
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             Text(
                      //               "Foiz bilan: ",
                      //               style: GoogleFonts.poppins(
                      //                   fontSize: 18, fontWeight: FontWeight.w600),
                      //             ),
                      //             const Spacer(),
                      //             Text(
                      //               "${NumberFormat.currency(locale: 'uz').format((state.price ?? 0) * 1.35).substring(0, NumberFormat.currency(locale: 'uz').format((state.price ?? 0) * 1.35).length - 7)} so'm",
                      //               style: GoogleFonts.poppins(),
                      //             )
                      //           ],
                      //         ),
                      //         Row(
                      //           children: [
                      //             const Spacer(),
                      //             // Text(
                      //             //   "${widget.saleModel.percent}%",
                      //             //   style: GoogleFonts.poppins(
                      //             //       fontWeight: FontWeight.w600, fontSize: 12),
                      //             // ),
                      //             const SizedBox(width: 8),
                      //             // Text(
                      //             //   "${widget.saleModel.month} oyga",
                      //             //   style: GoogleFonts.poppins(
                      //             //       fontWeight: FontWeight.w600, fontSize: 12),
                      //             // )
                      //           ],
                      //         ),
                      //         const SizedBox(height: 12),
                      //         Row(children: [
                      //           Text(
                      //             "Bog'lanish",
                      //             style: GoogleFonts.poppins(
                      //                 fontSize: 18, fontWeight: FontWeight.w600),
                      //           ),
                      //           const Spacer(),
                      //           IconButton(
                      //               style: ButtonStyle(
                      //                   backgroundColor:
                      //                   MaterialStateProperty.all(Colors.green)),
                      //               onPressed: () async {
                      //                 final url = Uri(
                      //                     scheme: 'tel',
                      //                     path: widget.saleModel?.phoneNumber);
                      //
                      //                 if (await canLaunchUrl(url)) {
                      //                   await launchUrl(url);
                      //                 }
                      //               },
                      //               icon:
                      //               const Icon(Icons.phone, color: Colors.white)),
                      //           IconButton(
                      //               style: ButtonStyle(
                      //                   backgroundColor: MaterialStateProperty.all(
                      //                       Theme.of(context).primaryColorDark)),
                      //               onPressed: () async {
                      //                 final url = Uri(
                      //                     scheme: 'sms',
                      //                     path: widget.saleModel?.phoneNumber);
                      //
                      //                 if (await canLaunchUrl(url)) {
                      //                   await launchUrl(url);
                      //                 }
                      //               },
                      //               icon: const Icon(Icons.message,
                      //                   color: Colors.white))
                      //         ])
                      //       ]))
                      // ],
                    ),
                  ),
                );
              }
              default: return const SizedBox();
            }
          });
        },
      ),
    );
  }
}