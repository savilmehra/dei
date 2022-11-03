class ProductList{
  String name;
  int totStock;
  int stock;
  String status;
  int price;

  ProductList({required this.name, required this.totStock,required this.stock, required this.status, required this.price});
}

List<ProductList> product_list =[
    ProductList(name: 'Mug', totStock: 200,stock: 150, status: 'High', price: 20),
    ProductList(name: 'Photo Book', totStock: 150, stock: 20, status: 'Low', price: 120),
    ProductList(name: 'Premium Album', totStock: 20,stock: 40, status: 'Low', price: 320)
];