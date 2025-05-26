import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/category/domain/usecases/category_foods_usecase.dart';
import 'package:food_delivery/features/category/presentation/bloc/category_foods/category_foods_state.dart';
import 'package:logger/logger.dart';
import '../category_event.dart';

class CategoryFoodsBloc extends Bloc<CategoryEvent,CategoryFoodsState>{
  final CategoryFoodsUsecase categoryFoodsUseCase;
  var logger = Logger();

  CategoryFoodsBloc({required this.categoryFoodsUseCase}):super(CategoryFoodsInitial()){
    on<CategoryFoodsEvent>((event,emit)async{
      emit(CategoryFoodsLoading());
      try{
        final category = await categoryFoodsUseCase.call(id: event.id);
        emit(CategoryFoodsLoaded(category: category));
      } catch(e,s){
        logger.e("GET CATEGORY FOOD BLOC ERROR: $s");
        emit(CategoryFoodsError(message: e.toString()));
      }
    });
  }
}