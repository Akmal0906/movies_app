import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/data/hive_box/local_storage.dart';
import 'package:movies_app/utilis/all_colors.dart';
import '../../../utilis/all_text.dart';
import '../../blocs/navigation_cubit/navigation_cubit.dart';
import '../../widgets/elevated_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 12,right: 12,top: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 12),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AllColors.saveButtonBackColor,
                child: Center(
                  child: Text(
                    userData.get('name')==null?'U':userData.get('name').toString().substring(0,1),
                    style: customStyle.copyWith(fontSize: 17),
                  ),
                ),
              ),
            ),
            Text(
              userData.get('name')??'User',
              style: customStyle.copyWith(fontSize: 16),
            ),
            Text(
              user!.email.toString(),
              style: customStyle.copyWith(fontSize: 16),
            ),
            elevatedButtonWidget(
              context,
              () {
                FirebaseAuth.instance.signOut();
                userData.clear();
                context.read<NavigationCubit>().changeIndex(0);
                context.pushReplacementNamed('signin');
              },
              const Size(200, 48),
              'Sign Out',
              AllColors.primaryBackColor,
            ),
          ],
        ),
      ),
    );
  }
}
