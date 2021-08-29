import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app_flutter/modules/counter/cubit/cubit.dart';

import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterMinusState) print('${state.counter}');
          if (state is CounterPlusState) print('${state.counter}');
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Text('Minus')),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('${CounterCubit.get(context).counter}')),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: Text('Plus'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
