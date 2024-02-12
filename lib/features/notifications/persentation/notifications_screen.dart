import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/notifications/cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class NotificationsScreen extends StatelessWidget {
  static const String routeName = '/notifications';

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsInitial) {
              context.read<NotificationsCubit>().loadNotifications();
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NotificationsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NotificationsLoaded) {
              return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                        color: state.notifications[index].isRead!
                            ? Colors.white
                            : primaryColor.withOpacity(0.1),
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2)))),
                    child: ListTile(
                      leading: Icon(
                        IconlyBold.notification,
                        color: state.notifications[index].isRead!
                            ? Colors.grey
                            : Colors.blue,
                      ),
                      title: Text(state.notifications[index].title!),
                      subtitle: Text(
                        state.notifications[index].message!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              );
            } else if (state is NotificationsError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
