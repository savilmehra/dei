// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'features/products_showcase/model/products_response.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 8700672669693708824),
      name: 'Discount',
      lastPropertyId: const IdUid(2, 9142093302161982148),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5454915290087954739),
            name: 'sTypename',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(2, 9142093302161982148),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 621470583563039096),
      name: 'Image',
      lastPropertyId: const IdUid(5, 2459228063390793455),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5124253564074295376),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1194742527025036813),
            name: 'sTypename',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5791041552945973871),
            name: 'url',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6563325092646305185),
            name: 'label',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2459228063390793455),
            name: 'position',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 9100984073549709582),
      name: 'Items',
      lastPropertyId: const IdUid(9, 846871734994028095),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 666050920883501230),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 1730286865936938302),
            name: 'sku',
            type: 9,
            flags: 34848,
            indexId: const IdUid(1, 1314067807555634528)),
        ModelProperty(
            id: const IdUid(3, 3020726946559001356),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5110274749749757473),
            name: 'urlKey',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4260277939230404728),
            name: 'stockStatus',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 5383068364916087353),
            name: 'sTypename',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7332150198540159789),
            name: 'priceTiers',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 5595612805471893628),
            name: 'priceObject',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 846871734994028095),
            name: 'dbImage',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 4062653345238327760),
      name: 'MinimumPrice',
      lastPropertyId: const IdUid(2, 2437693636824481522),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1736611574450273604),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2437693636824481522),
            name: 'sTypename',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 8793128988968890565),
      name: 'PriceRange',
      lastPropertyId: const IdUid(2, 8847707437363155707),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4888504888271629382),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8847707437363155707),
            name: 'sTypename',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(6, 2282097715721944604),
      name: 'Products',
      lastPropertyId: const IdUid(3, 1999041378516943180),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4150855053026412081),
            name: 'sTypename',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(2, 6661207666609735390),
            name: 'totalCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1999041378516943180),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(7, 4029704322686904176),
      name: 'RegularPrice',
      lastPropertyId: const IdUid(4, 6326507352898613613),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8437949802585155854),
            name: 'sTypename',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(2, 467375325695504336),
            name: 'value',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2345527234957882964),
            name: 'currency',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6326507352898613613),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(7, 4029704322686904176),
      lastIndexId: const IdUid(1, 1314067807555634528),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Discount: EntityDefinition<Discount>(
        model: _entities[0],
        toOneRelations: (Discount object) => [],
        toManyRelations: (Discount object) => {},
        getId: (Discount object) => object.id,
        setId: (Discount object, int id) {
          object.id = id;
        },
        objectToFB: (Discount object, fb.Builder fbb) {
          final sTypenameOffset = object.sTypename == null
              ? null
              : fbb.writeString(object.sTypename!);
          fbb.startTable(3);
          fbb.addOffset(0, sTypenameOffset);
          fbb.addInt64(1, object.id ?? 0);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Discount(
              sTypename: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 4),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6));

          return object;
        }),
    Image: EntityDefinition<Image>(
        model: _entities[1],
        toOneRelations: (Image object) => [],
        toManyRelations: (Image object) => {},
        getId: (Image object) => object.id,
        setId: (Image object, int id) {
          object.id = id;
        },
        objectToFB: (Image object, fb.Builder fbb) {
          final sTypenameOffset = object.sTypename == null
              ? null
              : fbb.writeString(object.sTypename!);
          final urlOffset =
              object.url == null ? null : fbb.writeString(object.url!);
          final labelOffset =
              object.label == null ? null : fbb.writeString(object.label!);
          final positionOffset = object.position == null
              ? null
              : fbb.writeString(object.position!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, sTypenameOffset);
          fbb.addOffset(2, urlOffset);
          fbb.addOffset(3, labelOffset);
          fbb.addOffset(4, positionOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Image(
              sTypename: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              url: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              label: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              position: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4));

          return object;
        }),
    Items: EntityDefinition<Items>(
        model: _entities[2],
        toOneRelations: (Items object) => [],
        toManyRelations: (Items object) => {},
        getId: (Items object) => object.id,
        setId: (Items object, int id) {
          object.id = id;
        },
        objectToFB: (Items object, fb.Builder fbb) {
          final skuOffset =
              object.sku == null ? null : fbb.writeString(object.sku!);
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final urlKeyOffset =
              object.urlKey == null ? null : fbb.writeString(object.urlKey!);
          final stockStatusOffset = object.stockStatus == null
              ? null
              : fbb.writeString(object.stockStatus!);
          final sTypenameOffset = object.sTypename == null
              ? null
              : fbb.writeString(object.sTypename!);
          final priceTiersOffset = object.priceTiers == null
              ? null
              : fbb.writeList(object.priceTiers!
                  .map(fbb.writeString)
                  .toList(growable: false));
          final priceObjectOffset = object.priceObject == null
              ? null
              : fbb.writeString(object.priceObject!);
          final dbImageOffset =
              object.dbImage == null ? null : fbb.writeString(object.dbImage!);
          fbb.startTable(10);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, skuOffset);
          fbb.addOffset(2, nameOffset);
          fbb.addOffset(3, urlKeyOffset);
          fbb.addOffset(4, stockStatusOffset);
          fbb.addOffset(5, sTypenameOffset);
          fbb.addOffset(6, priceTiersOffset);
          fbb.addOffset(7, priceObjectOffset);
          fbb.addOffset(8, dbImageOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Items(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              sku: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              urlKey: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              stockStatus: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              sTypename: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              priceTiers: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 16))
            ..priceObject = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 18)
            ..dbImage = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 20);

          return object;
        }),
    MinimumPrice: EntityDefinition<MinimumPrice>(
        model: _entities[3],
        toOneRelations: (MinimumPrice object) => [],
        toManyRelations: (MinimumPrice object) => {},
        getId: (MinimumPrice object) => object.id,
        setId: (MinimumPrice object, int id) {
          object.id = id;
        },
        objectToFB: (MinimumPrice object, fb.Builder fbb) {
          final sTypenameOffset = object.sTypename == null
              ? null
              : fbb.writeString(object.sTypename!);
          fbb.startTable(3);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, sTypenameOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = MinimumPrice(
              sTypename: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4));

          return object;
        }),
    PriceRange: EntityDefinition<PriceRange>(
        model: _entities[4],
        toOneRelations: (PriceRange object) => [],
        toManyRelations: (PriceRange object) => {},
        getId: (PriceRange object) => object.id,
        setId: (PriceRange object, int id) {
          object.id = id;
        },
        objectToFB: (PriceRange object, fb.Builder fbb) {
          final sTypenameOffset = object.sTypename == null
              ? null
              : fbb.writeString(object.sTypename!);
          fbb.startTable(3);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, sTypenameOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PriceRange(
              sTypename: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4));

          return object;
        }),
    Products: EntityDefinition<Products>(
        model: _entities[5],
        toOneRelations: (Products object) => [],
        toManyRelations: (Products object) => {},
        getId: (Products object) => object.id,
        setId: (Products object, int id) {
          object.id = id;
        },
        objectToFB: (Products object, fb.Builder fbb) {
          final sTypenameOffset = object.sTypename == null
              ? null
              : fbb.writeString(object.sTypename!);
          fbb.startTable(4);
          fbb.addOffset(0, sTypenameOffset);
          fbb.addInt64(1, object.totalCount);
          fbb.addInt64(2, object.id ?? 0);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Products(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              sTypename: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 4),
              totalCount: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6));

          return object;
        }),
    RegularPrice: EntityDefinition<RegularPrice>(
        model: _entities[6],
        toOneRelations: (RegularPrice object) => [],
        toManyRelations: (RegularPrice object) => {},
        getId: (RegularPrice object) => object.id,
        setId: (RegularPrice object, int id) {
          object.id = id;
        },
        objectToFB: (RegularPrice object, fb.Builder fbb) {
          final sTypenameOffset = object.sTypename == null
              ? null
              : fbb.writeString(object.sTypename!);
          final currencyOffset = object.currency == null
              ? null
              : fbb.writeString(object.currency!);
          fbb.startTable(5);
          fbb.addOffset(0, sTypenameOffset);
          fbb.addInt64(1, object.value);
          fbb.addOffset(2, currencyOffset);
          fbb.addInt64(3, object.id ?? 0);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = RegularPrice(
              sTypename: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 4),
              value: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              currency: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 10));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Discount] entity fields to define ObjectBox queries.
