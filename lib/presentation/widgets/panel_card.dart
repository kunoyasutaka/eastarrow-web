import 'package:flutter/material.dart';
import 'package:flutter_bootstrap_widgets/bootstrap_widgets.dart';

/// ダッシュボードのパネルカード
class PanelCard extends StatelessWidget {
  final BootstrapPanelType type;
  final IconData icon;
  final int number;
  final String description;
  final String detailMessage;
  final Function() onTap;

  const PanelCard({
    Key? key,
    this.type = BootstrapPanelType.defaults,
    required this.icon,
    required this.number,
    required this.description,
    this.detailMessage = '詳細',
    required this.onTap,
  }) : super(key: key);

  final Map<BootstrapPanelType, Color> _color = const {
    BootstrapPanelType.defaults: BootstrapColors.panelDefaultBackground,
    BootstrapPanelType.primary: BootstrapColors.panelPrimaryBackground,
    BootstrapPanelType.success: BootstrapColors.panelSuccessBackground,
    BootstrapPanelType.info: BootstrapColors.panelInfoBackground,
    BootstrapPanelType.warning: BootstrapColors.panelWarningBackground,
    BootstrapPanelType.danger: BootstrapColors.panelDangerBackground,
  };

  @override
  Widget build(BuildContext context) {
    return BootstrapPanel(
      type: type,
      header: Container(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 60,
            ),
            Spacer(),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SelectableText(
                    '$number',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  SelectableText(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      footer: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                detailMessage,
                style: TextStyle(
                  fontSize: 12,
                  color: _color[type],
                ),
              ),
            ),
            Spacer(),
            Icon(
              Icons.chevron_right,
              color: _color[type],
            )
          ],
        ),
      ),
    );
  }
}
