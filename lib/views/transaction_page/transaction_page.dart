import 'package:bankly/utils/sizedboxx.dart';
import 'package:bankly/utils/theme.dart';
import 'package:bankly/views/transaction_page/widgets/debit_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../general_widgets/custom_tab.dart';
import '../../general_widgets/custom_tab_item.dart';
import '../../general_widgets/input_form_field.dart';
import 'widgets/all_transactions.dart';
import 'widgets/credit_list.dart';

class TransactionPage extends StatefulHookConsumerWidget {
  const TransactionPage({super.key});

  @override
  TransactionPageState createState() => TransactionPageState();
}

final tabsProvider = StateProvider<List<CustomTabItem>>((ref) {
  return [
    CustomTabItem(
      text: 'All',
      color: BLACK,
    ),
    CustomTabItem(
      text: 'Credit',
      color: GREEN,
    ),
    CustomTabItem(
      text: 'Debit',
      color: RED,
    ),
  ];
});

class TransactionPageState extends ConsumerState<TransactionPage> {
  String? query;
  String filter = '';
  @override
  Widget build(BuildContext context) {
    final tabs = ref.watch(tabsProvider);
    final currentTab = useState(0);
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
              Container(
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
            Card(
              child: Center(
                child: InputFormField(
                  hintText: 'Find here ',
                  onChanged: (val) {
                    if (val != '' || val.isNotEmpty) {
                      setState(() {
                        query = val;
                      });
                    }
                  },
                  prefixIcon: const Icon(Icons.search, color: PRIMARY),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: InkResponse(
                      onTap: () => filterMenu(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: PRIMARY.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                color: PRIMARY,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.fontSize,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Icon(
                              Icons.filter_alt_outlined,
                              color: PRIMARY,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            20.ph,
            CustomTab(
              items: tabs,
              currentIndex: currentTab.value,
              onChanged: (value) {
                currentTab.value = value;
              },
            ),
            20.ph,
            Expanded(
              child: IndexedStack(
                index: currentTab.value,
                children: [
                  AllTransactionsCard(query: query ?? '', filter: filter),
                  CreditTransactionsCard(query: query ?? '', filter: filter),
                  DebitTransactionsCard(query: query ?? '', filter: filter),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filterMenu(BuildContext context) {
    return showMenu(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width * .80,
          MediaQuery.of(context).size.height * .22, 0, 0),
      items: [
        PopupMenuItem(
          onTap: filter == 'all Status' || filter == ''
              ? null
              : () {
                  setState(() {
                    filter = 'all Status';
                  });
                },
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
            fontWeight: FontWeight.w400,
            color: BLACK,
          ),
          child: Row(
            children: [
              Visibility(
                visible: filter == 'all Status' || filter == '',
                child: Text(
                  '✓',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.w600,
                    color: PRIMARY,
                  ),
                ),
              ),
              5.pw,
              const Text(
                "All Status",
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: filter == 'description'
              ? null
              : () {
                  setState(() {
                    filter = 'description';
                  });
                },
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
            fontWeight: FontWeight.w400,
            color: BLACK,
          ),
          child: Row(
            children: [
              Visibility(
                visible: filter == 'description',
                child: Text(
                  '✓',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.w600,
                    color: PRIMARY,
                  ),
                ),
              ),
              5.pw,
              const Text(
                "Description",
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: filter == 'type'
              ? null
              : () {
                  setState(() {
                    filter = 'type';
                  });
                },
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
            fontWeight: FontWeight.w400,
            color: BLACK,
          ),
          child: Row(
            children: [
              Visibility(
                visible: filter == 'type',
                child: Text(
                  '✓',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.w600,
                    color: PRIMARY,
                  ),
                ),
              ),
              5.pw,
              const Text(
                "Type",
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: filter == 'amount'
              ? null
              : () {
                  setState(() {
                    filter = 'amount';
                  });
                },
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
            fontWeight: FontWeight.w400,
            color: BLACK,
          ),
          child: Row(
            children: [
              Visibility(
                visible: filter == 'amount',
                child: Text(
                  '✓',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.w600,
                    color: PRIMARY,
                  ),
                ),
              ),
              5.pw,
              const Text(
                "Amount",
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: filter == 'account number'
              ? null
              : () {
                  setState(() {
                    filter = 'account number';
                  });
                },
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
            fontWeight: FontWeight.w400,
            color: BLACK,
          ),
          child: Row(
            children: [
              Visibility(
                visible: filter == 'account number',
                child: Text(
                  '✓',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.w600,
                    color: PRIMARY,
                  ),
                ),
              ),
              5.pw,
              const Text(
                "Account Number",
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: filter == 'account name'
              ? null
              : () {
                  setState(() {
                    filter = 'account name';
                  });
                },
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
            fontWeight: FontWeight.w400,
            color: BLACK,
          ),
          child: Row(
            children: [
              Visibility(
                visible: filter == 'account name',
                child: Text(
                  '✓',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.w600,
                    color: PRIMARY,
                  ),
                ),
              ),
              5.pw,
              const Text(
                "Account Name",
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: filter == 'bank name'
              ? null
              : () {
                  setState(() {
                    filter = 'bank name';
                  });
                },
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
            fontWeight: FontWeight.w400,
            color: BLACK,
          ),
          child: Row(
            children: [
              Visibility(
                visible: filter == 'bank name',
                child: Text(
                  '✓',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.w600,
                    color: PRIMARY,
                  ),
                ),
              ),
              5.pw,
              const Text(
                "Bank Name",
              ),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    );
  }
}
