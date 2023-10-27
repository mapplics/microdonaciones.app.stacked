// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i13;
import 'package:flutter/material.dart';
import 'package:microdonations/core/models/ong/ong.model.dart' as _i16;
import 'package:microdonations/core/parameters/create_account_view.parameters.model.dart'
    as _i15;
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart'
    as _i14;
import 'package:microdonations/ui/views/create_account/create_account_view.dart'
    as _i7;
import 'package:microdonations/ui/views/home/home_view.dart' as _i2;
import 'package:microdonations/ui/views/login/login_view.dart' as _i4;
import 'package:microdonations/ui/views/new_donation/new_donation_view.dart'
    as _i8;
import 'package:microdonations/ui/views/new_donation_confirmed/new_donation_confirmed_view.dart'
    as _i9;
import 'package:microdonations/ui/views/onboarding/onboarding_view.dart' as _i5;
import 'package:microdonations/ui/views/ong_selector/ong_selector_view.dart'
    as _i12;
import 'package:microdonations/ui/views/order_history_detail/order_history_detail_view.dart'
    as _i11;
import 'package:microdonations/ui/views/orders_history/orders_history_view.dart'
    as _i10;
import 'package:microdonations/ui/views/personal_information/personal_information_view.dart'
    as _i6;
import 'package:microdonations/ui/views/startup/startup_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i17;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const loginView = '/login-view';

  static const onboardingView = '/onboarding-view';

  static const personalInformationView = '/personal-information-view';

  static const createAccountView = '/create-account-view';

  static const newDonationView = '/new-donation-view';

  static const newDonationConfirmedView = '/new-donation-confirmed-view';

  static const ordersHistoryView = '/orders-history-view';

  static const orderHistoryDetailView = '/order-history-detail-view';

  static const ongSelectorView = '/ong-selector-view';

  static const all = <String>{
    homeView,
    startupView,
    loginView,
    onboardingView,
    personalInformationView,
    createAccountView,
    newDonationView,
    newDonationConfirmedView,
    ordersHistoryView,
    orderHistoryDetailView,
    ongSelectorView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i4.LoginView,
    ),
    _i1.RouteDef(
      Routes.onboardingView,
      page: _i5.OnboardingView,
    ),
    _i1.RouteDef(
      Routes.personalInformationView,
      page: _i6.PersonalInformationView,
    ),
    _i1.RouteDef(
      Routes.createAccountView,
      page: _i7.CreateAccountView,
    ),
    _i1.RouteDef(
      Routes.newDonationView,
      page: _i8.NewDonationView,
    ),
    _i1.RouteDef(
      Routes.newDonationConfirmedView,
      page: _i9.NewDonationConfirmedView,
    ),
    _i1.RouteDef(
      Routes.ordersHistoryView,
      page: _i10.OrdersHistoryView,
    ),
    _i1.RouteDef(
      Routes.orderHistoryDetailView,
      page: _i11.OrderHistoryDetailView,
    ),
    _i1.RouteDef(
      Routes.ongSelectorView,
      page: _i12.OngSelectorView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.LoginView(
            key: args.key, navigateOngSelector: args.navigateOngSelector),
        settings: data,
      );
    },
    _i5.OnboardingView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.OnboardingView(),
        settings: data,
      );
    },
    _i6.PersonalInformationView: (data) {
      final args =
          data.getArgs<PersonalInformationViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.PersonalInformationView(
            viewParameters: args.viewParameters, key: args.key),
        settings: data,
      );
    },
    _i7.CreateAccountView: (data) {
      final args = data.getArgs<CreateAccountViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.CreateAccountView(
            viewParameters: args.viewParameters, key: args.key),
        settings: data,
      );
    },
    _i8.NewDonationView: (data) {
      final args = data.getArgs<NewDonationViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.NewDonationView(ongSelected: args.ongSelected, key: args.key),
        settings: data,
      );
    },
    _i9.NewDonationConfirmedView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.NewDonationConfirmedView(),
        settings: data,
      );
    },
    _i10.OrdersHistoryView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.OrdersHistoryView(),
        settings: data,
      );
    },
    _i11.OrderHistoryDetailView: (data) {
      final args = data.getArgs<OrderHistoryDetailViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.OrderHistoryDetailView(
            viewParameters: args.viewParameters, key: args.key),
        settings: data,
      );
    },
    _i12.OngSelectorView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.OngSelectorView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class LoginViewArguments {
  const LoginViewArguments({
    this.key,
    this.navigateOngSelector = false,
  });

  final _i13.Key? key;

  final bool navigateOngSelector;

  @override
  String toString() {
    return '{"key": "$key", "navigateOngSelector": "$navigateOngSelector"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.navigateOngSelector == navigateOngSelector;
  }

  @override
  int get hashCode {
    return key.hashCode ^ navigateOngSelector.hashCode;
  }
}

