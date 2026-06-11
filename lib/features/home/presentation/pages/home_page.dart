import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_forge/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_app_forge/features/home/presentation/bloc/home_event.dart';
import 'package:my_app_forge/features/home/presentation/widgets/home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Blueprint'),
        centerTitle: false,
      ),
      body: const HomeBody(),
    );
  }
}
