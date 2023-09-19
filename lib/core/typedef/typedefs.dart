import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Funcion que espera un [FormGroup].
/// Lo utilizamos para que un formulario envie el mismo a un widget padre.
typedef OnChangeForm = void Function(FormGroup form);

/// funcion que espera un bool.
/// Lo utilizamos para enviar el valor [newValue] a un widget padre.
typedef OnChangeCheckbox = void Function(bool newValue);

/// Lo utilizamos para enviar el valor [newValue] a un widget padre.
typedef OnChangeQuantityPicker = void Function(int newValue);

/// Lo utilizamos para enviar el valor [newValue] a un widget padre.
typedef OnChangeTypeDelivery = void Function(TypeDelivery newValue);

typedef OnChangeDropdownButton = void Function<T>(T newValue);

typedef OnChangeRadioButton = void Function<T>(T newValue);

typedef OnChangeWeekdayPicker = void Function(DateTime value);
