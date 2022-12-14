import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/helpers/usecase_helper.dart';
import 'package:informat/feature/receipe/model/recipe_model.dart';
import 'package:informat/feature/receipe/repository/receipe_repository.dart';

class GetRecipes extends Usecase<GetRecipesParams, APIRecipeQuery> {
  final ReceipeRepository receipeRepository;
  GetRecipes(this.receipeRepository);

  @override
  Future<Either<Failure, APIRecipeQuery>> call(GetRecipesParams params) {
    return receipeRepository.getAllReceipe();
  }
}

class GetRecipesParams extends Equatable {
  @override
  List<Object?> get props => [];
}
