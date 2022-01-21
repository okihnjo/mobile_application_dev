import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/theme_provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsUi extends ConsumerWidget {
  const SettingsUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.read(changeTheme).darkMode;
    final theme = Theme.of(context);
    return SettingsList(
      // shrinkWrap: true,
      // contentPadding: EdgeInsets.only(top: 25),
      sections: [
        SettingsSection(
          titlePadding: const EdgeInsets.only(top: 25, left: 15, bottom: 15),
          title: 'Accountsecurity',
          tiles: [
            SettingsTile(
              title: 'Account',
              trailing: Icon(Icons.arrow_forward_ios),
              // subtitle: 'English',
              leading: Icon(Icons.account_circle),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Notifications',
              trailing: Icon(Icons.arrow_forward_ios),
              // subtitle: 'English',
              leading: Icon(Icons.circle_notifications),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Privacy',
              trailing: Icon(Icons.arrow_forward_ios),
              // subtitle: 'English',
              leading: Icon(Icons.lock_outline_sharp),
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
        SettingsSection(
          titlePadding: EdgeInsets.all(15),
          title: 'App-Settings',
          tiles: [
            SettingsTile(
              title: 'Language',
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              leading: Icon(Icons.format_paint),
              title: "Theme",
              onToggle: (val) {
                if (isDarkMode) {
                  ref.read(changeTheme.notifier).enableLightMode();
                } else {
                  ref.read(changeTheme.notifier).enableDarkMode();
                }
              },
              switchValue: ref.read(changeTheme).darkMode,
            ),
            SettingsTile(
              title: 'Premium',
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.verified_user),
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
        SettingsSection(
          titlePadding: EdgeInsets.all(15),
          title: 'Support',
          tiles: [
            SettingsTile(
              title: 'FAQ',
              // subtitle: 'English',
              leading: Icon(Icons.question_answer_rounded),
              trailing: Icon(Icons.arrow_forward_ios),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Bugs',
              // subtitle: 'English',
              leading: Icon(Icons.bug_report),
              trailing: Icon(Icons.arrow_forward_ios),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Feedback',
              // subtitle: 'English',
              leading: Icon(Icons.feedback),
              trailing: Icon(Icons.arrow_forward_ios),
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
        SettingsSection(
          titlePadding: EdgeInsets.all(15),
          tiles: [
            SettingsTile(
                title: 'SignOut',
                // subtitle: 'English',
                leading: Icon(Icons.logout),
                onPressed: (BuildContext context) =>
                    {FirebaseAuth.instance.signOut()}),
          ],
        ),
      ],
    );
  }
}
