

import 'package:aponwola_admin/common/error/failure.dart';
import 'package:aponwola_admin/common/utils/usecase.dart';
import 'package:aponwola_admin/src/category/domain/entities/categoryEntity.dart';
import 'package:aponwola_admin/src/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCategoryUseCase implements UseCase<String,Params<String>>{
  final CategoryRepository categoryRepository;
  DeleteCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, String>> call(Params<String> params)async {
           return await categoryRepository.deleteCategory(params.data);

  }

}