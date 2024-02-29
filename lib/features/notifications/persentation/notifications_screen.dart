import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/notifications/cubit/notifications_cubit.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = '/notifications';

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  initState() {
    super.initState();
    // context.read<NotificationsCubit>().loadNotifications();
    markAllAsRead();
  }

  markAllAsRead() async {
    await RequestHelper.post('read/notifications/', {});
    if (context.mounted) {
      try {
        context.read<ProfileBloc>().add(const LoadMyProfile());
      } catch (e) {
        print(e);
      }
    }
  }

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
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                        color: state.notifications[index].isRead!
                            ? Colors.white
                            : primaryColor.withOpacity(0.1),
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2)))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          state.notifications[index].onTap!();
                        },
                        child: ListTile(
                          leading: state.notifications[index].trialing == null
                              ? Icon(
                                  IconlyBold.notification,
                                  color: state.notifications[index].isRead!
                                      ? Colors.grey
                                      : Colors.blue,
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    '${ApiEndpoints.baseUrl}/${state.notifications[index].trialing}',
                                    scale: 1.0,
                                  ),
                                ),
                          title: Text(state.notifications[index].title!),
                          subtitle: Text(
                            state.notifications[index].message!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
