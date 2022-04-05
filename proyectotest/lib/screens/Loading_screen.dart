import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectotest/profile_screen.dart';
import 'package:proyectotest/screens/ScreenPrincipal.dart';
import 'package:proyectotest/screens/screens.dart';

import '../blocs/bloc.dart';

class LoadinfScreen extends StatelessWidget {
  const LoadinfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        return ScreenPrincipal();
      },
    ));
  }
}
