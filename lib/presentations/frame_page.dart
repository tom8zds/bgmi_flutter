import 'package:bgmi_flutter/presentations/index_page.dart';
import 'package:flutter/material.dart';

import 'calendar_page.dart';
import 'total_view_page.dart';
import 'widgets/adaptive_scaffold.dart';

class FramePage extends StatelessWidget {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      favicon: const Image(
        image: NetworkImage("http://192.168.3.1:10180/static/logo144.jpg"),
        height: 20,
        width: 20,
      ),
      title: "BGMI FLUTTER",
      subTitle: "PREVIEW",
      destinations: [
        AdaptiveScaffoldDestination(
          icon: const Icon(Icons.subscriptions),
          title: "追番",
        ),
        AdaptiveScaffoldDestination(
            icon: const Icon(Icons.calendar_month), title: "时间表"),
        AdaptiveScaffoldDestination(
          icon: const Icon(Icons.store),
          title: "全部番剧",
        ),
      ],
      pages: [
        const IndexPage(),
        CalendarPage(),
        TotalViewPage(),
      ],
    );
  }
}
