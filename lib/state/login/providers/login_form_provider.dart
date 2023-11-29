import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/login_form_state.dart';
import '../notifiers/login_form_notifier.dart';

/// author kevin
/// date 2023/11/3 11:40

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>(
  (ref) => LoginFormNotifier(),
);
