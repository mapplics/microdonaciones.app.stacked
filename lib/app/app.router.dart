// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i11;
import 'package:flutter/material.dart';
import 'package:microdonations/core/parameters/create_account_view.parameters.model.dart'
    as _i13;
import 'package:microdonations/core/parameters/personal_information_view.parameters.model.dart'
    as _i12;
import 'package:microdonations/ui/views/create_account/create_account_view.dart'
    as _i7;
import 'package:microdonations/ui/views/home/home_view.dart' as _i2;
import 'package:microdonations/ui/views/login/login_view.dart' as _i4;
import 'package:microdonations/ui/views/make_a_donation/make_a_donation_view.dart'
    as _i8;
import 'package:microdonations/ui/views/new_donation_confirmed/new_donation_confirmed_view.dart'
    as _i10;
import 'package:microdonations/ui/views/onboarding/onboarding_view.dart' as _i5;
import 'package:microdonations/ui/views/personal_information/personal_information_view.dart'
    as _i6;
import 'package:microdonations/ui/views/select_delivery_method/select_delivery_method_view.dart'
    as _i9;
import 'package:microdonations/ui/views/startup/startup_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i14;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const loginView = '/login-view';

  static const onboardingView = '/onboarding-view';

  static const personalInformationView = '/personal-information-view';

  static const createAccountView = '/create-account-view';

  static const makeADonationView = '/make-adonation-view';

  static const selectDeliveryMethodView = '/select-delivery-method-view';

  static const newDonationConfirmedView = '/new-donation-confirmed-view';

  static const all = <String>{
    homeView,
    startupView,
    loginView,
    onboardingView,
    personalInformationView,
    createAccountView,
    makeADonationView,
    selectDeliveryMethodView,
    newDonationConfirmedView,
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
      Routes.makeADonationView,
      page: _i8.MakeADonationView,
    ),
    _i1.RouteDef(
      Routes.selectDeliveryMethodView,
      page: _i9.SelectDeliveryMethodView,
    ),
    _i1.RouteDef(
      Routes.newDonationConfirmedView,
      page: _i10.NewDonationConfirmedView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.LoginView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginView(),
        settings: data,
      );
    },
    _i5.OnboardingView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.OnboardingView(),
        settings: data,
      );
    },
    _i6.PersonalInformationView: (data) {
      final args =
          data.getArgs<PersonalInformationViewArguments>(nullOk: false);
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.PersonalInformationView(
            viewParameters: args.viewParameters, key: args.key),
        settings: data,
      );
    },
    _i7.CreateAccountView: (data) {
      final args = data.getArgs<CreateAccountViewArguments>(nullOk: false);
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.CreateAccountView(
            viewParameters: args.viewParameters, key: args.key),
        settings: data,
      );
    },
    _i8.MakeADonationView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.MakeADonationView(),
        settings: data,
      );
    },
    _i9.SelectDeliveryMethodView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.SelectDeliveryMethodView(),
        settings: data,
      );
    },
    _i10.NewDonationConfirmedView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.NewDonationConfirmedView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class PersonalInformationViewArguments {
  const PersonalInformationViewArguments({
    required this.viewParameters,
    this.key,
  });

  final _i12.UserInformationFormParameters viewParameters;

  final _i11.Key? key;

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

  final _i13.CreateAccountViewParameters viewParameters;

  final _i11.Key? key;

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

extension NavigatorStateExtension on _i14.NavigationService {
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

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
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
    required _i12.UserInformationFormParameters viewParameters,
    _i11.Key? key,
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
    required _i13.CreateAccountViewParameters viewParameters,
    _i11.Key? key,
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

  Future<dynamic> navigateToMakeADonationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.makeADonationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSelectDeliveryMethodView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.selectDeliveryMethodView,
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

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
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
    required _i12.UserInformationFormParameters viewParameters,
    _i11.Key? key,
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
    required _i13.CreateAccountViewParameters viewParameters,
    _i11.Key? key,
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

  Future<dynamic> replaceWithMakeADonationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.makeADonationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSelectDeliveryMethodView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.selectDeliveryMethodView,
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
}
