import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/stats/bloc/stats_bloc.dart';
import 'package:task_manager_app/stats/view/stats_view.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsBloc()..add(const StatsSubscriptionRequested()),
      child: const StatsView(),
    );
  }
}
