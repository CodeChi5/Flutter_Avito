import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/theme/blocs/theme_bloc.dart';
import 'package:myapp/theme/blocs/theme_event.dart' as event;
import 'package:myapp/theme/blocs/theme_state.dart';
import 'package:myapp/user/blocs/auth_state_bloc.dart';
import 'package:myapp/user/data/user_repo.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Theme Mode'),
                subtitle: Text(_getThemeModeText(state.themeMode)),
                trailing: DropdownButton<ThemeMode>(
                  value: state.themeMode,
                  items: ThemeMode.values.map((ThemeMode mode) {
                    return DropdownMenuItem<ThemeMode>(
                      value: mode,
                      child: Text(_getThemeModeText(mode)),
                    );
                  }).toList(),
                  onChanged: (ThemeMode? newMode) {
                    if (newMode != null) {
                      context
                          .read<ThemeBloc>()
                          .add(event.ThemeChanged(newMode));
                    }
                  },
                ),
              );
            },
          ),
          BlocBuilder<AuthStateBloc, AuthStateState>(
            builder: (context, state) {
              if (state.isAuthenticated) {
                return Column(
                  children: [
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () async {
                        final userRepo = context.read<UserRepo>();
                        await userRepo.logout();
                        context.read<AuthStateBloc>().add(
                              const UpdateAuthState(
                                isAuthenticated: false,
                                token: null,
                                userId: null,
                              ),
                            );
                      },
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}
