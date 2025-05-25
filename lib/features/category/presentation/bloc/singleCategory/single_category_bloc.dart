import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/category/domain/usecases/single_category_usecase.dart';
import 'package:food_delivery/features/category/presentation/bloc/category_event.dart';
import 'package:food_delivery/features/category/presentation/bloc/singleCategory/single_category_state.dart';
import 'package:logger/logger.dart';

class SingleCategoryBloc extends Bloc<CategoryEvent,SingleCategoryState>{
  final SingleCategoryUsecase singleCategoryUseCase;
  var logger = Logger();

  SingleCategoryBloc({required this.singleCategoryUseCase}):super(SingleCategoryInitial()){
    on<SingleCategoryEvent>((event,emit)async{
      emit(SingleCategoryLoading());
      try{
        final category = await singleCategoryUseCase.call(id: event.id);
        emit(SingleCategoryLoaded(singleCategoryEntity: category));
      } catch(e,s){
        logger.e("GET SingleCategory BLOC ERROR: $s");
        emit(SingleCategoryError(message: e.toString()));
      }
    });
  }
}