class Discount_ {
  /// see [Discount.sTypename]
  static final sTypename =
      QueryStringProperty<Discount>(_entities[0].properties[0]);

  /// see [Discount.id]
  static final id = QueryIntegerProperty<Discount>(_entities[0].properties[1]);
}

/// [Image] entity fields to define ObjectBox queries.
class Image_ {
  /// see [Image.id]
  static final id = QueryIntegerProperty<Image>(_entities[1].properties[0]);

  /// see [Image.sTypename]
  static final sTypename =
      QueryStringProperty<Image>(_entities[1].properties[1]);

  /// see [Image.url]
  static final url = QueryStringProperty<Image>(_entities[1].properties[2]);

  /// see [Image.label]
  static final label = QueryStringProperty<Image>(_entities[1].properties[3]);

  /// see [Image.position]
  static final position =
      QueryStringProperty<Image>(_entities[1].properties[4]);
}

/// [Items] entity fields to define ObjectBox queries.
class Items_ {
  /// see [Items.id]
  static final id = QueryIntegerProperty<Items>(_entities[2].properties[0]);

  /// see [Items.sku]
  static final sku = QueryStringProperty<Items>(_entities[2].properties[1]);

  /// see [Items.name]
  static final name = QueryStringProperty<Items>(_entities[2].properties[2]);

