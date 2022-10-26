import 'package:bgmi_flutter/internal/setting/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitPage extends StatelessWidget {
  String server = "";
  String secret = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is SettingIdle) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).highlightColor,
              content: const Text('Success'),
            ),
          );
        }
        if (state is SettingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              content: const Text('Error'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                  onChanged: (value) {
                    server = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                  onChanged: (value) {
                    secret = value;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (state is SettingLoading) {
                    return;
                  }
                  context.read<SettingBloc>().add(
                        ModifyServerEvent(server: server, secret: secret),
                      );
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: state is SettingLoading
                      ? const CircularProgressIndicator()
                      : const Text("Submit"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
