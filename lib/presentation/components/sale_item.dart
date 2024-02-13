import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/model/sale_model.dart';
import '../pages/sales/sale_detail/sale_detail_bloc.dart';
import '../pages/sales/sale_detail/sale_detail_page.dart';

class SaleItem extends StatelessWidget {
  final SaleModel? saleModel;

  const SaleItem({
    super.key,
    required this.saleModel
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BlocProvider(
                              create: (context) => SaleDetailBloc(),
                              child: SaleDetailPage(
                                  saleModel: saleModel
                              ),
                            )
                    )
                );
              },
              trailing: Text(
                'Aktiv',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600
                ),
              ),
              leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset('assets/icons/sale.png'),
                  )
              ),
              title: Text(
                '${saleModel?.client}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500
                ),
              ),
              subtitle: ((saleModel?.name?.length ?? 0) > 10)
                  ? Text(
                    '${saleModel?.name?.substring(0, 10)}...  |  ${NumberFormat.currency(locale: 'uz').format(saleModel?.nasiyaPrice).substring(0, NumberFormat.currency(locale: 'uz').format(saleModel?.nasiyaPrice).length - 7)} ${saleModel?.moneyType}',
                    style: GoogleFonts.poppins(),
                  )
                  : Text(
                    '${saleModel?.name}  |  ${NumberFormat.currency(locale: 'uz').format(saleModel?.nasiyaPrice).substring(0, NumberFormat.currency(locale: 'uz').format(saleModel?.nasiyaPrice).length - 7)} ${saleModel?.moneyType}',
                    style: GoogleFonts.poppins(),
                  )
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16
              ),
              child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black26
              )
          )
        ]
    );
  }
}