import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/category/domain/usecases/categories_usecase.dart';
import 'package:food_delivery/features/category/presentation/bloc/categories/categories_state.dart';
import 'package:food_delivery/features/category/presentation/bloc/category_event.dart';
import 'package:logger/logger.dart';

class CategoriesBloc extends Bloc<CategoryEvent,CategoriesState>{
  final CategoriesUseCase categoriesUseCase;
  var logger = Logger();

  CategoriesBloc({required this.categoriesUseCase}):super(CategoriesInitial()){
    on<CategoriesEvent>((event,emit)async{
      emit(CategoriesLoading());
      try{
        final category = await categoriesUseCase.call();
        emit(CategoriesLoaded(categoriesEntity: category));
      } catch(e,s){
        logger.e("GET CATEGORIES BLOC ERROR: $s");
        emit(CategoriesError(message: e.toString()));
      }
    });
  }
}