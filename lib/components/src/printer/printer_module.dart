import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

class PrinterDevice {
  final String ip;
  final int port;

  PrinterDevice({this.ip, this.port = 9100});
}

class PrinterModule {
  static void findAllDevice() async {}

  static void connectDevice({PrinterDevice device}) async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    final PosPrintResult res =
        await printer.connect('192.168.1.240', port: 9100);
    print('Print result: ${res.msg}');

    if (res == PosPrintResult.success) {
      testReceipt(printer);
      printer.disconnect();
    }
  }

  static void testReceipt(NetworkPrinter printer) {
    printer.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: PosStyles(codeTable: 'CP1252'));
    printer.text('Special 2: blåbærgrød',
        styles: PosStyles(codeTable: 'CP1252'));

    printer.text('Bold text', styles: PosStyles(bold: true));
    printer.text('Reverse text', styles: PosStyles(reverse: true));
    printer.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    printer.text('Align left', styles: PosStyles(align: PosAlign.left));
    printer.text('Align center', styles: PosStyles(align: PosAlign.center));
    printer.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);


    printer.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    printer.row([
      PosColumn(
          text: 'Mat hang',
          styles: PosStyles(
            align: PosAlign.center,
            bold: true,
          ),
          width: 6
      ), PosColumn(
          text: 'Gia',
          styles: PosStyles(
            align: PosAlign.center,
            bold: true,
          ),
          width: 6
      )
    ]);

    printer.feed(2);
    printer.cut();
  }
}
