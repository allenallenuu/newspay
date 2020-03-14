

import 'package:wpay_app/view_model/state_lib.dart';
import 'package:wpay_app/view_model/payment_method_model.dart';

import 'fp_user_model.dart';

class MainStateModel extends Model with
    FPUserModel,PaymentMethodModel
{
  MainStateModel of(context) =>
      ScopedModel.of<MainStateModel>(context, rebuildOnChange: false);
}
