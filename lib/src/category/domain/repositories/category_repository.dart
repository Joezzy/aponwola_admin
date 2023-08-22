
import 'package:aponwola_admin/common/error/failure.dart';
import 'package:aponwola_admin/src/category/domain/entities/categoryEntity.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository{
    Future<Either<Failure,CategoryEntity>> addCategory(CategoryEntity categoryEntity);
    Future<Either<Failure,CategoryEntity>> editCategory(CategoryEntity categoryEntity);
    Future<Either<Failure,String>> deleteCategory(String id);
    Future<Either<Failure,List<CategoryEntity>>> getCategory();

}