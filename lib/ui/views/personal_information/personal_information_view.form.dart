// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:microdonations/core/forms_validators/text_form_field.validators.dart';
import 'package:stacked/stacked.dart';

const String NameValueKey = 'name';
const String SurnameValueKey = 'surname';
const String PhoneValueKey = 'phone';
const String AddressValueKey = 'address';

final Map<String, TextEditingController>
    _PersonalInformationViewTextEditingControllers = {};

final Map<String, FocusNode> _PersonalInformationViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _PersonalInformationViewTextValidations = {
  NameValueKey: TextFormFieldValidators.notEmpty,
  SurnameValueKey: null,
  PhoneValueKey: null,
  AddressValueKey: null,
};

mixin $PersonalInformationView {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get surnameController =>
      _getFormTextEditingController(SurnameValueKey);
  TextEditingController get phoneController =>
      _getFormTextEditingController(PhoneValueKey);
  TextEditingController get addressController =>
      _getFormTextEditingController(AddressValueKey);
  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get surnameFocusNode => _getFormFocusNode(SurnameValueKey);
  FocusNode get phoneFocusNode => _getFormFocusNode(PhoneValueKey);
  FocusNode get addressFocusNode => _getFormFocusNode(AddressValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_PersonalInformationViewTextEditingControllers.containsKey(key)) {
      return _PersonalInformationViewTextEditingControllers[key]!;
    }

    _PersonalInformationViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _PersonalInformationViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_PersonalInformationViewFocusNodes.containsKey(key)) {
      return _PersonalInformationViewFocusNodes[key]!;
    }
    _PersonalInformationViewFocusNodes[key] = FocusNode();
    return _PersonalInformationViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    surnameController.addListener(() => _updateFormData(model));
    phoneController.addListener(() => _updateFormData(model));
    addressController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    surnameController.addListener(() => _updateFormData(model));
    phoneController.addListener(() => _updateFormData(model));
    addressController.addListener(() => _updateFormData(model));
  }

  static const bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NameValueKey: nameController.text,
          SurnameValueKey: surnameController.text,
          PhoneValueKey: phoneController.text,
          AddressValueKey: addressController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _PersonalInformationViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _PersonalInformationViewFocusNodes.values) {
      focusNode.dispose();
    }

    _PersonalInformationViewTextEditingControllers.clear();
    _PersonalInformationViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get nameValue => this.formValueMap[NameValueKey] as String?;
  String? get surnameValue => this.formValueMap[SurnameValueKey] as String?;
  String? get phoneValue => this.formValueMap[PhoneValueKey] as String?;
  String? get addressValue => this.formValueMap[AddressValueKey] as String?;

  set nameValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          NameValueKey: value,
        }),
    );

    if (_PersonalInformationViewTextEditingControllers.containsKey(
        NameValueKey)) {
      _PersonalInformationViewTextEditingControllers[NameValueKey]?.text =
          value ?? '';
    }
  }

  set surnameValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          SurnameValueKey: value,
        }),
    );

    if (_PersonalInformationViewTextEditingControllers.containsKey(
        SurnameValueKey)) {
      _PersonalInformationViewTextEditingControllers[SurnameValueKey]?.text =
          value ?? '';
    }
  }

  set phoneValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          PhoneValueKey: value,
        }),
    );

    if (_PersonalInformationViewTextEditingControllers.containsKey(
        PhoneValueKey)) {
      _PersonalInformationViewTextEditingControllers[PhoneValueKey]?.text =
          value ?? '';
    }
  }

  set addressValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          AddressValueKey: value,
        }),
    );

    if (_PersonalInformationViewTextEditingControllers.containsKey(
        AddressValueKey)) {
      _PersonalInformationViewTextEditingControllers[AddressValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasSurname =>
      this.formValueMap.containsKey(SurnameValueKey) &&
      (surnameValue?.isNotEmpty ?? false);
  bool get hasPhone =>
      this.formValueMap.containsKey(PhoneValueKey) &&
      (phoneValue?.isNotEmpty ?? false);
  bool get hasAddress =>
      this.formValueMap.containsKey(AddressValueKey) &&
      (addressValue?.isNotEmpty ?? false);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasSurnameValidationMessage =>
      this.fieldsValidationMessages[SurnameValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneValidationMessage =>
      this.fieldsValidationMessages[PhoneValueKey]?.isNotEmpty ?? false;
  bool get hasAddressValidationMessage =>
      this.fieldsValidationMessages[AddressValueKey]?.isNotEmpty ?? false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get surnameValidationMessage =>
      this.fieldsValidationMessages[SurnameValueKey];
  String? get phoneValidationMessage =>
      this.fieldsValidationMessages[PhoneValueKey];
  String? get addressValidationMessage =>
      this.fieldsValidationMessages[AddressValueKey];
}

extension Methods on FormViewModel {
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setSurnameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SurnameValueKey] = validationMessage;
  setPhoneValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneValueKey] = validationMessage;
  setAddressValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AddressValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    nameValue = '';
    surnameValue = '';
    phoneValue = '';
    addressValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      SurnameValueKey: getValidationMessage(SurnameValueKey),
      PhoneValueKey: getValidationMessage(PhoneValueKey),
      AddressValueKey: getValidationMessage(AddressValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _PersonalInformationViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _PersonalInformationViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      SurnameValueKey: getValidationMessage(SurnameValueKey),
      PhoneValueKey: getValidationMessage(PhoneValueKey),
      AddressValueKey: getValidationMessage(AddressValueKey),
    });
