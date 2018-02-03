import 'package:germanmealbrowser/api/mensa_api.dart';
import 'package:germanmealbrowser/api/mensa_api_impl.dart';
import 'package:germanmealbrowser/repository/canteens_repository.dart';
import 'package:germanmealbrowser/repository/canteens_repository_impl.dart';
import 'package:germanmealbrowser/repository/meals_repository.dart';
import 'package:germanmealbrowser/repository/meals_repository_impl.dart';


class RepositoryFactory {
  static final RepositoryFactory _singleton = new RepositoryFactory._internal();

  factory RepositoryFactory() {
    return _singleton;
  }

  MensaApi api;
  CanteensRepository canteensRepository;
  MealsRepository mealsRepository;

  RepositoryFactory._internal() {
    api = new MensaApiImpl();
    canteensRepository = new CanteensRepositoryImpl(api);
    mealsRepository = new MealsRepositoryImpl(api);
  }

  CanteensRepository getCanteensRepository() {
    return canteensRepository;
  }

  MealsRepository getMealsRepository() {
    return mealsRepository;
  }

}