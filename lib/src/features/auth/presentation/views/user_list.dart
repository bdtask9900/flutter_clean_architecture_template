import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/features/auth/presentation/notifiers/auth_controller.dart';

import '../../../../core/states/api.state.dart';
import '../notifiers/user_list_provider.dart';

class UserList extends ConsumerStatefulWidget {
  const UserList({super.key});

  @override
  ConsumerState<UserList> createState() => _UserListState();
}

class _UserListState extends ConsumerState<UserList> {
  late UserListProvider provider;
  @override
  Widget build(BuildContext context) {
    // provider = ref.watch(getUsersProvider);
    // provider.init();
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.watch(authNotifierProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Get User list"),
        ),
        body:
            // provider.haveData
            //     ?
            Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => authNotifier.fetchUser(100),
                  child: Text('Fetch User'),
                ),
                if (authState.userState.status == ApiStatus.loading)
                  CircularProgressIndicator()
                else if (authState.userState.status == ApiStatus.success &&
                    authState.userState.data != null)
                  Text('User: ${authState.userState.data!.firstName}'),
                if (authState.userState.status == ApiStatus.error)
                  Text('Error: ${authState.userState.message}'),

                ElevatedButton(
                  onPressed: () => authNotifier.fetchProducts(),
                  child: Text('Fetch Products'),
                ),
                if (authState.productState.status == ApiStatus.loading)
                  CircularProgressIndicator()
                else if (authState.productState.status == ApiStatus.success &&
                    authState.productState.data != null)
                  ...authState.productState.data!
                      .map((product) => Text('Product: ${product.name}')),
                if (authState.productState.status == ApiStatus.error)
                  Text('Error: ${authState.productState.message}'),
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: provider.list.length,
                //     itemBuilder: (context, index){
                //       return ListTile(
                //         leading:  ClipRRect(
                //             borderRadius: BorderRadius.circular(50),
                //             child: Image.network("${provider.list[index].avatar}")
                //           ),
                //         title: Text('${provider.list[index].firstName}'),
                //         subtitle: Text('${provider.list[index].lastName}'),
                //       );
                //     })
              ],
            ),
          ),
        )
        // : const Center(child: CircularProgressIndicator() )
        );
  }
}
