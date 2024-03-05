import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShoppingHome extends StatefulWidget {
  const ShoppingHome({super.key});

  @override
  State<ShoppingHome> createState() => _ShoppingHomeState();
}

class _ShoppingHomeState extends State<ShoppingHome> {
  final TextEditingController _searchController = TextEditingController();

  Widget createShoppingAppSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
          ),
          SearchBar(
            hintText: "What are you looking for ?",
            shadowColor: MaterialStateProperty.all<Color>(Colors.white),
            overlayColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            controller: _searchController,
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 15)),
            leading: const Icon(Icons.search),
            trailing: const [Icon(Icons.mic)],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEA3A60),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 0),
                        color: const Color(0xFFEA3A60),
                        height: MediaQuery.of(context).size.height * 0.17,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset("assets/auth1.png",
                                          height: 40, width: 40)),
                                ),
                                const SizedBox(width: 8),
                                const Text("Hi, Abhishek",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700)),
                                const Spacer(),
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            ),
                            const SizedBox(height: 25),
                            const Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Text("HK415, MMM Hall IIT KGP",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400))
                              ],
                            )
                          ],
                        )),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 40, left: 20),
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                    "assets/auth1.png",
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF4F4F4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: TextButton(
                                        child: const Text("Sample"),
                                        onPressed: () {},
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  200 -
                                  70 -
                                  100,
                              child: MasonryGridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child:
                                              Image.asset("assets/auth2.png"),
                                        ),
                                        const Text("200",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w700)),
                                        Text("Chair",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[600]))
                                      ],
                                    );
                                  }))
                        ],
                      ),
                    )
                  ],
                ),
                createShoppingAppSearchBar()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
