
import 'package:aponwola_admin/common/error/failure.dart';
import 'package:aponwola_admin/src/category/data/data_source/category_service.dart';
import 'package:aponwola_admin/src/category/domain/entities/categoryEntity.dart';
import 'package:aponwola_admin/src/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryService categoryService;

  const CategoryRepositoryImpl({required this.categoryService});

  @override
  Future<Either<Failure, CategoryEntity>> addCategory(CategoryEntity categoryEntity) async{
    try{
      final result= await   categoryService.addCategoryApi(categoryEntity);
        return Right(result);
    }catch(e){
     return  Left(Failure("Something went wrong!"));
    }
  }

  @override
  Future<Either<Failure, String>> deleteCategory(String id)async {
    try{
      final result=await categoryService.deleteCategoryApi(id);
     return Right(result);
    }catch(e){
    return  Left(Failure("Something went wrong!"));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> editCategory(CategoryEntity categoryEntity)async {
    try{
      final result= await   categoryService.editCategoryApi(categoryEntity);
      return Right(result);
    }catch(e){
      return  Left(Failure("Something went wrong!"));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategory()async {
    try{
      final result= await   categoryService.getCategoryApi();
      return Right(result);
    }catch(e){
      return  Left(Failure("Something went wrong!"));
    }
  }




}