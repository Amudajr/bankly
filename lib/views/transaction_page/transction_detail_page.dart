// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use

import 'dart:io';

import 'package:bankly/utils/capitalize.dart';
import 'package:bankly/utils/sizedboxx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/transactions_model.dart';
import '../../utils/app_widgets.dart';
import '../../utils/currency_format.dart';
import '../../utils/img_res.dart';
import '../../utils/theme.dart';

import 'dart:ui' as ui;

class TransactionDetailPage extends StatefulWidget {
  const TransactionDetailPage({super.key});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  final GlobalKey _repaintKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final TransactionsModel transactionModel =
        TransactionsModel.fromJson(Get.arguments ?? {});

    final String dateString = transactionModel.trnDate!;
    final DateTime date = DateTime.parse(dateString);
    final displayDate = DateFormat("dd/MM/yyyy").format(date);
    final newTimeFormat = DateFormat('hh:mm a').format(date);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          0,
          MediaQuery.of(context).size.height * .11,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              InkResponse(
                onTap: () => Get.back(),
                child: Container(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .1,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: BACK_BUTTON_COLOR,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: PRIMARY,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Transactions',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      fontWeight: FontWeight.w700,
                      color: BLACK,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          minimum: EdgeInsets.fromLTRB(
            20,
            0,
            20,
            MediaQuery.of(context).size.height * .04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: RepaintBoundary(
                    key: _repaintKey,
                    child: Container(
                      color: SCAFFOLD_COLOR,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SvgPicture.asset(bankly),
                          ),
                          30.ph,
                          Center(
                            child: Text(
                              'N${formatCurrency(transactionModel.trnAmount, '')}',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.fontSize,
                                fontWeight: FontWeight.w700,
                                color: BLACK,
                              ),
                            ),
                          ),
                          30.ph,
                          Text(
                            'Details:',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              fontWeight: FontWeight.w700,
                              color: BLACK,
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            height: 25,
                            color: GREY,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date and Time',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.fontSize,
                                  fontWeight: FontWeight.w400,
                                  color: GREY,
                                ),
                              ),
                              Text(
                                '$displayDate $newTimeFormat',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 25,
                            color: GREY,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reference',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.fontSize,
                                  fontWeight: FontWeight.w400,
                                  color: GREY,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    transactionModel.trnPaymentReference ?? '',
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.fontSize,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  5.pw,
                                  InkResponse(
                                      onTap: () {
                                        Clipboard.setData(
                                          ClipboardData(
                                              text: transactionModel
                                                  .trnPaymentReference!),
                                        ).then((_) {
                                          Dialogs.showSuccessSnackBar('Copied!',
                                              'Rereference Number Copied.');
                                        });
                                      },
                                      child: SvgPicture.asset(copy)),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 25,
                            color: GREY,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Type',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.fontSize,
                                  fontWeight: FontWeight.w400,
                                  color: GREY,
                                ),
                              ),
                              Text(
                                '${transactionModel.trnDrCr}'
                                    .capitalizeByWord(),
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 25,
                            color: GREY,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Balance',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.fontSize,
                                  fontWeight: FontWeight.w400,
                                  color: GREY,
                                ),
                              ),
                              Text(
                                '₦${formatCurrency(transactionModel.trnAmount, '')}',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 25,
                            color: GREY,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Narration',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.fontSize,
                                  fontWeight: FontWeight.w400,
                                  color: GREY,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                                child: Text(
                                  transactionModel.trnNarration ?? '',
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.fontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 25, color: GREY),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkResponse(
                onTap: () {
                  widgetToImageFile(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: PRIMARY,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'DOWNLOAD RECEIPT',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.labelLarge?.fontSize,
                        fontWeight: FontWeight.w500,
                        color: WHITE,
                      ),
                    ),
                  ),
                ),
              ),
              10.ph,
              Center(
                child: TextButton(
                  onPressed: () => _shareQRCode(context),
                  child: Text(
                    'Share With Bankly Assistant',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.labelLarge?.fontSize,
                      fontWeight: FontWeight.w500,
                      color: PRIMARY,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _shareQRCode(context) async {
    return Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary boundary = _repaintKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;

      // var image = await boundary.toImage();
      // ByteData? byteData =
      //     await image.toByteData(format: ui.ImageByteFormat.png);
      // Uint8List? pngBytes = byteData?.buffer.asUint8List();

      final ui.Image image = await boundary.toImage();

      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      String path = await _getDownloadPath();
      var savePath = path + '/${_convertCurrentDateTimeToString()}' + ".png";
      debugPrint('savePath::: $savePath');
      File imgFile = File(savePath);
      imgFile.writeAsBytes(pngBytes).then((value) async {
        debugPrint('imageData:: $value');
        await Share.shareFiles([savePath]);
      }).catchError((onError) {
        debugPrint('imageError:::$onError');
      });
    });
  }

  String _convertCurrentDateTimeToString() {
    String formattedDateTime =
        DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<String> _getDownloadPath() async {
    Directory directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
        return directory.path;
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = (await getExternalStorageDirectory())!;
        }
        return directory.path;
      }
    } catch (err) {
      debugPrint("Cannot get download folder path: $err");
      throw Exception();
    }
  }

  Future<void> widgetToImageFile(BuildContext context) async {
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/image.png').create();
    await imagePath.writeAsBytes(pngBytes);
    Dialogs.showNoticeSnackBar('Hurray!', "Receipt downloaded");
  }
}
