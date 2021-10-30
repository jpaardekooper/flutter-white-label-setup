import 'package:flutter/material.dart';
import 'package:base/models/faq_item.dart';

class FaqExpansionPanel extends StatefulWidget {
  FaqExpansionPanel(this.faq);
  final FAQItem faq;

  @override
  State<FaqExpansionPanel> createState() => _FaqExpansionPanelState();
}

class _FaqExpansionPanelState extends State<FaqExpansionPanel> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionPanelList(
        animationDuration: Duration(milliseconds: 500),
        dividerColor: Theme.of(context).colorScheme.primaryVariant,
        elevation: 1,
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            backgroundColor: _isOpen
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.white,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.faq.question ?? '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      fontWeight: FontWeight.w400),
                ),
              );
            },
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                widget.faq.answer ?? '',
                style: TextStyle(color: Colors.black, height: 1.3),
              ),
            ),
            isExpanded: _isOpen,
          ),
        ],
        expansionCallback: (int item, bool status) {
          setState(() {
            _isOpen = !_isOpen;
          });
        },
      ),
    );
  }
}
