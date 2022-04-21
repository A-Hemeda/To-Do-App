import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/task_item.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// change Language variable
    var lan = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
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
                          lan.getTexts('tasks').toString(),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: tasks.length > 0
                          ? Text(
                              lan.getTexts('tasks').toString(),
                              style: TextStyle(
                                color: Colors.cyan[900],
                                fontSize: 17,
                                fontFamily: lan.isEn ?  'NotoSans' : 'Noto Kufi Arabic' ,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Center(
                                          child: Image.asset(
                                    'images/add_tasks.png',
                                    height: 150,
                                    width: 150,
                                  ))),
                                  Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(50),
                                  child: Column(
                                    children: [
                                      Text(
                                        lan
                                            .getTexts('there_is_no_tasks')
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        lan
                                            .getTexts('start_add_your_tasks')
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ],
                                  ),
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