  /// see [Items.urlKey]
  static final urlKey = QueryStringProperty<Items>(_entities[2].properties[3]);

  /// see [Items.stockStatus]
  static final stockStatus =
      QueryStringProperty<Items>(_entities[2].properties[4]);

  /// see [Items.sTypename]
  static final sTypename =
      QueryStringProperty<Items>(_entities[2].properties[5]);

  /// see [Items.priceTiers]
  static final priceTiers =
      QueryStringVectorProperty<Items>(_entities[2].properties[6]);

  /// see [Items.priceObject]
  static final priceObject =
      QueryStringProperty<Items>(_entities[2].properties[7]);

  /// see [Items.dbImage]
  static final dbImage = QueryStringProperty<Items>(_entities[2].properties[8]);
}

/// [MinimumPrice] entity fields to define ObjectBox queries.
class MinimumPrice_ {
  /// see [MinimumPrice.id]
  static final id =
      QueryIntegerProperty<MinimumPrice>(_entities[3].properties[0]);

  /// see [MinimumPrice.sTypename]
  static final sTypename =
      QueryStringProperty<MinimumPrice>(_entities[3].properties[1]);
}

/// [PriceRange] entity fields to define ObjectBox queries.
class PriceRange_ {
  /// see [PriceRange.id]
  static final id =
      QueryIntegerProperty<PriceRange>(_entities[4].properties[0]);

  /// see [PriceRange.sTypename]
  static final sTypename =
      QueryStringProperty<PriceRange>(_entities[4].properties[1]);
}

/// [Products] entity fields to define ObjectBox queries.
class Products_ {
  /// see [Products.sTypename]
  static final sTypename =
      QueryStringProperty<Products>(_entities[5].properties[0]);

  /// see [Products.totalCount]
  static final totalCount =
      QueryIntegerProperty<Products>(_entities[5].properties[1]);

  /// see [Products.id]
  static final id = QueryIntegerProperty<Products>(_entities[5].properties[2]);
}

/// [RegularPrice] entity fields to define ObjectBox queries.
class RegularPrice_ {
  /// see [RegularPrice.sTypename]
  static final sTypename =
      QueryStringProperty<RegularPrice>(_entities[6].properties[0]);

  /// see [RegularPrice.value]
  static final value =
      QueryIntegerProperty<RegularPrice>(_entities[6].properties[1]);

  /// see [RegularPrice.currency]
  static final currency =
      QueryStringProperty<RegularPrice>(_entities[6].properties[2]);

  /// see [RegularPrice.id]
  static final id =
      QueryIntegerProperty<RegularPrice>(_entities[6].properties[3]);
}
