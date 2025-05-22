import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/orders/domain/usecases/completed_orders_usecase.dart';
import 'package:food_delivery/features/orders/presentation/bloc/completed_order/completed_order_state.dart';
import 'package:logger/logger.dart';

import '../order_event.dart';

class CompletedOrderBloc extends Bloc<OrderEvent, CompletedOrderState>{
  final CompletedOrdersUseCase completedOrdersUseCase;
  var logger = Logger();

  CompletedOrderBloc({required this.completedOrdersUseCase}):super(CompletedOrderInitial()){
    on<CompletedOrderEvent>((event,emit)async{
      emit(CompletedOrderLoading());
      try{
        final order = await completedOrdersUseCase.call();
        emit(CompletedOrderLoaded(orderEntity: order));
      }catch(e,s){
        logger.e("COMPLETED ORDER BLOCK: $s");
        emit(CompletedOrderError(message: e.toString()));
      }
    });
  }
}