import 'package:food/screen/favourite/favModel.dart';
import 'package:food/screen/cart/cartmodel.dart';
import 'package:stacked_shared/stacked_shared.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  // Register environments
  locator.registerEnvironment(
    environment: environment,
    environmentFilter: environmentFilter,
  );

  // Register dependencies for all screens
  locator.registerSingleton(Favmodel());
  locator.registerSingleton(Cartmodel());
}

