import 'package:bankly/models/transactions_model.dart';
import 'package:bankly/utils/img_res.dart';
import 'package:bankly/utils/sizedboxx.dart';
import 'package:bankly/viewmodels/transactions_vm/transactions_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/currency_format.dart';
import '../../../utils/theme.dart';
import '../transction_detail_page.dart';

class CreditTransactionsCard extends StatelessWidget {
  const CreditTransactionsCard({
    super.key,
    required this.query,
    required this.filter,
  });

  final String query;
  final String filter;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionsModel>>(
        future: TransactionsViewModel.getCredit(query, filter),
        builder: (context, snapshot) {
          final state = snapshot.connectionState.name;
          if (state == 'waiting') {
            return buildShimmer();
          } else if (state == 'done') {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final transaction = snapshot.data![index];
                  final String dateString = transaction.trnDate!;
                  final DateTime date = DateTime.parse(dateString);
                  final displayDate = DateFormat("dd/MM/yyyy").format(date);
                  final newTimeFormat = DateFormat('hh:mm a').format(date);
                  return InkResponse(
                    onTap: () => Get.to(
                      const TransactionDetailPage(),
                      arguments: transaction.toJson(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(credit),
                        20.pw,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction.source ?? '',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.fontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            5.ph,
                            Text(
                              '$displayDate $newTimeFormat',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.fontSize,
                                fontWeight: FontWeight.w400,
                                color: GREY,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '+₦${formatCurrency(transaction.trnAmount, '')}',
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodyLarge?.fontSize,
                            fontWeight: FontWeight.w500,
                            color: GREEN,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 30,
                  color: GREY.withOpacity(0.2),
                  thickness: 1,
                ),
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.data!.isEmpty || snapshot.data == null) {
              return Center(
                child: Text(
                  'No Transaction Found',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Error Fetching Transactions',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: Text(
                'Error Fetching Transactions',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        });
  }

  buildShimmer() {
    return Shimmer.fromColors(
      baseColor: PRIMARY.withOpacity(0.3),
      highlightColor: GREY.withOpacity(0.9),
      enabled: true,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 70,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: GREY.withOpacity(0.5),
            ),
          );
        },
      ),
    );
  }
}
