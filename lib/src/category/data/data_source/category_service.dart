

import 'package:aponwola_admin/common/constant.dart';
import 'package:aponwola_admin/src/category/domain/entities/categoryEntity.dart';

abstract class CategoryService{
  Future<List<CategoryEntity>> getCategoryApi();
  Future<CategoryEntity> addCategoryApi(CategoryEntity categoryEntity);
  Future<CategoryEntity> editCategoryApi(CategoryEntity categoryEntity);
  Future<String> deleteCategoryApi(String id);
}


class CategoryServiceImpl implements CategoryService{
  @override
  Future<List<CategoryEntity>> getCategoryApi() async{
    final cat=await firebase.collection('categories').
    orderBy('name', descending: true).get();
      return cat.docs.map((doc) => CategoryEntity.fromSnapShot(doc)).toList();
  }

  @override
  Future<CategoryEntity> addCategoryApi(CategoryEntity categoryEntity) async{
      await firebase
          .collection("todos")
          .add(categoryEntity.toJson());
      return categoryEntity;
  }

  @override
  Future<CategoryEntity> editCategoryApi(CategoryEntity categoryEntity) async{
    await firebase
        .collection("todos").doc(categoryEntity.id)
        .update(categoryEntity.toJson());
    return categoryEntity;

  }


  @override
  Future<String> deleteCategoryApi(String id) async{
    await firebase.doc(id)
        .delete();
    return id;
  }

}


