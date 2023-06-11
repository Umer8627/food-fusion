import 'package:easy_pick/constants/color_constant.dart';
import 'package:easy_pick/models/offer_model.dart';
import 'package:easy_pick/states/user_state.dart';
import 'package:easy_pick/view/widgets/custom_textfield.dart';
import 'package:easy_pick/view/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../models/request_model.dart';
import '../../../../repos/offer_repo.dart';
import '../../../../utills/snippets.dart';

class CreateProductPricePopup extends StatefulWidget {
  const CreateProductPricePopup({
    super.key,
    this.requestModel,
  });

  final RequestModel? requestModel;

  @override
  State<CreateProductPricePopup> createState() =>
      _CreateProductPricePopupState();
}

class _CreateProductPricePopupState extends State<CreateProductPricePopup> {
  final actualPriceController = TextEditingController();
  final productPriceController = TextEditingController();

  String? selectProductAvailability;

  List<String> productAvailableList = ['Available', 'Not Available'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 6,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: textFieldColor,
                              ),
                              child: DropdownButtonFormField(
                                elevation: 4,
                                autofocus: false,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 13, bottom: 0),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.typo3,
                                    color: greyColor,
                                    size: 15,
                                  ),
                                ),
                                hint: Text(
                                  'Select',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                                style: Theme.of(context).textTheme.titleSmall,
                                dropdownColor: textFieldColor,
                                iconEnabledColor: primaryColor,
                                isExpanded: true,
                                value: selectProductAvailability,
                                items: productAvailableList.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(value),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectProductAvailability =
                                        value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: selectProductAvailability == 'Available',
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                labelText: 'Product price',
                                hintText: 'Product price',
                                controller: productPriceController,
                                maxLine: null,
                                inputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 300,
                        child: LoaderButton(
                          btnText: 'Send Product Price',
                          onTap: () async {
                            try {
                              if (selectProductAvailability!.isNotEmpty &&
                                  productPriceController.text.isEmpty) {
                                pop(context);
                                snack(context, 'Please enter product price',
                                    info: false);

                                return;
                              }
                              OfferModel offerModel = OfferModel(
                                  orderId: widget.requestModel!.orderId,
                                  docId: '',
                                  createdAt:
                                      DateTime.now().microsecondsSinceEpoch,
                                  riderId:
                                      context.read<UserState>().userModel.uid,
                                  price: productPriceController.text,
                                  reqId: widget.requestModel!.docId,
                                  isAccepted: false,
                                  isRejected: false);
                              await OfferRepo.instance.createOffer(
                                  widget.requestModel!, offerModel);
                              if (!mounted) return;
                              pop(context);
                              snack(context, 'Offer send successfully');
                            } catch (e) {
                              snack(context, e.toString());
                              return;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class _CreateProductPricePopupState extends State<CreateProductPricePopup> {
//   final actualPriceController = TextEditingController();
//   final priceController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String? selectProductAvailability;

//     List<String> productAvailableList = ['Available', 'Not Available'];
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Card(
//                 elevation: 6,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               height: 50,
//                               padding: const EdgeInsets.only(right: 10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: textFieldColor,
//                               ),
//                               child: DropdownButtonFormField(
//                                 elevation: 4,
//                                 autofocus: false,
//                                 decoration: const InputDecoration(
//                                   contentPadding:
//                                       EdgeInsets.only(top: 13, bottom: 0),
//                                   border: InputBorder.none,
//                                   prefixIcon: Icon(
//                                     FontAwesomeIcons.typo3,
//                                     color: greyColor,
//                                     size: 15,
//                                   ),
//                                 ),
//                                 hint: Text(
//                                   'Select Category',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleSmall
//                                       ?.copyWith(color: Colors.grey),
//                                 ),
//                                 style: Theme.of(context).textTheme.titleSmall,
//                                 dropdownColor: textFieldColor,
//                                 iconEnabledColor: primaryColor,
//                                 isExpanded: true,
//                                 value: selectProductAvailability,
//                                 items: productAvailableList.map((value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 10),
//                                       child: Text(value),
//                                     ),
//                                     onTap: () {},
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectProductAvailability =
//                                         value.toString();
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),

//                       Visibility(
//                         visible: selectProductAvailability == 'Available',
//                         child: )
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomTextField(
//                               labelText: 'Product price',
//                               hintText: 'Product price',
//                               controller: priceController,
//                               maxLine: null,
//                               inputType: TextInputType.number,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: 300,
//                         child: LoaderButton(
//                           btnText: 'Send Product Price',
//                           onTap: () async {
//                             // try {
//                             //   if (priceController.text.isEmpty) {
//                             //     pop(context);
//                             //     snack(context, 'Please enter product price',
//                             //         info: false);

//                             //     return;
//                             //   }
//                             //   OfferModel offerModel = OfferModel(
//                             //       orderId: widget.requestModel.orderId,
//                             //       docId: '',
//                             //       createdAt:
//                             //           DateTime.now().microsecondsSinceEpoch,
//                             //       riderId:
//                             //           context.read<UserState>().userModel.uid,
//                             //       price: priceController.text,
//                             //       reqId: widget.requestModel.docId,
//                             //       isAccepted: false,
//                             //       isRejected: false);
//                             //   await OfferRepo.instance
//                             //       .createOffer(widget.requestModel, offerModel);
//                             //   if (!mounted) return;
//                             //   pop(context);
//                             //   snack(context, 'Offer send successfully');
//                             // } catch (e) {
//                             //   snack(context, e.toString());
//                             //   return;
//                             // }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
