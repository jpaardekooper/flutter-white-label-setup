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
        animationDuration: Duration(milliseconds: 400),
        dividerColor: Theme.of(context).colorScheme.primaryVariant,
        elevation: 1,
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            backgroundColor: _isOpen
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.white,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    widget.faq.question ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryVariant,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              );
            },
            body: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.faq.answer ?? '',
                  style: TextStyle(color: Colors.black),
                ),
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
