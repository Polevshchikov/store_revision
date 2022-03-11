import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:store_revision/api/pdf_api.dart';
import 'package:store_revision/feature/domain/entities/revision_pdf.dart';

class PdfRevisionApi {
  static Future<File> generate(RevisionPDF revisionPDF) async {
    final font = await rootBundle.load("fonts/FiraSans.ttf");
    final ttf = pw.Font.ttf(font);
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(revisionPDF, ttf),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(revisionPDF, ttf),
        buildInvoice(revisionPDF, ttf),
        Divider(),
        buildTotal(revisionPDF, ttf),
      ],
    ));

    return PdfApi.saveDocument(
        name: 'revision-${revisionPDF.revisoinName}.pdf', pdf: pdf);
  }

  static Widget buildHeader(RevisionPDF revision, Font ttf) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildText(
                  title: 'Сотрудники ревизии: ',
                  value: '',
                  width: 160,
                  titleStyle: TextStyle(font: ttf)),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: revision.revisoinId,
                  textStyle: TextStyle(font: ttf),
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildText(
                  title: 'Дата ревизии: ',
                  value: DateFormat('dd.MM.yyyy').format(revision.createDate),
                  width: 160,
                  titleStyle: TextStyle(font: ttf)),
            ],
          ),
          pw.Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: revision.namesTrusted
                .map(
                  (e) => Text(e, style: TextStyle(font: ttf)),
                )
                .toList(),
          ),
        ],
      );

  static Widget buildTitle(RevisionPDF revision, Font ttf) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            revision.revisoinName.toUpperCase(),
            style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold, font: ttf),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(
            revision.revisoinDescr,
            style: TextStyle(font: ttf),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(RevisionPDF revision, Font ttf) {
    final headers = ['Наименнование', 'Дата', 'Количество', 'Цена', 'Сумма'];
    final data = revision.listProducts.map((item) {
      return [
        item.name,
        DateFormat.yMd().format(item.datePublished),
        '${item.quantity} ',
        '${item.cost} руб.',
        (item.total.toStringAsFixed(2)),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: const TableBorder(horizontalInside: BorderSide()),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: ttf),
      headerDecoration: const BoxDecoration(color: PdfColors.blue100),
      cellStyle: TextStyle(font: ttf),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(RevisionPDF revision, Font ttf) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                buildText(
                  title: 'Итог',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    font: ttf,
                  ),
                  value: revision.total.toStringAsFixed(2),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
