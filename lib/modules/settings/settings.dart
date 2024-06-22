import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/helpers/router.dart';
import 'package:oshinstar/modules/limits_features/limits_features.dart';
import 'package:oshinstar/modules/settings/2fa_setup_screen.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:oshinstar/widgets/address_search_modal.dart';
import 'package:oshinstar/widgets/change_password_modal.dart';
import 'package:oshinstar/widgets/confirm_identity_modal.dart';
import 'package:oshinstar/widgets/error_snackbar.dart';
import 'package:oshinstar/widgets/hometown_modal.dart';
import 'package:oshinstar/widgets/hometown_search_modal.dart';
import 'package:oshinstar/widgets/location_search_modal.dart';
import 'package:oshinstar/widgets/manage_address_modal.dart';
import 'package:oshinstar/widgets/phone_numbers_modal.dart';
import 'package:oshinstar/widgets/show_email_verify_modal.dart';
import 'package:oshinstar/widgets/update_birthdate_modal.dart';
import 'package:intl/intl.dart';


part 'settings_screen.dart';
part 'manage_account_screen.dart';