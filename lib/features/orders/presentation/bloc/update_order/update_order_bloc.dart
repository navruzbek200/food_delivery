import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/orders/domain/usecases/update_orders_usecase.dart';
import 'package:food_delivery/features/orders/presentation/bloc/update_order/update_order_state.dart';
import 'package:logger/logger.dart';

import '../order_event.dart';

class UpdateOrderBloc extends Bloc<OrderEvent, UpdateOrderState>{
  final UpdateOrdersUsecase updateOrdersUsecase;
  var logger = Logger();

  UpdateOrderBloc({required this.updateOrdersUsecase}):super(UpdateOrderInitial()){
    on<UpdateOrderEvent>((event,emit)async{
      emit(UpdateOrderLoading());
      try{
        final order = await updateOrdersUsecase.call(order_id: event.order_id);
        emit(UpdateOrderLoaded(updateOrderEntity: order));
      }catch(e,s){
        logger.e("UPDATE ORDER BLOCK: $s");
        emit(UpdateOrderError(message: e.toString()));
      }
    });
  }
}