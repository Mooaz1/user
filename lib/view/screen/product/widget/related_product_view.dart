import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class RelatedProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        return Column(children: [

          prodProvider.relatedProductList != null ? prodProvider.relatedProductList.length != 0 ? GridView.builder(
          
            itemCount: prodProvider.relatedProductList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:    2,),
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(productModel: prodProvider.relatedProductList[index]);
            },
          ): Center(child: Text('No related Product')) :
          ProductShimmer(isHomePage: false, isEnabled: Provider.of<ProductProvider>(context).relatedProductList == null),
        ]);
      },
    );
  }
}
