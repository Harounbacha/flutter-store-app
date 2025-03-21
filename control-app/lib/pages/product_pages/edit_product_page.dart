import 'package:bs_flutter/bs_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:helpers/helpers.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:messini_store/models/category_model.dart';
import 'package:messini_store/models/product_model.dart';
import 'package:messini_store/utils/app_const.dart';
import 'package:messini_store/utils/app_helper.dart';
import 'package:messini_store/utils/app_themes.dart';
import 'package:messini_store/utils/app_widgets.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;
  const EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  bool isLoading = true;

  TextEditingController productTitleCont = TextEditingController();
  TextEditingController productPriceCont = TextEditingController();
  TextEditingController productUnitCont = TextEditingController();
  TextEditingController productUnitSizeCont = TextEditingController();
  TextEditingController productImageCont = TextEditingController();
  TextEditingController productDescriptionCont = TextEditingController();

  late String productTitleValue = widget.product.title;
  late String productPriceValue = "${widget.product.price}";
  late String productUnitValue = widget.product.unit;
  late String productUnitSizeValue = "${widget.product.unitSize}";
  late String productImageValue = widget.product.image;
  late String productDescriptionValue = widget.product.description;
  late int productCategoryId = widget.product.categoryId;

  late bool showToUser = widget.product.showToUser == 1;

  late List<CategoryModel> categories;

  getCategories() async {
    categories = [];
    await AppData().getAllCategories().then((value) {
      setState(() {
        categories = value;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getCategories();

    productTitleCont.text = widget.product.title;
    productPriceCont.text = "${widget.product.price}";
    productUnitCont.text = widget.product.unit;
    productUnitSizeCont.text = "${widget.product.unitSize}";
    productImageCont.text = widget.product.image;
    productDescriptionCont.text = widget.product.description;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Headline6(
          "editProduct".tr(),
          style: const TextStyle(
              color: AppThemes.lightGreyColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                width: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: const LinearProgressIndicator(
                    minHeight: 10,
                  ),
                ),
              ),
            )
          : ListView(
              controller: ScrollController(),
              padding: const Margin.all(16.0),
              shrinkWrap: true,
              children: [
                BsRow(alignment: Alignment.center, children: <BsCol>[
                  BsCol(
                    decoration: const BoxDecoration(),
                    padding: const Margin.all(20.0),
                    sizes: const ColScreen(
                      xs: Col.col_12,
                      sm: Col.col_6,
                      md: Col.col_6,
                      lg: Col.col_5,
                      xl: Col.col_4,
                      xxl: Col.col_3,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Headline5(
                          "design".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: EdgeRadius.all(10),
                              color: Colors.white),
                          padding: const Margin.all(10),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: EdgeRadius.all(10),
                                child: CachedNetworkImage(
                                  imageUrl: productImageValue,
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 85,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              BodyText1(
                                productTitleValue,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              BodyText2(
                                "$productPriceValue ${AppConst.appCurrency}",
                                maxLines: 1,
                                style: TextStyle(
                                    color: context.color.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              BodyText2(
                                "$productUnitSizeValue $productUnitValue",
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                label: Text("add".tr()),
                                icon: const Icon(Ionicons.bag_add_outline),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: EdgeRadius.all(10),
                              color: Colors.white),
                          padding: const Margin.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: EdgeRadius.all(10),
                                  child: CachedNetworkImage(
                                    imageUrl: productImageValue,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      color: Colors.grey,
                                    ),
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyText1(
                                      productTitleValue,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    BodyText2(
                                      "$productPriceValue ${AppConst.appCurrency}",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: context.color.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    BodyText2(
                                      "$productUnitSizeValue $productUnitValue",
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Ionicons.bag_add,
                                  color: context.color.primary,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BsCol(
                    decoration: const BoxDecoration(),
                    padding: const Margin.all(20.0),
                    sizes: const ColScreen(
                      xs: Col.col_12,
                      sm: Col.col_6,
                      md: Col.col_6,
                      lg: Col.col_4,
                      xl: Col.col_4,
                      xxl: Col.col_3,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Headline5(
                          "information".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormField(
                          builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "productCategory".tr(),
                                  filled: true),
                              isEmpty: false,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: productCategoryId,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      //productCategory = newValue as CategoryModel;

                                      productCategoryId = newValue as int;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items:
                                      categories.map((CategoryModel category) {
                                    return DropdownMenuItem(
                                      value: category.id,
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: EdgeRadius.all(10),
                                            child: CachedNetworkImage(
                                              imageUrl: category.image,
                                              fit: BoxFit.cover,
                                              width: 40,
                                              height: 40,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(category.title),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: productTitleCont,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "productTitle".tr(),
                            filled: true,
                          ),
                          onChanged: (v) {
                            setState(() {
                              productTitleValue = v;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          controller: productPriceCont,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "productPrice".tr(),
                            filled: true,
                          ),
                          onChanged: (v) {
                            setState(() {
                              productPriceValue = v;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: productImageCont,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "productImage".tr(),
                            filled: true,
                          ),
                          onChanged: (v) {
                            setState(() {
                              productImageValue = v;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: productDescriptionCont,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "productDescription".tr(),
                            filled: true,
                          ),
                          minLines: 5,
                          maxLines: 7,
                          onChanged: (v) {
                            setState(() {
                              productDescriptionValue = v;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: productUnitCont,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "productUnit".tr(),
                            filled: true,
                          ),
                          onChanged: (v) {
                            setState(() {
                              productUnitValue = v;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          controller: productUnitSizeCont,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "productUnitSize".tr(),
                            filled: true,
                          ),
                          onChanged: (v) {
                            setState(() {
                              productUnitSizeValue = v;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CheckboxListTile(
                          tileColor: const Color(0xffeaecf5),
                          title: Text("showToUsers".tr()),
                          value: showToUser,
                          onChanged: (bool? value) {
                            setState(() {
                              showToUser = !showToUser;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            AppWidgets().MyDialog(
                                context: context,
                                title: "loading".tr(),
                                background: Colors.blue,
                                asset: const CircularProgressIndicator(
                                    color: Colors.white));
                            await AppData()
                                .editProduct(
                                    product: ProductModel(
                                        id: widget.product.id,
                                        title: productTitleValue,
                                        image: productImageValue,
                                        description: productDescriptionValue,
                                        price: double.parse(productPriceValue),
                                        unit: productUnitValue,
                                        unitSize:
                                            double.parse(productUnitSizeValue),
                                        categoryId: productCategoryId,
                                        showToUser: showToUser ? 1 : 0))
                                .then((value) {
                              Get.back();
                              if (value['type'] == "success") {
                                AppWidgets().MyDialog(
                                    context: context,
                                    asset: const Icon(
                                      Ionicons.checkmark_circle,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    background: context.color.primary,
                                    title: "productUpdated".tr(),
                                    confirm: ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                          Get.back(result: true);
                                        },
                                        child: Text("back".tr())));
                              } else {
                                AppWidgets().MyDialog(
                                    context: context,
                                    asset: const Icon(
                                      Ionicons.close_circle,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    background: const Color(0xffDF2E2E),
                                    title: "productNotUpdated".tr(),
                                    confirm: ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("back".tr())));
                              }
                            });
                          },
                          child: Text("editProduct".tr()),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
      // ),
    );
  }
}
