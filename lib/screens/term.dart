import 'package:eduappui/screens/main_screen.dart';
import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(226, 134, 253, 237),
      appBar: AppBar(
        title: Center(child: Text('Terms & Conditions')),
        backgroundColor: Color.fromARGB(189, 7, 206, 43),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            _buildContent(
                'By downloading or using the app, these terms will automatically apply to you - you should make sure therefore that you read them carefully before using the app. You\'re not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. You\'re not allowed to attempt to extract the source code of the app, and you also shouldn\'t try to translate the app into other languages, or make derivative versions. The app itself, and all the trade marks, copyright, database rights and other intellectual property rights related to it, still belong to .'),
            _buildContent(
                ' is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you\'re paying for.'),
            _buildContent(
                'At some point, we may wish to update the app. The app is currently available on iOS – the requirements for system (and for any additional systems we decide to extend the availability of the app to) may change, and you\'ll need to download the updates if you want to keep using the app. does not promise that it will always update the app so that it is relevant to you and/or works with the iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you. We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.'),
            SizedBox(height: 16.0),
            Text(
              'Changes to This Terms and Conditions',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            _buildContent(
                'We may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page. These changes are effective immediately after they are posted on this page.'),
            SizedBox(height: 16.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            _buildContent(
                'If you have any questions or suggestions about our Terms and Conditions, do not hesitate to contact us at +229.'),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
