import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/status.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/employee_item.dart';
import 'employees_bloc.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final bloc = EmployeesBloc();
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
        appBar: CustomAppBar(title: 'Hodimlar'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator
                .pushNamed(context, '/add_employee')
                .whenComplete(() => bloc.add(Init()));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Theme.of(context).primaryColorDark,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: BlocConsumer<EmployeesBloc, EmployeesState>(
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
                              itemCount: state.employees?.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => EmployeeItem(
                                employeeModel: state.employees?[index],
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
