import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo_app/shared/cubit/cubit.dart';

class TaskItem extends StatelessWidget {
  Map? tasks;

  TaskItem({this.tasks});

  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    // change theme variable
    var changeTheme = AppCubit.get(context);

    String date = tasks!['date'];
    String time = tasks!['time'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
      child: Slidable(
        key: Key(tasks!['title']),
        dismissal: SlidableDismissal(
          dismissThresholds: <SlideActionType, double>{
            SlideActionType.secondary: 1.0
          },
          child: SlidableDrawerDismissal(),
          onDismissed: (actionType) {
            AppCubit.get(context).deleteFromDatabase(tasks!['id']);
          },
        ),
        controller: slidableController,
        enabled: true,
        actionExtentRatio: 0.2,
        movementDuration: Duration(microseconds: 10),
        actionPane: SlidableScrollActionPane(),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            child: IconSlideAction(
              closeOnTap: true,
              caption: AppCubit.get(context).getTexts('delete').toString(),
              color: Colors.red[900],
              icon: Icons.delete_forever,
              onTap: () {
                AppCubit.get(context).deleteFromDatabase(tasks!['id']);
              },
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            child: IconSlideAction(
              closeOnTap: true,
              caption: AppCubit.get(context).getTexts('archive').toString(),
              color: Colors.grey[700],
              icon: Icons.archive,
              onTap: () {
                AppCubit.get(context).updateDatabase('archived', tasks!['id']);
              },
            ),
          ),
        ],
        secondaryActions: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            child: tasks!['status'] == 'archived' || tasks!['status'] == 'done'
                ? IconSlideAction(
                    closeOnTap: true,
                    caption: AppCubit.get(context)
                        .getTexts('add_to_task')
                        .toString(),
                    color: Colors.cyan[900],
                    icon: Icons.add_box,
                    onTap: () {
                      AppCubit.get(context).updateDatabase('New', tasks!['id']);
                    },
                  )
                : IconSlideAction(
                    closeOnTap: true,
                    caption:
                        AppCubit.get(context).getTexts('done_tasks').toString(),
                    color: Colors.green[900],
                    icon: Icons.check_circle,
                    onTap: () {
                      AppCubit.get(context)
                          .updateDatabase('done', tasks!['id']);
                    },
                  ),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                //change border color acc to theme
                border: changeTheme.isDark
                    ? Border.all(color: Colors.grey)
                    : Border.all(color: Colors.white10),

                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2, right: 10),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$date',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Text(
                              tasks!['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: tasks!['status'] == 'done'
                                  ? Theme.of(context).textTheme.headline6
                                  : Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        time,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//AppCubit.get(context).deleteFromDatabase(tasks!['id']);
