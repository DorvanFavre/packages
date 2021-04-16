part of '../messenger.dart';

/// Room material
/// 
/// Provide subtree with
///  * roomViewModel - context.read<RoomViewModel()
///  * Current user authenticated - context.read<String>()
class RoomMaterial extends StatelessWidget {
  final RoomViewModel viewModel;
  final Widget child;

  RoomMaterial({@required this.viewModel, @required this.child});

  @override
  Widget build(BuildContext context) {
    // Provide RoomViewModel
    return Provider.value(
      value: viewModel,
      builder: (context, _) {
        return StreamBuilder<AuthState>(
          stream: context.read<RoomViewModel>().authViewModel.authStateStream,
          builder: (context, authStateSnap) {
            if (authStateSnap.connectionState != ConnectionState.active) {
              return SizedBox.shrink();
            } else {
              final authState = authStateSnap.data;
              if (authState is UserLoggedIn) {
                // Provide current user
                return Provider<String>.value(
                  value: authState.userId,
                  builder: (context, _) {
                    //
                    return child;
                  },
                );
              } else {
                return Center(
                  child: Text('No User Logged In'),
                );
              }
            }
          },
        );
      },
    );
  }
}
