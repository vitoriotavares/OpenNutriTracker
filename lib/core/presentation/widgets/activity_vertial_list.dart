import 'package:flutter/material.dart';
import 'package:opennutritracker/core/domain/entity/user_activity_entity.dart';
import 'package:opennutritracker/core/presentation/widgets/activity_card.dart';
import 'package:opennutritracker/core/presentation/widgets/placeholder_card.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';
import 'package:opennutritracker/features/add_activity/presentation/add_activity_screen.dart';

class ActivityVerticalList extends StatelessWidget {
  final DateTime day;
  final String title;
  final List<UserActivityEntity> userActivityList;
  final Function(BuildContext, UserActivityEntity) onItemLongPressedCallback;

  const ActivityVerticalList(
      {super.key,
      required this.day,
      required this.title,
      required this.userActivityList,
      required this.onItemLongPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(UserActivityEntity.getIconData(),
                  size: 24, color: Theme.of(context).colorScheme.onSurface),
              const SizedBox(width: 4.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  if (userActivityList.isNotEmpty)
                    Text(
                      '${userActivityList.length} ${userActivityList.length == 1 ? 'activity' : 'activities'}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount:
                userActivityList.length + 1, // List length + placeholder card
            separatorBuilder: (context, index) =>
                const SizedBox(width: 8.0), // Gap between cards
            itemBuilder: (BuildContext context, int index) {
              final firstListElement = index == 0 ? true : false;
              if (index == userActivityList.length) {
                return PlaceholderCard(
                    day: day,
                    onTap: () => _onPlaceholderCardTapped(context),
                    firstListElement: firstListElement);
              } else {
                final userActivity = userActivityList[index];
                return ActivityCard(
                  activityEntity: userActivity,
                  onItemLongPressed: onItemLongPressedCallback,
                  firstListElement: firstListElement,
                );
              }
            },
          ),
        )
      ],
    );
  }

  void _onPlaceholderCardTapped(BuildContext context) {
    Navigator.of(context).pushNamed(NavigationOptions.addActivityRoute,
        arguments: AddActivityScreenArguments(day: day));
  }
}