class PersonalInformationViewArguments {
  const PersonalInformationViewArguments({
    required this.viewParameters,
    this.key,
  });

  final _i14.UserInformationFormParameters viewParameters;

  final _i13.Key? key;

  @override
  String toString() {
    return '{"viewParameters": "$viewParameters", "key": "$key"}';
  }

  @override
  bool operator ==(covariant PersonalInformationViewArguments other) {
    if (identical(this, other)) return true;
    return other.viewParameters == viewParameters && other.key == key;
  }

  @override
  int get hashCode {
    return viewParameters.hashCode ^ key.hashCode;
  }
}

class CreateAccountViewArguments {
  const CreateAccountViewArguments({
    required this.viewParameters,
    this.key,
  });

  final _i15.CreateAccountViewParameters viewParameters;

  final _i13.Key? key;

  @override
  String toString() {
    return '{"viewParameters": "$viewParameters", "key": "$key"}';
  }

  @override
  bool operator ==(covariant CreateAccountViewArguments other) {
    if (identical(this, other)) return true;
    return other.viewParameters == viewParameters && other.key == key;
  }

  @override
  int get hashCode {
    return viewParameters.hashCode ^ key.hashCode;
  }
}

class NewDonationViewArguments {
  const NewDonationViewArguments({
    required this.ongSelected,
    this.key,
  });

  final _i16.Ong ongSelected;

  final _i13.Key? key;

  @override
  String toString() {
    return '{"ongSelected": "$ongSelected", "key": "$key"}';
  }

  @override
  bool operator ==(covariant NewDonationViewArguments other) {
    if (identical(this, other)) return true;
    return other.ongSelected == ongSelected && other.key == key;
  }

  @override
  int get hashCode {
    return ongSelected.hashCode ^ key.hashCode;
  }
}

class OrderHistoryDetailViewArguments {
  const OrderHistoryDetailViewArguments({
    required this.viewParameters,
    this.key,
  });

  final _i11.OrderHistoryDetailParameters viewParameters;

  final _i13.Key? key;

  @override
  String toString() {
    return '{"viewParameters": "$viewParameters", "key": "$key"}';
  }

  @override
  bool operator ==(covariant OrderHistoryDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.viewParameters == viewParameters && other.key == key;
  }

  @override
  int get hashCode {
    return viewParameters.hashCode ^ key.hashCode;
  }
}

extension NavigatorStateExtension on _i17.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView({
    _i13.Key? key,
    bool navigateOngSelector = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(
            key: key, navigateOngSelector: navigateOngSelector),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPersonalInformationView({
    required _i14.UserInformationFormParameters viewParameters,
    _i13.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.personalInformationView,
        arguments: PersonalInformationViewArguments(
            viewParameters: viewParameters, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateAccountView({
    required _i15.CreateAccountViewParameters viewParameters,
    _i13.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createAccountView,
        arguments: CreateAccountViewArguments(
            viewParameters: viewParameters, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNewDonationView({
    required _i16.Ong ongSelected,
    _i13.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.newDonationView,
        arguments: NewDonationViewArguments(ongSelected: ongSelected, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNewDonationConfirmedView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.newDonationConfirmedView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrdersHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.ordersHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderHistoryDetailView({
    required _i11.OrderHistoryDetailParameters viewParameters,
    _i13.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.orderHistoryDetailView,
        arguments: OrderHistoryDetailViewArguments(
            viewParameters: viewParameters, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOngSelectorView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.ongSelectorView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView({
    _i13.Key? key,
    bool navigateOngSelector = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(
            key: key, navigateOngSelector: navigateOngSelector),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPersonalInformationView({
    required _i14.UserInformationFormParameters viewParameters,
    _i13.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.personalInformationView,
        arguments: PersonalInformationViewArguments(
            viewParameters: viewParameters, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateAccountView({
    required _i15.CreateAccountViewParameters viewParameters,
    _i13.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createAccountView,
        arguments: CreateAccountViewArguments(
            viewParameters: viewParameters, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNewDonationView({
    required _i16.Ong ongSelected,
    _i13.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.newDonationView,
        arguments: NewDonationViewArguments(ongSelected: ongSelected, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNewDonationConfirmedView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.newDonationConfirmedView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrdersHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.ordersHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrderHistoryDetailView({
    required _i11.OrderHistoryDetailParameters viewParameters,
    _i13.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.orderHistoryDetailView,
        arguments: OrderHistoryDetailViewArguments(
            viewParameters: viewParameters, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOngSelectorView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.ongSelectorView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
