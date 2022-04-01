import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc.dart';

class gps_access_screena extends StatelessWidget {
  const gps_access_screena({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return !state.isGpsEnable
              ? const _EnableGpsMessage()
              : const _Access_button();
        },
      )
          //_Access_button(),
          ),
    );
  }
}

class _Access_button extends StatelessWidget {
  const _Access_button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Es necesario el Accesso GPS"),
        MaterialButton(
            child: const Text("Solicitar accesso",
                style: TextStyle(color: Colors.white)),
            color: Colors.black,
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Color.fromARGB(255, 96, 169, 230),
            onPressed: () {
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              gpsBloc.askGps();
            })
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Necesita habilitar gps",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}
