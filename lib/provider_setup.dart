import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/models/user.dart';
import 'core/services/auth/auth_service.dart';
import 'core/services/connectivity/connectivity_service.dart';
import 'core/services/dialog/dialog_service.dart';
import 'core/services/http/api_service.dart';
import 'core/view_models/app_language_view_model.dart';
import 'core/view_models/auth_view_model.dart';
import 'core/view_models/cart_badge_view_model.dart';
import 'core/view_models/dark_mode_view_model.dart';
import 'core/view_models/home_bottom_navigation_view_model.dart';
import 'ui/widgets/internet_connection_error.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: ApiService()),
  Provider.value(value: DialogService()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<ApiService, AuthService>(
    update: (context, api, authenticationService) => AuthService(apiService: api),
  ),
];

List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<User>(
    create: (context) => context.read<AuthService>().user,
  ),
  StreamProvider<ConnectivityStatus>(
    create: (context) => ConnectivityService().connectionStatusController.stream,
  ),
  ChangeNotifierProvider<AuthViewModel>(
    create: (context) => AuthViewModel(authService: AuthService(apiService: context.read<ApiService>())),
  ),
  ChangeNotifierProvider<AppLanguageViewModel>(
    create: (context) => AppLanguageViewModel(),
  ),
  ChangeNotifierProvider<DarkThemeViewModel>(
    create: (context) => DarkThemeViewModel(),
  ),
  ChangeNotifierProvider<CartBadgeViewModel>(
    create: (context) => CartBadgeViewModel(),
  ),
  ChangeNotifierProvider<HomeBottomNavigationViewModel>(
    create: (context) => HomeBottomNavigationViewModel(),
  ),
];
