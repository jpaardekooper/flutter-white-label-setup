import 'package:base/page/ui/widgets/components/logo.dart';
import 'package:base/page/ui/widgets/faq/faq_expansion_panel.dart';
import 'package:base/page/ui/widgets/text/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:base/models/faq_item.dart';
import 'package:base/state/faq_view_model.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FAQState>(context, listen: false).fetchFAQData();
  }

  @override
  Widget build(BuildContext context) {
    var faq = Provider.of<FAQState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: AppbarLogo(),
          automaticallyImplyLeading: false,
          centerTitle: true),
      body: faq.faqList.isEmpty
          ? LoadingState(message: 'FAQ')
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: faq.faqList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                FAQItem _FAQ = faq.faqList[index];
                return FaqExpansionPanel(_FAQ);
              },
            ),
    );
  }
}
