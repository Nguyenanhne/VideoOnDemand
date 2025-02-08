import 'package:du_an_cntt/responsive.dart';
import 'package:du_an_cntt/view_models/resume_vm.dart';
import 'package:du_an_cntt/views/resume/resume_mobile.dart';
import 'package:du_an_cntt/views/resume/resume_tablet.dart';
import 'package:du_an_cntt/views/resume/resume_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyResumeScreen extends StatefulWidget {
  final String filmID;
  const MyResumeScreen({super.key, required this.filmID});

  @override
  State<MyResumeScreen> createState() => _MyResumeScreenState();
}

class _MyResumeScreenState extends State<MyResumeScreen> {
  late Future<void> getLastVideoPositon;
  @override
  void initState() {
    super.initState();
    final resumeVM = Provider.of<ResumeViewModel>(context, listen: false);
    getLastVideoPositon = resumeVM.getVideoPosition(widget.filmID);
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileLayout: MyResumeScreenMobile(getLastVideoPositon: getLastVideoPositon, filmID: widget.filmID),
        tabletLayout: MyResumeScreenTablet(), webLayout: MyResumeScreenWeb());
  }
}