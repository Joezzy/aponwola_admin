

import 'package:aponwola_admin/common/error/failure.dart';
import 'package:aponwola_admin/common/utils/usecase.dart';
import 'package:aponwola_admin/src/category/domain/entities/categoryEntity.dart';
import 'package:aponwola_admin/src/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class EditCategoryUseCase implements UseCase<CategoryEntity,Params<CategoryEntity>>{
  final CategoryRepository categoryRepository;
  EditCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, CategoryEntity>> call(Params<CategoryEntity> params) async {
         return await categoryRepository.editCategory(params.data);
  }



}