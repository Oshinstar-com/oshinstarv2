import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hive/hive.dart';
import 'package:oshinstar/modules/landing/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:user/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'user_cubit.dart';
part 'meta_cubit.dart';
// part 'userv2_cubit.dart';
