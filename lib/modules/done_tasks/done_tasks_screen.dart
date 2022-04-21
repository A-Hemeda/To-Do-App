import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/task_item.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // change Language variable
    var lan = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Text(
                          lan.getTexts('done').toString(),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: tasks.length > 0
                          ? Text(
                              lan.getTexts('done').toString(),
                              style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 17,
                                fontFamily: 'NotoSans',
                              ),
                            )
                          : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    tasks.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TaskItem(
                                tasks: tasks[index],
                              );
                            },
                            itemCount: tasks.length)
                        : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                children: [
                                  Container(
                                      child: Center(
                                          child: Image.asset(
                                    'images/done_tasks.png',
                                    height: 150,
                                    width: 150,
                                  ))),
                                  SizedBox(
                                            height: 10,
                                          ),
                                  Padding(
                                    padding: const EdgeInsets.all(50),
                                    child: Text(
                                      lan.getTexts('there_is_done_tasks').toString(),
                                      style: Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
