import "package:flutter/material.dart";
import 'package:settings_ui/settings_ui.dart';

class SettingsUi extends StatelessWidget {
  const SettingsUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      // shrinkWrap: true,
      // contentPadding: EdgeInsets.only(top: 25),
      sections: [
        SettingsSection(
          titlePadding: const EdgeInsets.only(top: 25, left: 15, bottom: 15),
          title: 'Kontosicherheit',
          tiles: [
            SettingsTile(
              title: 'Konto',
              trailing: Icon(Icons.arrow_forward_ios),
              // subtitle: 'English',
              leading: Icon(Icons.account_circle),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Benachrichtigung',
              trailing: Icon(Icons.arrow_forward_ios),
              // subtitle: 'English',
              leading: Icon(Icons.circle_notifications),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Privatsphäre',
              trailing: Icon(Icons.arrow_forward_ios),
              // subtitle: 'English',
              leading: Icon(Icons.lock_outline_sharp),
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
        SettingsSection(
          titlePadding: EdgeInsets.all(15),
          title: 'App-Einstellungen',
          tiles: [
            SettingsTile(
              title: 'Sprache',
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Theme',
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.bedtime_rounded),
              onPressed: (BuildContext context) {},
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
              title: 'Bugs und Fehler',
              // subtitle: 'English',
              leading: Icon(Icons.bug_report),
              trailing: Icon(Icons.arrow_forward_ios),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Gib uns Feedback',
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
                title: 'Abmelden',
                // subtitle: 'English',
                leading: Icon(Icons.logout),
                onPressed: (BuildContext context) => {}),
          ],
        ),
      ],
    );
  }
}
