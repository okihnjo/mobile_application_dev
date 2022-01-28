import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/user_provider.dart';
import 'package:settings_ui/settings_ui.dart';

class Privacy extends ConsumerWidget {
  const Privacy({Key? key}) : super(key: key);
  static const String routeName = "/privacy";
  @override
  Widget build(BuildContext context, ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final pictureStatus = ref.watch(getPictureStatusProvider(currentUser?.uid));
    return pictureStatus.when(
        data: (data) => Scaffold(
              appBar: AppBar(),
              body: SettingsList(
                  // shrinkWrap: true,
                  // contentPadding: EdgeInsets.only(top: 25),
                  sections: [
                    SettingsSection(
                      titlePadding: EdgeInsets.all(15),
                      title: 'App-Settings',
                      tiles: [
                        SettingsTile.switchTile(
                            leading: Icon(Icons.format_paint),
                            title: "Show Profilepicture",
                            onToggle: (val) {
                              ref
                                  .read(userProvider)
                                  .updatePictureStatus(currentUser?.uid, val);
                            },
                            switchValue: ref.watch(userProvider).showPic),
                      ],
                    )
                  ]),
            ),
        error: (err, ref) => Container(),
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}
