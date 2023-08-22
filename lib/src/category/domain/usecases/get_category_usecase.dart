

import 'package:aponwola_admin/common/error/failure.dart';
import 'package:aponwola_admin/common/utils/usecase.dart';
import 'package:aponwola_admin/src/category/domain/entities/categoryEntity.dart';
import 'package:aponwola_admin/src/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoryUseCase implements UseCase<List<CategoryEntity>,NoParams>{
  final CategoryRepository categoryRepository;
  GetCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params)async {
    return await categoryRepository.getCategory();
  }

}