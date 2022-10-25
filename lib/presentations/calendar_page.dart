import 'package:bgmi_flutter/internal/calendar/calendar_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../internal/calendar/bloc/calendar_bloc.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarBloc(),
      child: BlocConsumer<CalendarBloc, CalendarState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CalendarInitial) {
            context.read<CalendarBloc>().add(GetCalendarEvent());
            return Container();
          }
          if (state is CalendarLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CalendarFail) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.warning),
                  IconButton(
                    onPressed: () =>
                        context.read<CalendarBloc>().add(GetCalendarEvent()),
                    icon: const Icon(Icons.refresh),
                  ),
                  Text(state.exception.toString())
                ],
              ),
            );
          }
          if (state is CalendarFinish) {
            final calendarData = state.data.content;
            return CustomScrollView(
              slivers: [
                // const SliverToBoxAdapter(
                //   child: SizedBox(height: 16),
                // ),
                for (int i = 0; i < calendarData.entries.length * 2; i++)
                  i % 2 == 1
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          sliver: AnimeGrid(
                              data: calendarData.entries
                                  .elementAt((i / 2).floor())
                                  .value),
                        )
                      : SliverToBoxAdapter(
                          child: ListTile(
                            title: Text(
                              calendarData.entries
                                  .elementAt((i / 2).floor())
                                  .key
                                  .name,
                            ),
                          ),
                        ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
              ],
            );
          }
          throw UnimplementedError();
        },
      ),
    );
  }
}

class AnimeGrid extends StatelessWidget {
  const AnimeGrid({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<AnimeData> data;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final AnimeData item = data[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  item.cover.replaceFirst("/", "://"),
                ),
              ),
            ),
            child: Stack(
              children: [
                item.status == -1
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text(
                              "${item.episode}",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActionChip(
                      label: Text(
                        item.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: data.length,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 144,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
    );
  }
}
