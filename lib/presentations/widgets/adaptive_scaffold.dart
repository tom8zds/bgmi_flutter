import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatefulWidget {
  final List<AdaptiveScaffoldDestination> destinations;
  final List<Widget> pages;
  final String title;
  final String subTitle;
  final Widget favicon;
  const AdaptiveScaffold(
      {Key? key,
      required this.destinations,
      required this.pages,
      required this.title,
      required this.subTitle,
      required this.favicon})
      : super(key: key);

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

enum NavType { bottom, rail, panel }

extension NavTypeX on NavType {
  double getWidth() {
    switch (this) {
      case NavType.bottom:
        return 0;
      case NavType.rail:
        return 72;
      case NavType.panel:
        return 304;
    }
  }
}

class AdaptiveScaffoldDestination {
  final Widget icon;
  final String title;

  AdaptiveScaffoldDestination({
    required this.icon,
    required this.title,
  });

  Widget get label => Text(title);
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  int _selectedIndex = 0;
  NavType _navType = NavType.rail;

  // void applyAcrylic() async {
  //   await Window.setEffect(
  //     effect: WindowEffect.mica,
  //     dark: false,
  //   );
  // }

  void checkWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 960) {
      if (_navType == NavType.bottom) {
        _navType = NavType.rail;
      }
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          _navType = NavType.panel;
        });
      });
      return;
    }
    if (width > 640) {
      _navType = NavType.rail;
      return;
    }
    if (_navType == NavType.panel) {
      _navType = NavType.rail;
    }
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _navType = NavType.bottom;
      });
    });
  }

  Widget buildSideNavigator() {
    switch (_navType) {
      case NavType.bottom:
        return Container();
      case NavType.rail:
        return NavigationRail(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          labelType: NavigationRailLabelType.all,
          destinations: widget.destinations
              .map(
                (e) => NavigationRailDestination(
                  icon: e.icon,
                  label: e.label,
                ),
              )
              .toList(),
        );
      case NavType.panel:
        return Drawer(
          child: Column(
            children: [
              for (var d in widget.destinations)
                SizedBox(
                  width: 304,
                  child: ListTile(
                    leading: d.icon,
                    title: d.label,
                    selected: widget.destinations.indexOf(d) == _selectedIndex,
                    onTap: () {
                      setState(() {
                        _selectedIndex = widget.destinations.indexOf(d);
                      });
                    },
                  ),
                ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // applyAcrylic();
    checkWidth();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: SizedBox(
          width: 48,
          child: Row(
            children: [
              // SizedBox(
              //   width: 16,
              // ),
              SizedBox(
                width: 56,
                child: Center(
                  child: widget.favicon,
                ),
              ),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 11),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.subTitle,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _navType.getWidth(),
            child: buildSideNavigator(),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).cardColor,
              child: widget.pages.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _navType == NavType.bottom ? 80 : 0,
        child: NavigationBar(
            selectedIndex: _selectedIndex,
            destinations: widget.destinations
                .map(
                  (e) => NavigationDestination(
                    icon: e.icon,
                    label: e.title,
                  ),
                )
                .toList()),
      ),
    );
  }
}
