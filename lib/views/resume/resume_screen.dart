import 'package:du_an_cntt/views/responsive.dart';
import 'package:du_an_cntt/view_models/resume_vm.dart';
import 'package:du_an_cntt/views/resume/resume_mobile.dart';
import 'package:du_an_cntt/views/resume/resume_tablet.dart';
import 'package:du_an_cntt/views/resume/resume_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class MyResumeScreen extends StatefulWidget {
  final String filmID;
  const MyResumeScreen({super.key, required this.filmID});

  @override
  State<MyResumeScreen> createState() => _MyResumeScreenState();
}

class _MyResumeScreenState extends State<MyResumeScreen> {
  late Future<void> getLastVideoPosition;
  @override
  void initState() {
    super.initState();
    final resumeVM = Provider.of<ResumeViewModel>(context, listen: false);
    getLastVideoPosition = resumeVM.getVideoPosition(widget.filmID);
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: MyResumeScreenMobile(getLastVideoPosition: getLastVideoPosition, filmID: widget.filmID),
      tabletLayout: MyResumeScreenTablet(getLastVideoPosition: getLastVideoPosition, filmID: widget.filmID),
      webLayout: MyResumeScreenWeb(getLastVideoPosition: getLastVideoPosition, filmID: widget.filmID)
    );
  }
}