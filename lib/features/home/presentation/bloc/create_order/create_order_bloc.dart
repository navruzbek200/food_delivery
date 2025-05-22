import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/home/domain/usecases/create_order_usecase.dart';
import 'package:food_delivery/features/home/presentation/bloc/create_order/create_order_state.dart';
import 'package:food_delivery/features/home/presentation/bloc/home_event.dart';
import 'package:logger/logger.dart';


class CreateOrderBloc extends Bloc<HomeEvent, CreateOrderState>{
  final CreateOrderUseCase createOrderUseCase;
  var logger = Logger();

  CreateOrderBloc({required this.createOrderUseCase}):super(CreateOrderInitial()){
    on<CreateOrderEvent>((event,emit)async{
      emit(CreateOrderLoading());
      try{
        final order = await createOrderUseCase.call(count: event.count, food_id: event.food_id);
        emit(CreateOrderLoaded(createOrderEntity: order));
      }catch(e,s){
        logger.e("CREATE ORDER BLOC: $s");
        emit(CreateOrderError(message: e.toString()));
      }
    });
  }
}