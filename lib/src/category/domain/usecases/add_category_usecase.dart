

import 'package:aponwola_admin/common/error/failure.dart';
import 'package:aponwola_admin/common/utils/usecase.dart';
import 'package:aponwola_admin/src/category/domain/entities/categoryEntity.dart';
import 'package:aponwola_admin/src/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class AddCategoryUseCase implements UseCase<CategoryEntity,Params<CategoryEntity>>{
  final CategoryRepository categoryRepository;
  AddCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, CategoryEntity>> call(Params<CategoryEntity> params) async {
         return await categoryRepository.addCategory(params.data);
  }



}