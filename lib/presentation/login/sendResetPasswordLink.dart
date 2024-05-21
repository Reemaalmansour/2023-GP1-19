import 'package:flutter/material.dart';

import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/routes_maneger.dart';
import '../../shared/component/component.dart';

class ResetPasswordLinkSend extends StatelessWidget {
  const ResetPasswordLinkSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 100,
            ),
            responsive.sizedBoxH30,
            Text(
              "Thank you !",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: AppColors.blue),
            ),
            Text(
              "we send you the link for Reset your Password Please check your Inbox ",
              style: Theme.of(context).textTheme.headlineSmall!,
              textAlign: TextAlign.center,
            ),
            responsive.sizedBoxH30,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Back to LogIn"),
                onPressed: () {
                  navigateTo(context, AppRoutes.login);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
