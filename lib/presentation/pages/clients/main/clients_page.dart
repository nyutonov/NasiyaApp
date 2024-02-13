import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/status.dart';
import '../../../components/client_item.dart';
import '../../../components/custom_app_bar.dart';
import 'clients_bloc.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final bloc = ClientsBloc();
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
        appBar: CustomAppBar(title: 'Mijozlar'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator
                .pushNamed(context, '/add_client')
                .whenComplete(() => bloc.add(Init()));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Theme.of(context).primaryColorDark,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: BlocConsumer<ClientsBloc, ClientsState>(
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
                              itemCount: state.clients?.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => ClientItem(
                                clientModel: state.clients?[index],
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