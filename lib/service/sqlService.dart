import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:truck/model/ItemModel.dart';

class SQLService {
  Database db;

  Future openDB() async {
    try {
      // Get a location using getDatabasesPath
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'shopping.db');
      //await deleteDatabase(path);
      //print(path);
      // opeprintn the database
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          //print(db);
          this.db = db;
          createTables();
        },
      );
      //await db.close();
      return true;
    } catch (e) {
      print("ERROR IN OPEN DATABASE $e");
      return Future.error(e);
    }
  }

  createTables() async {
    try {
      var qry = "CREATE TABLE IF NOT EXISTS shopping ( "
          "id INTEGER PRIMARY KEY,"
          "quntity INTEGER,"
          "brand_id INTEGER,"
          "category_id INTEGER,"
          "name TEXT,"
          "sku  TEXT,"
          "description TEXT,"
          "image Text,"
          "price REAL,"
          "sale_price REAL,"
          "fav INTEGER,"
          "rating REAL,"
          "weight REAL,"
          "datetime DATETIME)";
      await db?.execute(qry);
      qry = "CREATE TABLE IF NOT EXISTS cart_list ( "
          "id INTEGER PRIMARY KEY,"
          "shop_id INTEGER,"
          "quntity INTEGER,"
          "brand_id INTEGER,"
          "name TEXT,"
          "sku  TEXT,"
          "image Text,"
          "price REAL,"
          "fav INTEGER,"
          "rating REAL,"
          "datetime DATETIME)";

      await db?.execute(qry);
    } catch (e) {
      print("ERROR IN CREATE TABLE");
      print(e);
    }
  }

  Future saveRecord(ShopItemModel data) async {
    await this.db?.transaction((txn) async {
      var qry =
          'INSERT INTO shopping(name, price, image,rating,fav,quntity,brand_id,sku,sale_price,description,category_id) VALUES("${data.name}",${data.price}, "${data.image}",${data.rating},${data.fav ? 1 : 0},${data.quntity},${data.brandid},${data.sku},${data.saleprice},${data.description},${data.categoryid})';
      int id1 = await txn.rawInsert(qry);
      return id1;
    });
  }

  Future setItemAsFavourite(int id, bool flag) async {
    var query = "UPDATE shopping set fav = ? WHERE id = ?";
    return await this.db?.rawUpdate(query, [flag ? 1 : 0, id]);
  }

  Future getItemsRecord() async {
    try {
      var list = await db?.rawQuery('SELECT * FROM shopping', []);
      return list ?? [];
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getCartList() async {
    try {
      var list = await db?.rawQuery('SELECT * FROM cart_list', []);
      return list ?? [];
    } catch (e) {
      return Future.error(e);
    }
  }

  Future addToCart(ShopItemModel data) async {
    await this.db?.transaction((txn) async {
      var qry =
          'INSERT INTO cart_list(shop_id, name, price, image,rating,fav,quntity) VALUES(${data.id}, "${data.name}",${data.price}, "${data.image}",${data.rating},${data.fav ? 1 : 0},${data.quntity})';
      int id1 = await txn.rawInsert(qry);
      return id1;
    });
  }

  Future addToQuntity(int shopId, int value) async {
    var query = "UPDATE shopping set quntity = ? WHERE id = ?";
    return await this.db?.rawUpdate(query, [value, shopId]);
  }

  Future removeFromCart(int shopId) async {
    var qry = "DELETE FROM cart_list where shop_id = ${shopId}";
    return await this.db?.rawDelete(qry);
  }
}
