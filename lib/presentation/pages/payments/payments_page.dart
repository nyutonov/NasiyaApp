import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasiya_app/presentation/pages/payments/payments_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/status.dart';
import '../../components/custom_app_bar.dart';
import '../../components/payment_item.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final bloc = PaymentsBloc();
  final _refreshController = RefreshController();
  final _refreshControllerForListView = RefreshController();

  @override
  void initState() {
    super.initState();

    bloc.add(Init());
  }

  @override
  void dispose() {
    super.dispose();

    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: CustomAppBar(title: 'To\'lovlar'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator
                .pushNamed(context, '/add_payment')
                .whenComplete(() => bloc.add(Init()));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Theme.of(context).primaryColorDark,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: BlocConsumer<PaymentsBloc, PaymentsState>(
          listener: (context, state) {
            if (state.status != Status.LOADING) {
              _refreshController.refreshCompleted();
              _refreshControllerForListView.refreshCompleted();
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Builder(
                  builder: (context) {
                    switch (state.status) {
                      case Status.LOADING: {
                        return const Center(
                            child: CircularProgressIndicator()
                        );
                      }
                      case Status.ERROR: {
                        return SmartRefresher(
                          controller: _refreshController,
                          onRefresh: () => bloc.add(Init()),
                          child: Center(
                            child: Text(
                              'ERROR',
                              style: GoogleFonts.poppins(
                                  fontSize: 32
                              ),
                            ),
                          ),
                        );
                      }
                      case Status.SUCCESS: {
                        return SmartRefresher(
                          controller: _refreshControllerForListView,
                          onRefresh: () => bloc.add(Init()),
                          child: ListView.builder(
                              itemCount: state.payments?.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => PaymentItem(
                                paymentModel: state.payments?[index],
                              )
                          ),
                        );
                      }
                      default: return const SizedBox();
                    }
                  }
              ),
            );
          },
        ),
      ),
    );
  }
}
