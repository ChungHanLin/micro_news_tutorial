import 'package:flutter/cupertino.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text('新聞分類',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
          child: Text('檢視所有新聞分類',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.systemGrey)),
        ),
        GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 16 / 9,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemGrey4,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemGrey4,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemGrey4,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemGrey4,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ]),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text('新聞來源',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
          child: Text('檢視所有新聞來源',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.systemGrey)),
        ),
        SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: CupertinoColors.systemGrey4,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text('新聞來源',
                            style: TextStyle(
                                fontSize: 16, color: CupertinoColors.black)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: CupertinoColors.systemGrey4,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text('新聞來源',
                            style: TextStyle(
                                fontSize: 16, color: CupertinoColors.black)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: CupertinoColors.systemGrey4,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text('新聞來源',
                            style: TextStyle(
                                fontSize: 16, color: CupertinoColors.black)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: CupertinoColors.systemGrey4,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text('新聞來源',
                            style: TextStyle(
                                fontSize: 16, color: CupertinoColors.black)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: CupertinoColors.systemGrey4,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text('新聞來源',
                            style: TextStyle(
                                fontSize: 16, color: CupertinoColors.black)),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
