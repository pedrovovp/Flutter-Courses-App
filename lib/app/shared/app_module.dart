import 'package:app/app/pages/register/register_bloc.dart';
import 'package:app/app/home/repositories/post_repository.dart';
import 'package:app/app/pages/login/login_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:app/app/shared/app_widget.dart';
import 'package:app/app/shared/app_bloc.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => RegisterBloc()),
        Bloc((i) => LoginBloc()),
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => PostRepository()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
