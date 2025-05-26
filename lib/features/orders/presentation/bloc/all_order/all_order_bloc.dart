import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/orders/domain/usecases/orders_usecase.dart';
import 'package:food_delivery/features/orders/presentation/bloc/all_order/all_order_state.dart';
import 'package:food_delivery/features/orders/presentation/bloc/order_event.dart';
import 'package:logger/logger.dart';

class AllOrderBloc extends Bloc<OrderEvent, AllOrderState>{
final OrdersUsecase ordersUsecase;
var logger = Logger();

AllOrderBloc({required this.ordersUsecase}):super(AllOrderInital()){
  on<AllOrderEvent>((event,emit)async{
    emit(AllOrderLoading());
    try{
      final order = await ordersUsecase.call();
      emit(AllOrderLoaded(orderEntity: order));
    }catch(e,s){
      logger.e("ALL ORDER BLOCK: $s");
      emit(AllOrderError(message: e.toString()));
    }
  });
}
}