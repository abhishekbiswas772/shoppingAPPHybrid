import 'package:bloc_example/Shopping/Details/bloc/details_logic_bloc.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model_all.dart';
import 'package:bloc_example/Utils/Images/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  final int productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  HomeAllProductModel? model;

  Widget getColourWidget(Color mentionedColor) {
    return SizedBox(
        width: 25,
        height: 25,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
          child: Container(
            color: mentionedColor,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailsLogicBloc>(context)
        .add(HomeProductDetailsEvent(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.productId);
    return Scaffold(
      body: BlocBuilder<DetailsLogicBloc, DetailsLogicState>(
        builder: (context, state) {
          if (state is DetailsLogicInit) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailsLogicSuccess) {
            model = state.model;
            return SafeArea(
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child:
                                ImageServiceUtil.getImage(model?.images ?? "")),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          height: 70,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 65,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child:
                                          const Icon(Icons.arrow_back_sharp))),
                              Container(
                                  width: 65,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: TextButton(
                                      onPressed: () {},
                                      child: (!model!.isFav)
                                          ? const Icon(Icons.favorite_border)
                                          : const Icon(Icons.favorite)))
                            ],
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).size.height * 0.45) +
                              100,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 30, right: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(10),
                                          alignment: Alignment.center,
                                          // width: 70,
                                          height: 45,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              color: Color(0xFFF4F4F4)),
                                          child: Text(model?.category ?? "")),
                                      const Spacer(),
                                      const SizedBox()
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    model?.title.toString() ?? "",
                                    style: const TextStyle(fontSize: 25),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(model?.description.toString() ?? "",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13)),
                                  const SizedBox(height: 5),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "VARIANTS",
                                        style: TextStyle(fontSize: 22),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount:
                                                    model?.varients.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: InkWell(
                                                        onTap: () {},
                                                        child: getColourWidget(
                                                            model?.varients[
                                                                    index] ??
                                                                Colors.black)),
                                                  );
                                                })
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Transform.translate(
                                    offset: const Offset(-22, 0),
                                    child: SizedBox(
                                        child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {},
                                                child: const Icon(
                                                    Icons.add_rounded)),
                                            const Text("01"),
                                            TextButton(
                                                onPressed: () {},
                                                child:
                                                    const Icon(Icons.remove)),
                                          ],
                                        )
                                      ],
                                    )),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: SingleChildScrollView(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 65,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 80, 79, 79),
                                                      width: 1.2)),
                                              child: TextButton(
                                                  onPressed: () {},
                                                  child: (!model!.isFav)
                                                      ? const Icon(
                                                          Icons.favorite_border)
                                                      : const Icon(
                                                          Icons.favorite))),
                                          Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue[400],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: TextButton(
                                                  onPressed: () {},
                                                  child: const Text("Buy Now",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15)))),
                                          Container(
                                              width: 120,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue[400],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: TextButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                      "Add to Cart",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15))))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is DetailsLogicLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailsLogicFailure) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded, size: 40),
                SizedBox(
                  height: 3,
                ),
                Text("Some Error Happended,",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            );
          } else {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded, size: 40),
                SizedBox(
                  height: 3,
                ),
                Text("Some Error Happended,",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            );
          }
        },
      ),
    );
  }
}
