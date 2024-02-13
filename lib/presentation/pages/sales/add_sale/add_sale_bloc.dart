import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:nasiya_app/data/model/client_model.dart';
import 'package:nasiya_app/data/model/sale_model.dart';
import 'package:nasiya_app/utils/constants.dart';

import '../../../../utils/my_utils.dart';
import '../../../../utils/status.dart';

part 'add_sale_event.dart';
part 'add_sale_state.dart';

class AddSaleBloc extends Bloc<AddSaleEvent, AddSaleState> {
  final _appRepository = Constants.appRepository;

  AddSaleBloc() : super(AddSaleState(isSendSms: true)) {
    on<Init>((event, emit) async {
      try {
        var clients = await _appRepository.getAllClients();

        emit(state.copyWith(clients: clients));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });

    on<SelectClient>((event, emit) async {
      emit(state.copyWith(selectedClient: event.clientModel));
    });

    on<SelectGuarantor>((event, emit) async {
      emit(state.copyWith(selectedGuarantor: event.clientModel));
    });

    on<SelectMoneyType>((event, emit) async {
      emit(state.copyWith(selectedMoneyType: event.moneyType));
    });

    on<ChangeName>((event, emit) async {
      emit(state.copyWith(name: event.name));
    });

    on<ChangePrice>((event, emit) async {
      var nasiyaPrice = (event.price * (1 + (state.percent ?? 0) / 100)).toInt();

      emit(state.copyWith(
          price: event.price,
          nasiyaPrice: nasiyaPrice,
          monthlyPrice: (state.countSale == 0)
              ? 0
              : (nasiyaPrice - (state.startingPrice ?? 0)) ~/ (state.countSale ?? 1)
      ));
    });

    on<ChangePercent>((event, emit) async {
      emit(state.copyWith(
          percent: event.percent,
          nasiyaPrice: ((state.price ?? 0) * (1 + event.percent / 100)).toInt()
      ));
    });

    on<ChangeStartingPrice>((event, emit) async {
      emit(state.copyWith(
          startingPrice: event.startingPrice
      ));
    });

    on<ChangeComment>((event, emit) async {
      emit(state.copyWith(comment: event.comment));
    });

    on<ChangeCountSale>((event, emit) async {
      if (state.startingDate != null) {
        DateTime endingDate = DateFormat('dd-MM-yyyy').parse(state.startingDate!);

        endingDate = endingDate.copyWith(month: endingDate.month + event.countSale);

        emit(state.copyWith(
            countSale: event.countSale,
            monthlyPrice: (event.countSale == 0)
                ? 0
                : ((state.nasiyaPrice ?? 0) - (state.startingPrice ?? 0)) ~/ event.countSale,
            endingDate: (state.startingDate == null) ? '' : DateFormat('dd-MM-yyyy').format(endingDate)
        ));
      } else {
        emit(state.copyWith(
            countSale: event.countSale,
            monthlyPrice: (event.countSale == 0)
                ? 0
                : ((state.nasiyaPrice ?? 0) - (state.startingPrice ?? 0)) ~/ event.countSale
        ));
      }
    });

    on<ChangeStartingDate>((event, emit) async {
      DateTime endingDate = event.startingDate;

      endingDate = endingDate.copyWith(month: endingDate.month + (state.countSale ?? 0));

      emit(state.copyWith(
        startingDate: DateFormat('dd-MM-yyyy').format(event.startingDate),
        endingDate: DateFormat('dd-MM-yyyy').format(endingDate)
      ));
    });

    on<ChangeSmsSend>((event, emit) async {
      emit(state.copyWith(isSendSms: event.isSend));
    });

    on<AddSale>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING));

        await _appRepository.addSale(
          SaleModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: state.name,
              client: state.selectedClient?.name,
              clientId: state.selectedClient?.id,
              guarantor: state.selectedGuarantor?.name,
              guarantorId: state.selectedGuarantor?.id,
              moneyType: state.selectedMoneyType,
              price: state.price,
              nasiyaPrice: state.nasiyaPrice,
              startingPrice: state.startingPrice,
              countSale: state.countSale,
              monthlyPrice: state.monthlyPrice,
              startingDate: state.startingDate,
              endingDate: state.endingDate,
              creatingDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
              employee: 'Shahriyor',
              comment: state.comment
          )
        );

        if (state.isSendSms!) {
          String phoneNumber = state.selectedClient!.phoneNumber!.replaceAll(' ', '');

          String messageOne =
              '${state.name} ni ${state.countSale} oy muddatga ${state.nasiyaPrice} ${state.selectedMoneyType} ga sotib oldingiz.\n'
              'Oylik to\'lovingiz har oyning ${state.startingDate?.substring(0, 2)}-sanasida ${state.monthlyPrice} ${state.selectedMoneyType}.';

          String messageTwo =
              'Birinchi to\'lov sana: ${state.startingDate}.\n'
              'Oxirgi to\'lov sana: ${state.endingDate}.';

          await Utils.sendSms(
              phoneNumber: phoneNumber,
              message: messageOne
          );

          await Utils.sendSms(
              phoneNumber: phoneNumber,
              message: messageTwo
          );
        }

        // await Workmanager().registerPeriodicTask(
          // event.buyerModel.id ?? '',
          // "${event.buyerModel.firstName}${event.buyerModel.lastName}",
          // frequency: const Duration(minutes: 15),
          // constraints: Constraints(
          //     networkType: NetworkType.connected
          // ),
        // );

        emit(state.copyWith(status: Status.SUCCESS));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}