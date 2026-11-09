import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../analysis/presentation/hr_archive_screen.dart';
import '../../analysis/presentation/hr_studio_screen.dart';
import '../../settings/presentation/settings_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final pages = const [
      HrStudioScreen(),
      HrArchiveScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (idx) => setState(() => _index = idx),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.fact_check_outlined),
            selectedIcon: const Icon(Icons.fact_check),
            label: l10n.navStudio,
          ),
          NavigationDestination(
            icon: const Icon(Icons.folder_shared_outlined),
            selectedIcon: const Icon(Icons.folder_shared),
            label: l10n.navArchive,
          ),
          NavigationDestination(
            icon: const Icon(Icons.tune_outlined),
            selectedIcon: const Icon(Icons.tune),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
