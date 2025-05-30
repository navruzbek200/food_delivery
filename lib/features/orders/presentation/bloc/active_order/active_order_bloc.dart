import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/orders/domain/usecases/active_orders_usecase.dart';
import 'package:logger/logger.dart';

import '../order_event.dart';
import 'active_order_state.dart';

class ActiveOrderBloc extends Bloc<OrderEvent, ActiveOrderState>{
  final ActiveOrdersUseCase activeOrdersUseCase;
  var logger = Logger();

  ActiveOrderBloc({required this.activeOrdersUseCase}):super(ActiveOrderInitial()){
    on<ActiveOrderEvent>((event,emit)async{
      emit(ActiveOrderLoading());
      try{
        final order = await activeOrdersUseCase.call(status: '');
        emit(ActiveOrderLoaded(orderEntity: order));
      }catch(e,s){
        logger.e("ACTIVE ORDER BLOCK: $s");
        emit(ActiveOrderError(message: e.toString()));
      }
    });
  }
}