// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $CompaniesTable extends Companies
    with TableInfo<$CompaniesTable, Company> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompaniesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteUuidMeta =
      const VerificationMeta('remoteUuid');
  @override
  late final GeneratedColumn<String> remoteUuid = GeneratedColumn<String>(
      'remote_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _canCreateArticlesMeta =
      const VerificationMeta('canCreateArticles');
  @override
  late final GeneratedColumn<bool> canCreateArticles =
      GeneratedColumn<bool>('can_create_articles', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("can_create_articles" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, remoteUuid, name, canCreateArticles, phone, email];
  @override
  String get aliasedName => _alias ?? 'companies';
  @override
  String get actualTableName => 'companies';
  @override
  VerificationContext validateIntegrity(Insertable<Company> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_uuid')) {
      context.handle(
          _remoteUuidMeta,
          remoteUuid.isAcceptableOrUnknown(
              data['remote_uuid']!, _remoteUuidMeta));
    } else if (isInserting) {
      context.missing(_remoteUuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('can_create_articles')) {
      context.handle(
          _canCreateArticlesMeta,
          canCreateArticles.isAcceptableOrUnknown(
              data['can_create_articles']!, _canCreateArticlesMeta));
    } else if (isInserting) {
      context.missing(_canCreateArticlesMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Company map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Company(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      canCreateArticles: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_create_articles'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
    );
  }

  @override
  $CompaniesTable createAlias(String alias) {
    return $CompaniesTable(attachedDatabase, alias);
  }
}

class Company extends DataClass implements Insertable<Company> {
  final int id;
  final String remoteUuid;
  final String name;
  final bool canCreateArticles;
  final String? phone;
  final String? email;
  const Company(
      {required this.id,
      required this.remoteUuid,
      required this.name,
      required this.canCreateArticles,
      this.phone,
      this.email});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_uuid'] = Variable<String>(remoteUuid);
    map['name'] = Variable<String>(name);
    map['can_create_articles'] = Variable<bool>(canCreateArticles);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    return map;
  }

  CompaniesCompanion toCompanion(bool nullToAbsent) {
    return CompaniesCompanion(
      id: Value(id),
      remoteUuid: Value(remoteUuid),
      name: Value(name),
      canCreateArticles: Value(canCreateArticles),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  factory Company.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Company(
      id: serializer.fromJson<int>(json['id']),
      remoteUuid: serializer.fromJson<String>(json['remoteUuid']),
      name: serializer.fromJson<String>(json['name']),
      canCreateArticles: serializer.fromJson<bool>(json['canCreateArticles']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteUuid': serializer.toJson<String>(remoteUuid),
      'name': serializer.toJson<String>(name),
      'canCreateArticles': serializer.toJson<bool>(canCreateArticles),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
    };
  }

  Company copyWith(
          {int? id,
          String? remoteUuid,
          String? name,
          bool? canCreateArticles,
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent()}) =>
      Company(
        id: id ?? this.id,
        remoteUuid: remoteUuid ?? this.remoteUuid,
        name: name ?? this.name,
        canCreateArticles: canCreateArticles ?? this.canCreateArticles,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
      );
  @override
  String toString() {
    return (StringBuffer('Company(')
          ..write('id: $id, ')
          ..write('remoteUuid: $remoteUuid, ')
          ..write('name: $name, ')
          ..write('canCreateArticles: $canCreateArticles, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, remoteUuid, name, canCreateArticles, phone, email);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          other.id == this.id &&
          other.remoteUuid == this.remoteUuid &&
          other.name == this.name &&
          other.canCreateArticles == this.canCreateArticles &&
          other.phone == this.phone &&
          other.email == this.email);
}

class CompaniesCompanion extends UpdateCompanion<Company> {
  final Value<int> id;
  final Value<String> remoteUuid;
  final Value<String> name;
  final Value<bool> canCreateArticles;
  final Value<String?> phone;
  final Value<String?> email;
  const CompaniesCompanion({
    this.id = const Value.absent(),
    this.remoteUuid = const Value.absent(),
    this.name = const Value.absent(),
    this.canCreateArticles = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  });
  CompaniesCompanion.insert({
    this.id = const Value.absent(),
    required String remoteUuid,
    required String name,
    required bool canCreateArticles,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
  })  : remoteUuid = Value(remoteUuid),
        name = Value(name),
        canCreateArticles = Value(canCreateArticles);
  static Insertable<Company> custom({
    Expression<int>? id,
    Expression<String>? remoteUuid,
    Expression<String>? name,
    Expression<bool>? canCreateArticles,
    Expression<String>? phone,
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteUuid != null) 'remote_uuid': remoteUuid,
      if (name != null) 'name': name,
      if (canCreateArticles != null) 'can_create_articles': canCreateArticles,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
    });
  }

  CompaniesCompanion copyWith(
      {Value<int>? id,
      Value<String>? remoteUuid,
      Value<String>? name,
      Value<bool>? canCreateArticles,
      Value<String?>? phone,
      Value<String?>? email}) {
    return CompaniesCompanion(
      id: id ?? this.id,
      remoteUuid: remoteUuid ?? this.remoteUuid,
      name: name ?? this.name,
      canCreateArticles: canCreateArticles ?? this.canCreateArticles,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteUuid.present) {
      map['remote_uuid'] = Variable<String>(remoteUuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (canCreateArticles.present) {
      map['can_create_articles'] = Variable<bool>(canCreateArticles.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompaniesCompanion(')
          ..write('id: $id, ')
          ..write('remoteUuid: $remoteUuid, ')
          ..write('name: $name, ')
          ..write('canCreateArticles: $canCreateArticles, ')
          ..write('phone: $phone, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $ArticleTypesTable extends ArticleTypes
    with TableInfo<$ArticleTypesTable, ArticleType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticleTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (remote_uuid) ON DELETE CASCADE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _visibleForCreatingMeta =
      const VerificationMeta('visibleForCreating');
  @override
  late final GeneratedColumn<bool> visibleForCreating =
      GeneratedColumn<bool>('visible_for_creating', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("visible_for_creating" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns =>
      [id, remoteId, companyUuid, name, visibleForCreating];
  @override
  String get aliasedName => _alias ?? 'article_types';
  @override
  String get actualTableName => 'article_types';
  @override
  VerificationContext validateIntegrity(Insertable<ArticleType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('visible_for_creating')) {
      context.handle(
          _visibleForCreatingMeta,
          visibleForCreating.isAcceptableOrUnknown(
              data['visible_for_creating']!, _visibleForCreatingMeta));
    } else if (isInserting) {
      context.missing(_visibleForCreatingMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArticleType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticleType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id'])!,
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      visibleForCreating: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}visible_for_creating'])!,
    );
  }

  @override
  $ArticleTypesTable createAlias(String alias) {
    return $ArticleTypesTable(attachedDatabase, alias);
  }
}

class ArticleType extends DataClass implements Insertable<ArticleType> {
  final int id;
  final int remoteId;
  final String companyUuid;
  final String name;
  final bool visibleForCreating;
  const ArticleType(
      {required this.id,
      required this.remoteId,
      required this.companyUuid,
      required this.name,
      required this.visibleForCreating});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<int>(remoteId);
    map['company_uuid'] = Variable<String>(companyUuid);
    map['name'] = Variable<String>(name);
    map['visible_for_creating'] = Variable<bool>(visibleForCreating);
    return map;
  }

  ArticleTypesCompanion toCompanion(bool nullToAbsent) {
    return ArticleTypesCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      companyUuid: Value(companyUuid),
      name: Value(name),
      visibleForCreating: Value(visibleForCreating),
    );
  }

  factory ArticleType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticleType(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int>(json['remoteId']),
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      name: serializer.fromJson<String>(json['name']),
      visibleForCreating: serializer.fromJson<bool>(json['visibleForCreating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int>(remoteId),
      'companyUuid': serializer.toJson<String>(companyUuid),
      'name': serializer.toJson<String>(name),
      'visibleForCreating': serializer.toJson<bool>(visibleForCreating),
    };
  }

  ArticleType copyWith(
          {int? id,
          int? remoteId,
          String? companyUuid,
          String? name,
          bool? visibleForCreating}) =>
      ArticleType(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        companyUuid: companyUuid ?? this.companyUuid,
        name: name ?? this.name,
        visibleForCreating: visibleForCreating ?? this.visibleForCreating,
      );
  @override
  String toString() {
    return (StringBuffer('ArticleType(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('name: $name, ')
          ..write('visibleForCreating: $visibleForCreating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, remoteId, companyUuid, name, visibleForCreating);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticleType &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.companyUuid == this.companyUuid &&
          other.name == this.name &&
          other.visibleForCreating == this.visibleForCreating);
}

class ArticleTypesCompanion extends UpdateCompanion<ArticleType> {
  final Value<int> id;
  final Value<int> remoteId;
  final Value<String> companyUuid;
  final Value<String> name;
  final Value<bool> visibleForCreating;
  const ArticleTypesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.companyUuid = const Value.absent(),
    this.name = const Value.absent(),
    this.visibleForCreating = const Value.absent(),
  });
  ArticleTypesCompanion.insert({
    this.id = const Value.absent(),
    required int remoteId,
    required String companyUuid,
    required String name,
    required bool visibleForCreating,
  })  : remoteId = Value(remoteId),
        companyUuid = Value(companyUuid),
        name = Value(name),
        visibleForCreating = Value(visibleForCreating);
  static Insertable<ArticleType> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? companyUuid,
    Expression<String>? name,
    Expression<bool>? visibleForCreating,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (name != null) 'name': name,
      if (visibleForCreating != null)
        'visible_for_creating': visibleForCreating,
    });
  }

  ArticleTypesCompanion copyWith(
      {Value<int>? id,
      Value<int>? remoteId,
      Value<String>? companyUuid,
      Value<String>? name,
      Value<bool>? visibleForCreating}) {
    return ArticleTypesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      companyUuid: companyUuid ?? this.companyUuid,
      name: name ?? this.name,
      visibleForCreating: visibleForCreating ?? this.visibleForCreating,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (visibleForCreating.present) {
      map['visible_for_creating'] = Variable<bool>(visibleForCreating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticleTypesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('name: $name, ')
          ..write('visibleForCreating: $visibleForCreating')
          ..write(')'))
        .toString();
  }
}

class $ArticleTypePropertiesTable extends ArticleTypeProperties
    with TableInfo<$ArticleTypePropertiesTable, ArticleTypeProperty> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticleTypePropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (remote_uuid) ON DELETE CASCADE'));
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
      'type_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES article_types (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _requiredMeta =
      const VerificationMeta('required');
  @override
  late final GeneratedColumn<bool> required =
      GeneratedColumn<bool>('required', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("required" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, remoteId, companyUuid, typeId, title, slug, type, required, weight];
  @override
  String get aliasedName => _alias ?? 'article_type_properties';
  @override
  String get actualTableName => 'article_type_properties';
  @override
  VerificationContext validateIntegrity(
      Insertable<ArticleTypeProperty> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(_typeIdMeta,
          typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta));
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('required')) {
      context.handle(_requiredMeta,
          required.isAcceptableOrUnknown(data['required']!, _requiredMeta));
    } else if (isInserting) {
      context.missing(_requiredMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArticleTypeProperty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticleTypeProperty(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id'])!,
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      typeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      required: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}required'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
    );
  }

  @override
  $ArticleTypePropertiesTable createAlias(String alias) {
    return $ArticleTypePropertiesTable(attachedDatabase, alias);
  }
}

class ArticleTypeProperty extends DataClass
    implements Insertable<ArticleTypeProperty> {
  final int id;
  final int remoteId;
  final String companyUuid;
  final int typeId;
  final String title;
  final String slug;
  final String type;
  final bool required;
  final int weight;
  const ArticleTypeProperty(
      {required this.id,
      required this.remoteId,
      required this.companyUuid,
      required this.typeId,
      required this.title,
      required this.slug,
      required this.type,
      required this.required,
      required this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<int>(remoteId);
    map['company_uuid'] = Variable<String>(companyUuid);
    map['type_id'] = Variable<int>(typeId);
    map['title'] = Variable<String>(title);
    map['slug'] = Variable<String>(slug);
    map['type'] = Variable<String>(type);
    map['required'] = Variable<bool>(required);
    map['weight'] = Variable<int>(weight);
    return map;
  }

  ArticleTypePropertiesCompanion toCompanion(bool nullToAbsent) {
    return ArticleTypePropertiesCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      companyUuid: Value(companyUuid),
      typeId: Value(typeId),
      title: Value(title),
      slug: Value(slug),
      type: Value(type),
      required: Value(required),
      weight: Value(weight),
    );
  }

  factory ArticleTypeProperty.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticleTypeProperty(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int>(json['remoteId']),
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      typeId: serializer.fromJson<int>(json['typeId']),
      title: serializer.fromJson<String>(json['title']),
      slug: serializer.fromJson<String>(json['slug']),
      type: serializer.fromJson<String>(json['type']),
      required: serializer.fromJson<bool>(json['required']),
      weight: serializer.fromJson<int>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int>(remoteId),
      'companyUuid': serializer.toJson<String>(companyUuid),
      'typeId': serializer.toJson<int>(typeId),
      'title': serializer.toJson<String>(title),
      'slug': serializer.toJson<String>(slug),
      'type': serializer.toJson<String>(type),
      'required': serializer.toJson<bool>(required),
      'weight': serializer.toJson<int>(weight),
    };
  }

  ArticleTypeProperty copyWith(
          {int? id,
          int? remoteId,
          String? companyUuid,
          int? typeId,
          String? title,
          String? slug,
          String? type,
          bool? required,
          int? weight}) =>
      ArticleTypeProperty(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        companyUuid: companyUuid ?? this.companyUuid,
        typeId: typeId ?? this.typeId,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        type: type ?? this.type,
        required: required ?? this.required,
        weight: weight ?? this.weight,
      );
  @override
  String toString() {
    return (StringBuffer('ArticleTypeProperty(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('typeId: $typeId, ')
          ..write('title: $title, ')
          ..write('slug: $slug, ')
          ..write('type: $type, ')
          ..write('required: $required, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, remoteId, companyUuid, typeId, title, slug, type, required, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticleTypeProperty &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.companyUuid == this.companyUuid &&
          other.typeId == this.typeId &&
          other.title == this.title &&
          other.slug == this.slug &&
          other.type == this.type &&
          other.required == this.required &&
          other.weight == this.weight);
}

class ArticleTypePropertiesCompanion
    extends UpdateCompanion<ArticleTypeProperty> {
  final Value<int> id;
  final Value<int> remoteId;
  final Value<String> companyUuid;
  final Value<int> typeId;
  final Value<String> title;
  final Value<String> slug;
  final Value<String> type;
  final Value<bool> required;
  final Value<int> weight;
  const ArticleTypePropertiesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.companyUuid = const Value.absent(),
    this.typeId = const Value.absent(),
    this.title = const Value.absent(),
    this.slug = const Value.absent(),
    this.type = const Value.absent(),
    this.required = const Value.absent(),
    this.weight = const Value.absent(),
  });
  ArticleTypePropertiesCompanion.insert({
    this.id = const Value.absent(),
    required int remoteId,
    required String companyUuid,
    required int typeId,
    required String title,
    required String slug,
    required String type,
    required bool required,
    required int weight,
  })  : remoteId = Value(remoteId),
        companyUuid = Value(companyUuid),
        typeId = Value(typeId),
        title = Value(title),
        slug = Value(slug),
        type = Value(type),
        required = Value(required),
        weight = Value(weight);
  static Insertable<ArticleTypeProperty> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? companyUuid,
    Expression<int>? typeId,
    Expression<String>? title,
    Expression<String>? slug,
    Expression<String>? type,
    Expression<bool>? required,
    Expression<int>? weight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (typeId != null) 'type_id': typeId,
      if (title != null) 'title': title,
      if (slug != null) 'slug': slug,
      if (type != null) 'type': type,
      if (required != null) 'required': required,
      if (weight != null) 'weight': weight,
    });
  }

  ArticleTypePropertiesCompanion copyWith(
      {Value<int>? id,
      Value<int>? remoteId,
      Value<String>? companyUuid,
      Value<int>? typeId,
      Value<String>? title,
      Value<String>? slug,
      Value<String>? type,
      Value<bool>? required,
      Value<int>? weight}) {
    return ArticleTypePropertiesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      companyUuid: companyUuid ?? this.companyUuid,
      typeId: typeId ?? this.typeId,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      type: type ?? this.type,
      required: required ?? this.required,
      weight: weight ?? this.weight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (required.present) {
      map['required'] = Variable<bool>(required.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticleTypePropertiesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('typeId: $typeId, ')
          ..write('title: $title, ')
          ..write('slug: $slug, ')
          ..write('type: $type, ')
          ..write('required: $required, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

class $ArticlesTable extends Articles with TableInfo<$ArticlesTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (remote_uuid) ON DELETE CASCADE'));
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
      'type_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES article_types (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subtitleMeta =
      const VerificationMeta('subtitle');
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
      'subtitle', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastNotificationStatusKeywordMeta =
      const VerificationMeta('lastNotificationStatusKeyword');
  @override
  late final GeneratedColumn<String> lastNotificationStatusKeyword =
      GeneratedColumn<String>(
          'last_notification_status_keyword', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentsIdsMeta =
      const VerificationMeta('parentsIds');
  @override
  late final GeneratedColumn<String> parentsIds = GeneratedColumn<String>(
      'parents_ids', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        remoteId,
        companyUuid,
        typeId,
        title,
        subtitle,
        lastNotificationStatusKeyword,
        parentsIds
      ];
  @override
  String get aliasedName => _alias ?? 'articles';
  @override
  String get actualTableName => 'articles';
  @override
  VerificationContext validateIntegrity(Insertable<Article> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(_typeIdMeta,
          typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta));
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(_subtitleMeta,
          subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta));
    }
    if (data.containsKey('last_notification_status_keyword')) {
      context.handle(
          _lastNotificationStatusKeywordMeta,
          lastNotificationStatusKeyword.isAcceptableOrUnknown(
              data['last_notification_status_keyword']!,
              _lastNotificationStatusKeywordMeta));
    } else if (isInserting) {
      context.missing(_lastNotificationStatusKeywordMeta);
    }
    if (data.containsKey('parents_ids')) {
      context.handle(
          _parentsIdsMeta,
          parentsIds.isAcceptableOrUnknown(
              data['parents_ids']!, _parentsIdsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Article(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id'])!,
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      typeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subtitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subtitle']),
      lastNotificationStatusKeyword: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}last_notification_status_keyword'])!,
      parentsIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parents_ids']),
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }
}

class Article extends DataClass implements Insertable<Article> {
  final int id;
  final int remoteId;
  final String companyUuid;
  final int typeId;
  final String title;
  final String? subtitle;
  final String lastNotificationStatusKeyword;
  final String? parentsIds;
  const Article(
      {required this.id,
      required this.remoteId,
      required this.companyUuid,
      required this.typeId,
      required this.title,
      this.subtitle,
      required this.lastNotificationStatusKeyword,
      this.parentsIds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<int>(remoteId);
    map['company_uuid'] = Variable<String>(companyUuid);
    map['type_id'] = Variable<int>(typeId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    map['last_notification_status_keyword'] =
        Variable<String>(lastNotificationStatusKeyword);
    if (!nullToAbsent || parentsIds != null) {
      map['parents_ids'] = Variable<String>(parentsIds);
    }
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      companyUuid: Value(companyUuid),
      typeId: Value(typeId),
      title: Value(title),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      lastNotificationStatusKeyword: Value(lastNotificationStatusKeyword),
      parentsIds: parentsIds == null && nullToAbsent
          ? const Value.absent()
          : Value(parentsIds),
    );
  }

  factory Article.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int>(json['remoteId']),
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      typeId: serializer.fromJson<int>(json['typeId']),
      title: serializer.fromJson<String>(json['title']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      lastNotificationStatusKeyword:
          serializer.fromJson<String>(json['lastNotificationStatusKeyword']),
      parentsIds: serializer.fromJson<String?>(json['parentsIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int>(remoteId),
      'companyUuid': serializer.toJson<String>(companyUuid),
      'typeId': serializer.toJson<int>(typeId),
      'title': serializer.toJson<String>(title),
      'subtitle': serializer.toJson<String?>(subtitle),
      'lastNotificationStatusKeyword':
          serializer.toJson<String>(lastNotificationStatusKeyword),
      'parentsIds': serializer.toJson<String?>(parentsIds),
    };
  }

  Article copyWith(
          {int? id,
          int? remoteId,
          String? companyUuid,
          int? typeId,
          String? title,
          Value<String?> subtitle = const Value.absent(),
          String? lastNotificationStatusKeyword,
          Value<String?> parentsIds = const Value.absent()}) =>
      Article(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        companyUuid: companyUuid ?? this.companyUuid,
        typeId: typeId ?? this.typeId,
        title: title ?? this.title,
        subtitle: subtitle.present ? subtitle.value : this.subtitle,
        lastNotificationStatusKeyword:
            lastNotificationStatusKeyword ?? this.lastNotificationStatusKeyword,
        parentsIds: parentsIds.present ? parentsIds.value : this.parentsIds,
      );
  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('typeId: $typeId, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write(
              'lastNotificationStatusKeyword: $lastNotificationStatusKeyword, ')
          ..write('parentsIds: $parentsIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, remoteId, companyUuid, typeId, title,
      subtitle, lastNotificationStatusKeyword, parentsIds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.companyUuid == this.companyUuid &&
          other.typeId == this.typeId &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.lastNotificationStatusKeyword ==
              this.lastNotificationStatusKeyword &&
          other.parentsIds == this.parentsIds);
}

class ArticlesCompanion extends UpdateCompanion<Article> {
  final Value<int> id;
  final Value<int> remoteId;
  final Value<String> companyUuid;
  final Value<int> typeId;
  final Value<String> title;
  final Value<String?> subtitle;
  final Value<String> lastNotificationStatusKeyword;
  final Value<String?> parentsIds;
  const ArticlesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.companyUuid = const Value.absent(),
    this.typeId = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.lastNotificationStatusKeyword = const Value.absent(),
    this.parentsIds = const Value.absent(),
  });
  ArticlesCompanion.insert({
    this.id = const Value.absent(),
    required int remoteId,
    required String companyUuid,
    required int typeId,
    required String title,
    this.subtitle = const Value.absent(),
    required String lastNotificationStatusKeyword,
    this.parentsIds = const Value.absent(),
  })  : remoteId = Value(remoteId),
        companyUuid = Value(companyUuid),
        typeId = Value(typeId),
        title = Value(title),
        lastNotificationStatusKeyword = Value(lastNotificationStatusKeyword);
  static Insertable<Article> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? companyUuid,
    Expression<int>? typeId,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<String>? lastNotificationStatusKeyword,
    Expression<String>? parentsIds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (typeId != null) 'type_id': typeId,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (lastNotificationStatusKeyword != null)
        'last_notification_status_keyword': lastNotificationStatusKeyword,
      if (parentsIds != null) 'parents_ids': parentsIds,
    });
  }

  ArticlesCompanion copyWith(
      {Value<int>? id,
      Value<int>? remoteId,
      Value<String>? companyUuid,
      Value<int>? typeId,
      Value<String>? title,
      Value<String?>? subtitle,
      Value<String>? lastNotificationStatusKeyword,
      Value<String?>? parentsIds}) {
    return ArticlesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      companyUuid: companyUuid ?? this.companyUuid,
      typeId: typeId ?? this.typeId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lastNotificationStatusKeyword:
          lastNotificationStatusKeyword ?? this.lastNotificationStatusKeyword,
      parentsIds: parentsIds ?? this.parentsIds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (lastNotificationStatusKeyword.present) {
      map['last_notification_status_keyword'] =
          Variable<String>(lastNotificationStatusKeyword.value);
    }
    if (parentsIds.present) {
      map['parents_ids'] = Variable<String>(parentsIds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('typeId: $typeId, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write(
              'lastNotificationStatusKeyword: $lastNotificationStatusKeyword, ')
          ..write('parentsIds: $parentsIds')
          ..write(')'))
        .toString();
  }
}

class $ReviewTemplatesTable extends ReviewTemplates
    with TableInfo<$ReviewTemplatesTable, ReviewTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _expandableMeta =
      const VerificationMeta('expandable');
  @override
  late final GeneratedColumn<bool> expandable =
      GeneratedColumn<bool>('expandable', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("expandable" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _repeatableMeta =
      const VerificationMeta('repeatable');
  @override
  late final GeneratedColumn<bool> repeatable =
      GeneratedColumn<bool>('repeatable', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("repeatable" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _privateMeta =
      const VerificationMeta('private');
  @override
  late final GeneratedColumn<bool> private =
      GeneratedColumn<bool>('private', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("private" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isReworkMeta =
      const VerificationMeta('isRework');
  @override
  late final GeneratedColumn<bool> isRework =
      GeneratedColumn<bool>('is_rework', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_rework" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: Constant(false));
  static const VerificationMeta _rejectionAvailableMeta =
      const VerificationMeta('rejectionAvailable');
  @override
  late final GeneratedColumn<bool> rejectionAvailable =
      GeneratedColumn<bool>('rejection_available', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("rejection_available" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: Constant(false));
  static const VerificationMeta _delegationAvailableMeta =
      const VerificationMeta('delegationAvailable');
  @override
  late final GeneratedColumn<bool> delegationAvailable =
      GeneratedColumn<bool>('delegation_available', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("delegation_available" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: Constant(false));
  static const VerificationMeta _simpleSignatureFileMeta =
      const VerificationMeta('simpleSignatureFile');
  @override
  late final GeneratedColumn<String> simpleSignatureFile =
      GeneratedColumn<String>('simple_signature_file', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _simpleSignatureEnabledMeta =
      const VerificationMeta('simpleSignatureEnabled');
  @override
  late final GeneratedColumn<bool> simpleSignatureEnabled =
      GeneratedColumn<bool>('simple_signature_enabled', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("simple_signature_enabled" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isOpenedMeta =
      const VerificationMeta('isOpened');
  @override
  late final GeneratedColumn<bool> isOpened =
      GeneratedColumn<bool>('is_opened', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_opened" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        remoteId,
        parentId,
        companyUuid,
        name,
        description,
        expandable,
        repeatable,
        private,
        isRework,
        rejectionAvailable,
        delegationAvailable,
        simpleSignatureFile,
        simpleSignatureEnabled,
        isOpened
      ];
  @override
  String get aliasedName => _alias ?? 'review_templates';
  @override
  String get actualTableName => 'review_templates';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('expandable')) {
      context.handle(
          _expandableMeta,
          expandable.isAcceptableOrUnknown(
              data['expandable']!, _expandableMeta));
    } else if (isInserting) {
      context.missing(_expandableMeta);
    }
    if (data.containsKey('repeatable')) {
      context.handle(
          _repeatableMeta,
          repeatable.isAcceptableOrUnknown(
              data['repeatable']!, _repeatableMeta));
    } else if (isInserting) {
      context.missing(_repeatableMeta);
    }
    if (data.containsKey('private')) {
      context.handle(_privateMeta,
          private.isAcceptableOrUnknown(data['private']!, _privateMeta));
    } else if (isInserting) {
      context.missing(_privateMeta);
    }
    if (data.containsKey('is_rework')) {
      context.handle(_isReworkMeta,
          isRework.isAcceptableOrUnknown(data['is_rework']!, _isReworkMeta));
    }
    if (data.containsKey('rejection_available')) {
      context.handle(
          _rejectionAvailableMeta,
          rejectionAvailable.isAcceptableOrUnknown(
              data['rejection_available']!, _rejectionAvailableMeta));
    }
    if (data.containsKey('delegation_available')) {
      context.handle(
          _delegationAvailableMeta,
          delegationAvailable.isAcceptableOrUnknown(
              data['delegation_available']!, _delegationAvailableMeta));
    }
    if (data.containsKey('simple_signature_file')) {
      context.handle(
          _simpleSignatureFileMeta,
          simpleSignatureFile.isAcceptableOrUnknown(
              data['simple_signature_file']!, _simpleSignatureFileMeta));
    }
    if (data.containsKey('simple_signature_enabled')) {
      context.handle(
          _simpleSignatureEnabledMeta,
          simpleSignatureEnabled.isAcceptableOrUnknown(
              data['simple_signature_enabled']!, _simpleSignatureEnabledMeta));
    }
    if (data.containsKey('is_opened')) {
      context.handle(_isOpenedMeta,
          isOpened.isAcceptableOrUnknown(data['is_opened']!, _isOpenedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      expandable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}expandable'])!,
      repeatable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}repeatable'])!,
      private: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}private'])!,
      isRework: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_rework'])!,
      rejectionAvailable: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}rejection_available'])!,
      delegationAvailable: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}delegation_available'])!,
      simpleSignatureFile: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}simple_signature_file']),
      simpleSignatureEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}simple_signature_enabled']),
      isOpened: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_opened'])!,
    );
  }

  @override
  $ReviewTemplatesTable createAlias(String alias) {
    return $ReviewTemplatesTable(attachedDatabase, alias);
  }
}

class ReviewTemplate extends DataClass implements Insertable<ReviewTemplate> {
  final int id;
  final int remoteId;
  final int? parentId;
  final String companyUuid;
  final String name;
  final String? description;
  final bool expandable;
  final bool repeatable;
  final bool private;
  final bool isRework;
  final bool rejectionAvailable;
  final bool delegationAvailable;
  final String? simpleSignatureFile;
  final bool? simpleSignatureEnabled;
  final bool isOpened;
  const ReviewTemplate(
      {required this.id,
      required this.remoteId,
      this.parentId,
      required this.companyUuid,
      required this.name,
      this.description,
      required this.expandable,
      required this.repeatable,
      required this.private,
      required this.isRework,
      required this.rejectionAvailable,
      required this.delegationAvailable,
      this.simpleSignatureFile,
      this.simpleSignatureEnabled,
      required this.isOpened});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<int>(remoteId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['company_uuid'] = Variable<String>(companyUuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['expandable'] = Variable<bool>(expandable);
    map['repeatable'] = Variable<bool>(repeatable);
    map['private'] = Variable<bool>(private);
    map['is_rework'] = Variable<bool>(isRework);
    map['rejection_available'] = Variable<bool>(rejectionAvailable);
    map['delegation_available'] = Variable<bool>(delegationAvailable);
    if (!nullToAbsent || simpleSignatureFile != null) {
      map['simple_signature_file'] = Variable<String>(simpleSignatureFile);
    }
    if (!nullToAbsent || simpleSignatureEnabled != null) {
      map['simple_signature_enabled'] = Variable<bool>(simpleSignatureEnabled);
    }
    map['is_opened'] = Variable<bool>(isOpened);
    return map;
  }

  ReviewTemplatesCompanion toCompanion(bool nullToAbsent) {
    return ReviewTemplatesCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      companyUuid: Value(companyUuid),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      expandable: Value(expandable),
      repeatable: Value(repeatable),
      private: Value(private),
      isRework: Value(isRework),
      rejectionAvailable: Value(rejectionAvailable),
      delegationAvailable: Value(delegationAvailable),
      simpleSignatureFile: simpleSignatureFile == null && nullToAbsent
          ? const Value.absent()
          : Value(simpleSignatureFile),
      simpleSignatureEnabled: simpleSignatureEnabled == null && nullToAbsent
          ? const Value.absent()
          : Value(simpleSignatureEnabled),
      isOpened: Value(isOpened),
    );
  }

  factory ReviewTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewTemplate(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int>(json['remoteId']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      expandable: serializer.fromJson<bool>(json['expandable']),
      repeatable: serializer.fromJson<bool>(json['repeatable']),
      private: serializer.fromJson<bool>(json['private']),
      isRework: serializer.fromJson<bool>(json['isRework']),
      rejectionAvailable: serializer.fromJson<bool>(json['rejectionAvailable']),
      delegationAvailable:
          serializer.fromJson<bool>(json['delegationAvailable']),
      simpleSignatureFile:
          serializer.fromJson<String?>(json['simpleSignatureFile']),
      simpleSignatureEnabled:
          serializer.fromJson<bool?>(json['simpleSignatureEnabled']),
      isOpened: serializer.fromJson<bool>(json['isOpened']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int>(remoteId),
      'parentId': serializer.toJson<int?>(parentId),
      'companyUuid': serializer.toJson<String>(companyUuid),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'expandable': serializer.toJson<bool>(expandable),
      'repeatable': serializer.toJson<bool>(repeatable),
      'private': serializer.toJson<bool>(private),
      'isRework': serializer.toJson<bool>(isRework),
      'rejectionAvailable': serializer.toJson<bool>(rejectionAvailable),
      'delegationAvailable': serializer.toJson<bool>(delegationAvailable),
      'simpleSignatureFile': serializer.toJson<String?>(simpleSignatureFile),
      'simpleSignatureEnabled':
          serializer.toJson<bool?>(simpleSignatureEnabled),
      'isOpened': serializer.toJson<bool>(isOpened),
    };
  }

  ReviewTemplate copyWith(
          {int? id,
          int? remoteId,
          Value<int?> parentId = const Value.absent(),
          String? companyUuid,
          String? name,
          Value<String?> description = const Value.absent(),
          bool? expandable,
          bool? repeatable,
          bool? private,
          bool? isRework,
          bool? rejectionAvailable,
          bool? delegationAvailable,
          Value<String?> simpleSignatureFile = const Value.absent(),
          Value<bool?> simpleSignatureEnabled = const Value.absent(),
          bool? isOpened}) =>
      ReviewTemplate(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        parentId: parentId.present ? parentId.value : this.parentId,
        companyUuid: companyUuid ?? this.companyUuid,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        expandable: expandable ?? this.expandable,
        repeatable: repeatable ?? this.repeatable,
        private: private ?? this.private,
        isRework: isRework ?? this.isRework,
        rejectionAvailable: rejectionAvailable ?? this.rejectionAvailable,
        delegationAvailable: delegationAvailable ?? this.delegationAvailable,
        simpleSignatureFile: simpleSignatureFile.present
            ? simpleSignatureFile.value
            : this.simpleSignatureFile,
        simpleSignatureEnabled: simpleSignatureEnabled.present
            ? simpleSignatureEnabled.value
            : this.simpleSignatureEnabled,
        isOpened: isOpened ?? this.isOpened,
      );
  @override
  String toString() {
    return (StringBuffer('ReviewTemplate(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('parentId: $parentId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('expandable: $expandable, ')
          ..write('repeatable: $repeatable, ')
          ..write('private: $private, ')
          ..write('isRework: $isRework, ')
          ..write('rejectionAvailable: $rejectionAvailable, ')
          ..write('delegationAvailable: $delegationAvailable, ')
          ..write('simpleSignatureFile: $simpleSignatureFile, ')
          ..write('simpleSignatureEnabled: $simpleSignatureEnabled, ')
          ..write('isOpened: $isOpened')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      remoteId,
      parentId,
      companyUuid,
      name,
      description,
      expandable,
      repeatable,
      private,
      isRework,
      rejectionAvailable,
      delegationAvailable,
      simpleSignatureFile,
      simpleSignatureEnabled,
      isOpened);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewTemplate &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.parentId == this.parentId &&
          other.companyUuid == this.companyUuid &&
          other.name == this.name &&
          other.description == this.description &&
          other.expandable == this.expandable &&
          other.repeatable == this.repeatable &&
          other.private == this.private &&
          other.isRework == this.isRework &&
          other.rejectionAvailable == this.rejectionAvailable &&
          other.delegationAvailable == this.delegationAvailable &&
          other.simpleSignatureFile == this.simpleSignatureFile &&
          other.simpleSignatureEnabled == this.simpleSignatureEnabled &&
          other.isOpened == this.isOpened);
}

class ReviewTemplatesCompanion extends UpdateCompanion<ReviewTemplate> {
  final Value<int> id;
  final Value<int> remoteId;
  final Value<int?> parentId;
  final Value<String> companyUuid;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> expandable;
  final Value<bool> repeatable;
  final Value<bool> private;
  final Value<bool> isRework;
  final Value<bool> rejectionAvailable;
  final Value<bool> delegationAvailable;
  final Value<String?> simpleSignatureFile;
  final Value<bool?> simpleSignatureEnabled;
  final Value<bool> isOpened;
  const ReviewTemplatesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.companyUuid = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.expandable = const Value.absent(),
    this.repeatable = const Value.absent(),
    this.private = const Value.absent(),
    this.isRework = const Value.absent(),
    this.rejectionAvailable = const Value.absent(),
    this.delegationAvailable = const Value.absent(),
    this.simpleSignatureFile = const Value.absent(),
    this.simpleSignatureEnabled = const Value.absent(),
    this.isOpened = const Value.absent(),
  });
  ReviewTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required int remoteId,
    this.parentId = const Value.absent(),
    required String companyUuid,
    required String name,
    this.description = const Value.absent(),
    required bool expandable,
    required bool repeatable,
    required bool private,
    this.isRework = const Value.absent(),
    this.rejectionAvailable = const Value.absent(),
    this.delegationAvailable = const Value.absent(),
    this.simpleSignatureFile = const Value.absent(),
    this.simpleSignatureEnabled = const Value.absent(),
    this.isOpened = const Value.absent(),
  })  : remoteId = Value(remoteId),
        companyUuid = Value(companyUuid),
        name = Value(name),
        expandable = Value(expandable),
        repeatable = Value(repeatable),
        private = Value(private);
  static Insertable<ReviewTemplate> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<int>? parentId,
    Expression<String>? companyUuid,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? expandable,
    Expression<bool>? repeatable,
    Expression<bool>? private,
    Expression<bool>? isRework,
    Expression<bool>? rejectionAvailable,
    Expression<bool>? delegationAvailable,
    Expression<String>? simpleSignatureFile,
    Expression<bool>? simpleSignatureEnabled,
    Expression<bool>? isOpened,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (parentId != null) 'parent_id': parentId,
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (expandable != null) 'expandable': expandable,
      if (repeatable != null) 'repeatable': repeatable,
      if (private != null) 'private': private,
      if (isRework != null) 'is_rework': isRework,
      if (rejectionAvailable != null) 'rejection_available': rejectionAvailable,
      if (delegationAvailable != null)
        'delegation_available': delegationAvailable,
      if (simpleSignatureFile != null)
        'simple_signature_file': simpleSignatureFile,
      if (simpleSignatureEnabled != null)
        'simple_signature_enabled': simpleSignatureEnabled,
      if (isOpened != null) 'is_opened': isOpened,
    });
  }

  ReviewTemplatesCompanion copyWith(
      {Value<int>? id,
      Value<int>? remoteId,
      Value<int?>? parentId,
      Value<String>? companyUuid,
      Value<String>? name,
      Value<String?>? description,
      Value<bool>? expandable,
      Value<bool>? repeatable,
      Value<bool>? private,
      Value<bool>? isRework,
      Value<bool>? rejectionAvailable,
      Value<bool>? delegationAvailable,
      Value<String?>? simpleSignatureFile,
      Value<bool?>? simpleSignatureEnabled,
      Value<bool>? isOpened}) {
    return ReviewTemplatesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      parentId: parentId ?? this.parentId,
      companyUuid: companyUuid ?? this.companyUuid,
      name: name ?? this.name,
      description: description ?? this.description,
      expandable: expandable ?? this.expandable,
      repeatable: repeatable ?? this.repeatable,
      private: private ?? this.private,
      isRework: isRework ?? this.isRework,
      rejectionAvailable: rejectionAvailable ?? this.rejectionAvailable,
      delegationAvailable: delegationAvailable ?? this.delegationAvailable,
      simpleSignatureFile: simpleSignatureFile ?? this.simpleSignatureFile,
      simpleSignatureEnabled:
          simpleSignatureEnabled ?? this.simpleSignatureEnabled,
      isOpened: isOpened ?? this.isOpened,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (expandable.present) {
      map['expandable'] = Variable<bool>(expandable.value);
    }
    if (repeatable.present) {
      map['repeatable'] = Variable<bool>(repeatable.value);
    }
    if (private.present) {
      map['private'] = Variable<bool>(private.value);
    }
    if (isRework.present) {
      map['is_rework'] = Variable<bool>(isRework.value);
    }
    if (rejectionAvailable.present) {
      map['rejection_available'] = Variable<bool>(rejectionAvailable.value);
    }
    if (delegationAvailable.present) {
      map['delegation_available'] = Variable<bool>(delegationAvailable.value);
    }
    if (simpleSignatureFile.present) {
      map['simple_signature_file'] =
          Variable<String>(simpleSignatureFile.value);
    }
    if (simpleSignatureEnabled.present) {
      map['simple_signature_enabled'] =
          Variable<bool>(simpleSignatureEnabled.value);
    }
    if (isOpened.present) {
      map['is_opened'] = Variable<bool>(isOpened.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('parentId: $parentId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('expandable: $expandable, ')
          ..write('repeatable: $repeatable, ')
          ..write('private: $private, ')
          ..write('isRework: $isRework, ')
          ..write('rejectionAvailable: $rejectionAvailable, ')
          ..write('delegationAvailable: $delegationAvailable, ')
          ..write('simpleSignatureFile: $simpleSignatureFile, ')
          ..write('simpleSignatureEnabled: $simpleSignatureEnabled, ')
          ..write('isOpened: $isOpened')
          ..write(')'))
        .toString();
  }
}

class $ReviewTemplateFormsTable extends ReviewTemplateForms
    with TableInfo<$ReviewTemplateFormsTable, ReviewTemplateForm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewTemplateFormsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (remote_uuid) ON DELETE CASCADE'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, remoteId, parentId, companyUuid, title, slug, description];
  @override
  String get aliasedName => _alias ?? 'review_template_forms';
  @override
  String get actualTableName => 'review_template_forms';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewTemplateForm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewTemplateForm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewTemplateForm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $ReviewTemplateFormsTable createAlias(String alias) {
    return $ReviewTemplateFormsTable(attachedDatabase, alias);
  }
}

class ReviewTemplateForm extends DataClass
    implements Insertable<ReviewTemplateForm> {
  final int id;
  final int remoteId;
  final int? parentId;
  final String companyUuid;
  final String title;
  final String slug;
  final String? description;
  const ReviewTemplateForm(
      {required this.id,
      required this.remoteId,
      this.parentId,
      required this.companyUuid,
      required this.title,
      required this.slug,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<int>(remoteId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['company_uuid'] = Variable<String>(companyUuid);
    map['title'] = Variable<String>(title);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  ReviewTemplateFormsCompanion toCompanion(bool nullToAbsent) {
    return ReviewTemplateFormsCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      companyUuid: Value(companyUuid),
      title: Value(title),
      slug: Value(slug),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory ReviewTemplateForm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewTemplateForm(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int>(json['remoteId']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      title: serializer.fromJson<String>(json['title']),
      slug: serializer.fromJson<String>(json['slug']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int>(remoteId),
      'parentId': serializer.toJson<int?>(parentId),
      'companyUuid': serializer.toJson<String>(companyUuid),
      'title': serializer.toJson<String>(title),
      'slug': serializer.toJson<String>(slug),
      'description': serializer.toJson<String?>(description),
    };
  }

  ReviewTemplateForm copyWith(
          {int? id,
          int? remoteId,
          Value<int?> parentId = const Value.absent(),
          String? companyUuid,
          String? title,
          String? slug,
          Value<String?> description = const Value.absent()}) =>
      ReviewTemplateForm(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        parentId: parentId.present ? parentId.value : this.parentId,
        companyUuid: companyUuid ?? this.companyUuid,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('ReviewTemplateForm(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('parentId: $parentId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('title: $title, ')
          ..write('slug: $slug, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, remoteId, parentId, companyUuid, title, slug, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewTemplateForm &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.parentId == this.parentId &&
          other.companyUuid == this.companyUuid &&
          other.title == this.title &&
          other.slug == this.slug &&
          other.description == this.description);
}

class ReviewTemplateFormsCompanion extends UpdateCompanion<ReviewTemplateForm> {
  final Value<int> id;
  final Value<int> remoteId;
  final Value<int?> parentId;
  final Value<String> companyUuid;
  final Value<String> title;
  final Value<String> slug;
  final Value<String?> description;
  const ReviewTemplateFormsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.companyUuid = const Value.absent(),
    this.title = const Value.absent(),
    this.slug = const Value.absent(),
    this.description = const Value.absent(),
  });
  ReviewTemplateFormsCompanion.insert({
    this.id = const Value.absent(),
    required int remoteId,
    this.parentId = const Value.absent(),
    required String companyUuid,
    required String title,
    required String slug,
    this.description = const Value.absent(),
  })  : remoteId = Value(remoteId),
        companyUuid = Value(companyUuid),
        title = Value(title),
        slug = Value(slug);
  static Insertable<ReviewTemplateForm> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<int>? parentId,
    Expression<String>? companyUuid,
    Expression<String>? title,
    Expression<String>? slug,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (parentId != null) 'parent_id': parentId,
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (title != null) 'title': title,
      if (slug != null) 'slug': slug,
      if (description != null) 'description': description,
    });
  }

  ReviewTemplateFormsCompanion copyWith(
      {Value<int>? id,
      Value<int>? remoteId,
      Value<int?>? parentId,
      Value<String>? companyUuid,
      Value<String>? title,
      Value<String>? slug,
      Value<String?>? description}) {
    return ReviewTemplateFormsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      parentId: parentId ?? this.parentId,
      companyUuid: companyUuid ?? this.companyUuid,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewTemplateFormsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('parentId: $parentId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('title: $title, ')
          ..write('slug: $slug, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $ReviewTemplateFormFieldsTable extends ReviewTemplateFormFields
    with TableInfo<$ReviewTemplateFormFieldsTable, ReviewTemplateFormField> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewTemplateFormFieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (remote_uuid) ON DELETE CASCADE'));
  static const VerificationMeta _formIdMeta = const VerificationMeta('formId');
  @override
  late final GeneratedColumn<int> formId = GeneratedColumn<int>(
      'form_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES review_template_forms (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _propertiesMeta =
      const VerificationMeta('properties');
  @override
  late final GeneratedColumn<String> properties = GeneratedColumn<String>(
      'properties', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        remoteId,
        parentId,
        companyUuid,
        formId,
        type,
        title,
        slug,
        properties,
        weight
      ];
  @override
  String get aliasedName => _alias ?? 'review_template_form_fields';
  @override
  String get actualTableName => 'review_template_form_fields';
  @override
  VerificationContext validateIntegrity(
      Insertable<ReviewTemplateFormField> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('form_id')) {
      context.handle(_formIdMeta,
          formId.isAcceptableOrUnknown(data['form_id']!, _formIdMeta));
    } else if (isInserting) {
      context.missing(_formIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('properties')) {
      context.handle(
          _propertiesMeta,
          properties.isAcceptableOrUnknown(
              data['properties']!, _propertiesMeta));
    } else if (isInserting) {
      context.missing(_propertiesMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewTemplateFormField map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewTemplateFormField(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      formId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}form_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      properties: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}properties'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
    );
  }

  @override
  $ReviewTemplateFormFieldsTable createAlias(String alias) {
    return $ReviewTemplateFormFieldsTable(attachedDatabase, alias);
  }
}

class ReviewTemplateFormField extends DataClass
    implements Insertable<ReviewTemplateFormField> {
  final int id;
  final int remoteId;
  final int? parentId;
  final String companyUuid;
  final int formId;
  final String type;
  final String title;
  final String slug;
  final String properties;
  final int weight;
  const ReviewTemplateFormField(
      {required this.id,
      required this.remoteId,
      this.parentId,
      required this.companyUuid,
      required this.formId,
      required this.type,
      required this.title,
      required this.slug,
      required this.properties,
      required this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<int>(remoteId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['company_uuid'] = Variable<String>(companyUuid);
    map['form_id'] = Variable<int>(formId);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['slug'] = Variable<String>(slug);
    map['properties'] = Variable<String>(properties);
    map['weight'] = Variable<int>(weight);
    return map;
  }

  ReviewTemplateFormFieldsCompanion toCompanion(bool nullToAbsent) {
    return ReviewTemplateFormFieldsCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      companyUuid: Value(companyUuid),
      formId: Value(formId),
      type: Value(type),
      title: Value(title),
      slug: Value(slug),
      properties: Value(properties),
      weight: Value(weight),
    );
  }

  factory ReviewTemplateFormField.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewTemplateFormField(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int>(json['remoteId']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      formId: serializer.fromJson<int>(json['formId']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      slug: serializer.fromJson<String>(json['slug']),
      properties: serializer.fromJson<String>(json['properties']),
      weight: serializer.fromJson<int>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int>(remoteId),
      'parentId': serializer.toJson<int?>(parentId),
      'companyUuid': serializer.toJson<String>(companyUuid),
      'formId': serializer.toJson<int>(formId),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'slug': serializer.toJson<String>(slug),
      'properties': serializer.toJson<String>(properties),
      'weight': serializer.toJson<int>(weight),
    };
  }

  ReviewTemplateFormField copyWith(
          {int? id,
          int? remoteId,
          Value<int?> parentId = const Value.absent(),
          String? companyUuid,
          int? formId,
          String? type,
          String? title,
          String? slug,
          String? properties,
          int? weight}) =>
      ReviewTemplateFormField(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        parentId: parentId.present ? parentId.value : this.parentId,
        companyUuid: companyUuid ?? this.companyUuid,
        formId: formId ?? this.formId,
        type: type ?? this.type,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        properties: properties ?? this.properties,
        weight: weight ?? this.weight,
      );
  @override
  String toString() {
    return (StringBuffer('ReviewTemplateFormField(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('parentId: $parentId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('formId: $formId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('slug: $slug, ')
          ..write('properties: $properties, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, remoteId, parentId, companyUuid, formId,
      type, title, slug, properties, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewTemplateFormField &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.parentId == this.parentId &&
          other.companyUuid == this.companyUuid &&
          other.formId == this.formId &&
          other.type == this.type &&
          other.title == this.title &&
          other.slug == this.slug &&
          other.properties == this.properties &&
          other.weight == this.weight);
}

class ReviewTemplateFormFieldsCompanion
    extends UpdateCompanion<ReviewTemplateFormField> {
  final Value<int> id;
  final Value<int> remoteId;
  final Value<int?> parentId;
  final Value<String> companyUuid;
  final Value<int> formId;
  final Value<String> type;
  final Value<String> title;
  final Value<String> slug;
  final Value<String> properties;
  final Value<int> weight;
  const ReviewTemplateFormFieldsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.companyUuid = const Value.absent(),
    this.formId = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.slug = const Value.absent(),
    this.properties = const Value.absent(),
    this.weight = const Value.absent(),
  });
  ReviewTemplateFormFieldsCompanion.insert({
    this.id = const Value.absent(),
    required int remoteId,
    this.parentId = const Value.absent(),
    required String companyUuid,
    required int formId,
    required String type,
    required String title,
    required String slug,
    required String properties,
    required int weight,
  })  : remoteId = Value(remoteId),
        companyUuid = Value(companyUuid),
        formId = Value(formId),
        type = Value(type),
        title = Value(title),
        slug = Value(slug),
        properties = Value(properties),
        weight = Value(weight);
  static Insertable<ReviewTemplateFormField> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<int>? parentId,
    Expression<String>? companyUuid,
    Expression<int>? formId,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? slug,
    Expression<String>? properties,
    Expression<int>? weight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (parentId != null) 'parent_id': parentId,
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (formId != null) 'form_id': formId,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (slug != null) 'slug': slug,
      if (properties != null) 'properties': properties,
      if (weight != null) 'weight': weight,
    });
  }

  ReviewTemplateFormFieldsCompanion copyWith(
      {Value<int>? id,
      Value<int>? remoteId,
      Value<int?>? parentId,
      Value<String>? companyUuid,
      Value<int>? formId,
      Value<String>? type,
      Value<String>? title,
      Value<String>? slug,
      Value<String>? properties,
      Value<int>? weight}) {
    return ReviewTemplateFormFieldsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      parentId: parentId ?? this.parentId,
      companyUuid: companyUuid ?? this.companyUuid,
      formId: formId ?? this.formId,
      type: type ?? this.type,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      properties: properties ?? this.properties,
      weight: weight ?? this.weight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (formId.present) {
      map['form_id'] = Variable<int>(formId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (properties.present) {
      map['properties'] = Variable<String>(properties.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewTemplateFormFieldsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('parentId: $parentId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('formId: $formId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('slug: $slug, ')
          ..write('properties: $properties, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

class $ReviewTemplateStepsTable extends ReviewTemplateSteps
    with TableInfo<$ReviewTemplateStepsTable, ReviewTemplateStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewTemplateStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _remoteUuidMeta =
      const VerificationMeta('remoteUuid');
  @override
  late final GeneratedColumn<String> remoteUuid = GeneratedColumn<String>(
      'remote_uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (remote_uuid) ON DELETE CASCADE'));
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES review_templates (id)'));
  static const VerificationMeta _reviewUuidMeta =
      const VerificationMeta('reviewUuid');
  @override
  late final GeneratedColumn<String> reviewUuid = GeneratedColumn<String>(
      'review_uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subtitleMeta =
      const VerificationMeta('subtitle');
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
      'subtitle', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentTextMeta =
      const VerificationMeta('contentText');
  @override
  late final GeneratedColumn<String> contentText = GeneratedColumn<String>(
      'content_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentImageMeta =
      const VerificationMeta('contentImage');
  @override
  late final GeneratedColumn<String> contentImage = GeneratedColumn<String>(
      'content_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentMaskMeta =
      const VerificationMeta('contentMask');
  @override
  late final GeneratedColumn<String> contentMask = GeneratedColumn<String>(
      'content_mask', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _requiredMeta =
      const VerificationMeta('required');
  @override
  late final GeneratedColumn<bool> required =
      GeneratedColumn<bool>('required', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("required" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _multimediaMeta =
      const VerificationMeta('multimedia');
  @override
  late final GeneratedColumn<String> multimedia = GeneratedColumn<String>(
      'multimedia', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _requiredCommentWhenSkippingMeta =
      const VerificationMeta('requiredCommentWhenSkipping');
  @override
  late final GeneratedColumn<bool> requiredCommentWhenSkipping =
      GeneratedColumn<bool>(
          'required_comment_when_skipping', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite:
                'CHECK ("required_comment_when_skipping" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: Constant(true));
  static const VerificationMeta _expandableMeta =
      const VerificationMeta('expandable');
  @override
  late final GeneratedColumn<bool> expandable =
      GeneratedColumn<bool>('expandable', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("expandable" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _repeatableMeta =
      const VerificationMeta('repeatable');
  @override
  late final GeneratedColumn<bool> repeatable =
      GeneratedColumn<bool>('repeatable', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("repeatable" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _canHaveViolationMeta =
      const VerificationMeta('canHaveViolation');
  @override
  late final GeneratedColumn<bool> canHaveViolation =
      GeneratedColumn<bool>('can_have_violation', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("can_have_violation" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isSelfCreatedMeta =
      const VerificationMeta('isSelfCreated');
  @override
  late final GeneratedColumn<bool> isSelfCreated =
      GeneratedColumn<bool>('is_self_created', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_self_created" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: Constant(false));
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _formIdMeta = const VerificationMeta('formId');
  @override
  late final GeneratedColumn<int> formId = GeneratedColumn<int>(
      'form_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES review_template_forms (id)'));
  static const VerificationMeta _sectionIdMeta =
      const VerificationMeta('sectionId');
  @override
  late final GeneratedColumn<int> sectionId = GeneratedColumn<int>(
      'section_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _localSectionIdMeta =
      const VerificationMeta('localSectionId');
  @override
  late final GeneratedColumn<int> localSectionId = GeneratedColumn<int>(
      'local_section_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _multipleMeta =
      const VerificationMeta('multiple');
  @override
  late final GeneratedColumn<bool> multiple =
      GeneratedColumn<bool>('multiple', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("multiple" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _limitFilesMeta =
      const VerificationMeta('limitFiles');
  @override
  late final GeneratedColumn<String> limitFiles = GeneratedColumn<String>(
      'limit_files', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _limitVideoDurationMeta =
      const VerificationMeta('limitVideoDuration');
  @override
  late final GeneratedColumn<String> limitVideoDuration =
      GeneratedColumn<String>('limit_video_duration', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        remoteId,
        parentId,
        remoteUuid,
        companyUuid,
        templateId,
        reviewUuid,
        type,
        title,
        subtitle,
        contentText,
        contentImage,
        contentMask,
        weight,
        required,
        multimedia,
        requiredCommentWhenSkipping,
        expandable,
        repeatable,
        canHaveViolation,
        isSelfCreated,
        comment,
        formId,
        sectionId,
        localSectionId,
        multiple,
        limitFiles,
        limitVideoDuration
      ];
  @override
  String get aliasedName => _alias ?? 'review_template_steps';
  @override
  String get actualTableName => 'review_template_steps';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewTemplateStep> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('remote_uuid')) {
      context.handle(
          _remoteUuidMeta,
          remoteUuid.isAcceptableOrUnknown(
              data['remote_uuid']!, _remoteUuidMeta));
    }
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('review_uuid')) {
      context.handle(
          _reviewUuidMeta,
          reviewUuid.isAcceptableOrUnknown(
              data['review_uuid']!, _reviewUuidMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(_subtitleMeta,
          subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta));
    }
    if (data.containsKey('content_text')) {
      context.handle(
          _contentTextMeta,
          contentText.isAcceptableOrUnknown(
              data['content_text']!, _contentTextMeta));
    }
    if (data.containsKey('content_image')) {
      context.handle(
          _contentImageMeta,
          contentImage.isAcceptableOrUnknown(
              data['content_image']!, _contentImageMeta));
    }
    if (data.containsKey('content_mask')) {
      context.handle(
          _contentMaskMeta,
          contentMask.isAcceptableOrUnknown(
              data['content_mask']!, _contentMaskMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('required')) {
      context.handle(_requiredMeta,
          required.isAcceptableOrUnknown(data['required']!, _requiredMeta));
    } else if (isInserting) {
      context.missing(_requiredMeta);
    }
    if (data.containsKey('multimedia')) {
      context.handle(
          _multimediaMeta,
          multimedia.isAcceptableOrUnknown(
              data['multimedia']!, _multimediaMeta));
    }
    if (data.containsKey('required_comment_when_skipping')) {
      context.handle(
          _requiredCommentWhenSkippingMeta,
          requiredCommentWhenSkipping.isAcceptableOrUnknown(
              data['required_comment_when_skipping']!,
              _requiredCommentWhenSkippingMeta));
    }
    if (data.containsKey('expandable')) {
      context.handle(
          _expandableMeta,
          expandable.isAcceptableOrUnknown(
              data['expandable']!, _expandableMeta));
    } else if (isInserting) {
      context.missing(_expandableMeta);
    }
    if (data.containsKey('repeatable')) {
      context.handle(
          _repeatableMeta,
          repeatable.isAcceptableOrUnknown(
              data['repeatable']!, _repeatableMeta));
    } else if (isInserting) {
      context.missing(_repeatableMeta);
    }
    if (data.containsKey('can_have_violation')) {
      context.handle(
          _canHaveViolationMeta,
          canHaveViolation.isAcceptableOrUnknown(
              data['can_have_violation']!, _canHaveViolationMeta));
    } else if (isInserting) {
      context.missing(_canHaveViolationMeta);
    }
    if (data.containsKey('is_self_created')) {
      context.handle(
          _isSelfCreatedMeta,
          isSelfCreated.isAcceptableOrUnknown(
              data['is_self_created']!, _isSelfCreatedMeta));
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    }
    if (data.containsKey('form_id')) {
      context.handle(_formIdMeta,
          formId.isAcceptableOrUnknown(data['form_id']!, _formIdMeta));
    }
    if (data.containsKey('section_id')) {
      context.handle(_sectionIdMeta,
          sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta));
    }
    if (data.containsKey('local_section_id')) {
      context.handle(
          _localSectionIdMeta,
          localSectionId.isAcceptableOrUnknown(
              data['local_section_id']!, _localSectionIdMeta));
    }
    if (data.containsKey('multiple')) {
      context.handle(_multipleMeta,
          multiple.isAcceptableOrUnknown(data['multiple']!, _multipleMeta));
    }
    if (data.containsKey('limit_files')) {
      context.handle(
          _limitFilesMeta,
          limitFiles.isAcceptableOrUnknown(
              data['limit_files']!, _limitFilesMeta));
    }
    if (data.containsKey('limit_video_duration')) {
      context.handle(
          _limitVideoDurationMeta,
          limitVideoDuration.isAcceptableOrUnknown(
              data['limit_video_duration']!, _limitVideoDurationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewTemplateStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewTemplateStep(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id']),
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      remoteUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_uuid']),
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id'])!,
      reviewUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_uuid']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subtitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subtitle']),
      contentText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_text']),
      contentImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_image']),
      contentMask: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_mask']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
      required: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}required'])!,
      multimedia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}multimedia']),
      requiredCommentWhenSkipping: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}required_comment_when_skipping'])!,
      expandable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}expandable'])!,
      repeatable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}repeatable'])!,
      canHaveViolation: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_have_violation'])!,
      isSelfCreated: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_self_created'])!,
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment']),
      formId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}form_id']),
      sectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}section_id']),
      localSectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}local_section_id']),
      multiple: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}multiple']),
      limitFiles: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}limit_files']),
      limitVideoDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}limit_video_duration']),
    );
  }

  @override
  $ReviewTemplateStepsTable createAlias(String alias) {
    return $ReviewTemplateStepsTable(attachedDatabase, alias);
  }
}

class ReviewTemplateStep extends DataClass
    implements Insertable<ReviewTemplateStep> {
  final int id;
  final int? remoteId;
  final int? parentId;
  final String? remoteUuid;
  final String companyUuid;
  final int templateId;
  final String? reviewUuid;
  final String type;
  final String title;
  final String? subtitle;
  final String? contentText;
  final String? contentImage;
  final String? contentMask;
  final int weight;
  final bool required;
  final String? multimedia;
  final bool requiredCommentWhenSkipping;
  final bool expandable;
  final bool repeatable;
  final bool canHaveViolation;
  final bool isSelfCreated;
  final String? comment;
  final int? formId;
  final int? sectionId;
  final int? localSectionId;
  final bool? multiple;
  final String? limitFiles;
  final String? limitVideoDuration;
  const ReviewTemplateStep(
      {required this.id,
      this.remoteId,
      this.parentId,
      this.remoteUuid,
      required this.companyUuid,
      required this.templateId,
      this.reviewUuid,
      required this.type,
      required this.title,
      this.subtitle,
      this.contentText,
      this.contentImage,
      this.contentMask,
      required this.weight,
      required this.required,
      this.multimedia,
      required this.requiredCommentWhenSkipping,
      required this.expandable,
      required this.repeatable,
      required this.canHaveViolation,
      required this.isSelfCreated,
      this.comment,
      this.formId,
      this.sectionId,
      this.localSectionId,
      this.multiple,
      this.limitFiles,
      this.limitVideoDuration});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    if (!nullToAbsent || remoteUuid != null) {
      map['remote_uuid'] = Variable<String>(remoteUuid);
    }
    map['company_uuid'] = Variable<String>(companyUuid);
    map['template_id'] = Variable<int>(templateId);
    if (!nullToAbsent || reviewUuid != null) {
      map['review_uuid'] = Variable<String>(reviewUuid);
    }
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || contentText != null) {
      map['content_text'] = Variable<String>(contentText);
    }
    if (!nullToAbsent || contentImage != null) {
      map['content_image'] = Variable<String>(contentImage);
    }
    if (!nullToAbsent || contentMask != null) {
      map['content_mask'] = Variable<String>(contentMask);
    }
    map['weight'] = Variable<int>(weight);
    map['required'] = Variable<bool>(required);
    if (!nullToAbsent || multimedia != null) {
      map['multimedia'] = Variable<String>(multimedia);
    }
    map['required_comment_when_skipping'] =
        Variable<bool>(requiredCommentWhenSkipping);
    map['expandable'] = Variable<bool>(expandable);
    map['repeatable'] = Variable<bool>(repeatable);
    map['can_have_violation'] = Variable<bool>(canHaveViolation);
    map['is_self_created'] = Variable<bool>(isSelfCreated);
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || formId != null) {
      map['form_id'] = Variable<int>(formId);
    }
    if (!nullToAbsent || sectionId != null) {
      map['section_id'] = Variable<int>(sectionId);
    }
    if (!nullToAbsent || localSectionId != null) {
      map['local_section_id'] = Variable<int>(localSectionId);
    }
    if (!nullToAbsent || multiple != null) {
      map['multiple'] = Variable<bool>(multiple);
    }
    if (!nullToAbsent || limitFiles != null) {
      map['limit_files'] = Variable<String>(limitFiles);
    }
    if (!nullToAbsent || limitVideoDuration != null) {
      map['limit_video_duration'] = Variable<String>(limitVideoDuration);
    }
    return map;
  }

  ReviewTemplateStepsCompanion toCompanion(bool nullToAbsent) {
    return ReviewTemplateStepsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      remoteUuid: remoteUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUuid),
      companyUuid: Value(companyUuid),
      templateId: Value(templateId),
      reviewUuid: reviewUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewUuid),
      type: Value(type),
      title: Value(title),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      contentText: contentText == null && nullToAbsent
          ? const Value.absent()
          : Value(contentText),
      contentImage: contentImage == null && nullToAbsent
          ? const Value.absent()
          : Value(contentImage),
      contentMask: contentMask == null && nullToAbsent
          ? const Value.absent()
          : Value(contentMask),
      weight: Value(weight),
      required: Value(required),
      multimedia: multimedia == null && nullToAbsent
          ? const Value.absent()
          : Value(multimedia),
      requiredCommentWhenSkipping: Value(requiredCommentWhenSkipping),
      expandable: Value(expandable),
      repeatable: Value(repeatable),
      canHaveViolation: Value(canHaveViolation),
      isSelfCreated: Value(isSelfCreated),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      formId:
          formId == null && nullToAbsent ? const Value.absent() : Value(formId),
      sectionId: sectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sectionId),
      localSectionId: localSectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(localSectionId),
      multiple: multiple == null && nullToAbsent
          ? const Value.absent()
          : Value(multiple),
      limitFiles: limitFiles == null && nullToAbsent
          ? const Value.absent()
          : Value(limitFiles),
      limitVideoDuration: limitVideoDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(limitVideoDuration),
    );
  }

  factory ReviewTemplateStep.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewTemplateStep(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      remoteUuid: serializer.fromJson<String?>(json['remoteUuid']),
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      templateId: serializer.fromJson<int>(json['templateId']),
      reviewUuid: serializer.fromJson<String?>(json['reviewUuid']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      contentText: serializer.fromJson<String?>(json['contentText']),
      contentImage: serializer.fromJson<String?>(json['contentImage']),
      contentMask: serializer.fromJson<String?>(json['contentMask']),
      weight: serializer.fromJson<int>(json['weight']),
      required: serializer.fromJson<bool>(json['required']),
      multimedia: serializer.fromJson<String?>(json['multimedia']),
      requiredCommentWhenSkipping:
          serializer.fromJson<bool>(json['requiredCommentWhenSkipping']),
      expandable: serializer.fromJson<bool>(json['expandable']),
      repeatable: serializer.fromJson<bool>(json['repeatable']),
      canHaveViolation: serializer.fromJson<bool>(json['canHaveViolation']),
      isSelfCreated: serializer.fromJson<bool>(json['isSelfCreated']),
      comment: serializer.fromJson<String?>(json['comment']),
      formId: serializer.fromJson<int?>(json['formId']),
      sectionId: serializer.fromJson<int?>(json['sectionId']),
      localSectionId: serializer.fromJson<int?>(json['localSectionId']),
      multiple: serializer.fromJson<bool?>(json['multiple']),
      limitFiles: serializer.fromJson<String?>(json['limitFiles']),
      limitVideoDuration:
          serializer.fromJson<String?>(json['limitVideoDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'parentId': serializer.toJson<int?>(parentId),
      'remoteUuid': serializer.toJson<String?>(remoteUuid),
      'companyUuid': serializer.toJson<String>(companyUuid),
      'templateId': serializer.toJson<int>(templateId),
      'reviewUuid': serializer.toJson<String?>(reviewUuid),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'subtitle': serializer.toJson<String?>(subtitle),
      'contentText': serializer.toJson<String?>(contentText),
      'contentImage': serializer.toJson<String?>(contentImage),
      'contentMask': serializer.toJson<String?>(contentMask),
      'weight': serializer.toJson<int>(weight),
      'required': serializer.toJson<bool>(required),
      'multimedia': serializer.toJson<String?>(multimedia),
      'requiredCommentWhenSkipping':
          serializer.toJson<bool>(requiredCommentWhenSkipping),
      'expandable': serializer.toJson<bool>(expandable),
      'repeatable': serializer.toJson<bool>(repeatable),
      'canHaveViolation': serializer.toJson<bool>(canHaveViolation),
      'isSelfCreated': serializer.toJson<bool>(isSelfCreated),
      'comment': serializer.toJson<String?>(comment),
      'formId': serializer.toJson<int?>(formId),
      'sectionId': serializer.toJson<int?>(sectionId),
      'localSectionId': serializer.toJson<int?>(localSectionId),
      'multiple': serializer.toJson<bool?>(multiple),
      'limitFiles': serializer.toJson<String?>(limitFiles),
      'limitVideoDuration': serializer.toJson<String?>(limitVideoDuration),
    };
  }

  ReviewTemplateStep copyWith(
          {int? id,
          Value<int?> remoteId = const Value.absent(),
          Value<int?> parentId = const Value.absent(),
          Value<String?> remoteUuid = const Value.absent(),
          String? companyUuid,
          int? templateId,
          Value<String?> reviewUuid = const Value.absent(),
          String? type,
          String? title,
          Value<String?> subtitle = const Value.absent(),
          Value<String?> contentText = const Value.absent(),
          Value<String?> contentImage = const Value.absent(),
          Value<String?> contentMask = const Value.absent(),
          int? weight,
          bool? required,
          Value<String?> multimedia = const Value.absent(),
          bool? requiredCommentWhenSkipping,
          bool? expandable,
          bool? repeatable,
          bool? canHaveViolation,
          bool? isSelfCreated,
          Value<String?> comment = const Value.absent(),
          Value<int?> formId = const Value.absent(),
          Value<int?> sectionId = const Value.absent(),
          Value<int?> localSectionId = const Value.absent(),
          Value<bool?> multiple = const Value.absent(),
          Value<String?> limitFiles = const Value.absent(),
          Value<String?> limitVideoDuration = const Value.absent()}) =>
      ReviewTemplateStep(
        id: id ?? this.id,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        parentId: parentId.present ? parentId.value : this.parentId,
        remoteUuid: remoteUuid.present ? remoteUuid.value : this.remoteUuid,
        companyUuid: companyUuid ?? this.companyUuid,
        templateId: templateId ?? this.templateId,
        reviewUuid: reviewUuid.present ? reviewUuid.value : this.reviewUuid,
        type: type ?? this.type,
        title: title ?? this.title,
        subtitle: subtitle.present ? subtitle.value : this.subtitle,
        contentText: contentText.present ? contentText.value : this.contentText,
        contentImage:
            contentImage.present ? contentImage.value : this.contentImage,
        contentMask: contentMask.present ? contentMask.value : this.contentMask,
        weight: weight ?? this.weight,
        required: required ?? this.required,
        multimedia: multimedia.present ? multimedia.value : this.multimedia,
        requiredCommentWhenSkipping:
            requiredCommentWhenSkipping ?? this.requiredCommentWhenSkipping,
        expandable: expandable ?? this.expandable,
        repeatable: repeatable ?? this.repeatable,
        canHaveViolation: canHaveViolation ?? this.canHaveViolation,
        isSelfCreated: isSelfCreated ?? this.isSelfCreated,
        comment: comment.present ? comment.value : this.comment,
        formId: formId.present ? formId.value : this.formId,
        sectionId: sectionId.present ? sectionId.value : this.sectionId,
        localSectionId:
            localSectionId.present ? localSectionId.value : this.localSectionId,
        multiple: multiple.present ? multiple.value : this.multiple,
        limitFiles: limitFiles.present ? limitFiles.value : this.limitFiles,
        limitVideoDuration: limitVideoDuration.present
            ? limitVideoDuration.value
            : this.limitVideoDuration,
      );
  @override
  String toString() {
    return (StringBuffer('ReviewTemplateStep(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('parentId: $parentId, ')
          ..write('remoteUuid: $remoteUuid, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('templateId: $templateId, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('contentText: $contentText, ')
          ..write('contentImage: $contentImage, ')
          ..write('contentMask: $contentMask, ')
          ..write('weight: $weight, ')
          ..write('required: $required, ')
          ..write('multimedia: $multimedia, ')
          ..write('requiredCommentWhenSkipping: $requiredCommentWhenSkipping, ')
          ..write('expandable: $expandable, ')
          ..write('repeatable: $repeatable, ')
          ..write('canHaveViolation: $canHaveViolation, ')
          ..write('isSelfCreated: $isSelfCreated, ')
          ..write('comment: $comment, ')
          ..write('formId: $formId, ')
          ..write('sectionId: $sectionId, ')
          ..write('localSectionId: $localSectionId, ')
          ..write('multiple: $multiple, ')
          ..write('limitFiles: $limitFiles, ')
          ..write('limitVideoDuration: $limitVideoDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        remoteId,
        parentId,
        remoteUuid,
        companyUuid,
        templateId,
        reviewUuid,
        type,
        title,
        subtitle,
        contentText,
        contentImage,
        contentMask,
        weight,
        required,
        multimedia,
        requiredCommentWhenSkipping,
        expandable,
        repeatable,
        canHaveViolation,
        isSelfCreated,
        comment,
        formId,
        sectionId,
        localSectionId,
        multiple,
        limitFiles,
        limitVideoDuration
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewTemplateStep &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.parentId == this.parentId &&
          other.remoteUuid == this.remoteUuid &&
          other.companyUuid == this.companyUuid &&
          other.templateId == this.templateId &&
          other.reviewUuid == this.reviewUuid &&
          other.type == this.type &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.contentText == this.contentText &&
          other.contentImage == this.contentImage &&
          other.contentMask == this.contentMask &&
          other.weight == this.weight &&
          other.required == this.required &&
          other.multimedia == this.multimedia &&
          other.requiredCommentWhenSkipping ==
              this.requiredCommentWhenSkipping &&
          other.expandable == this.expandable &&
          other.repeatable == this.repeatable &&
          other.canHaveViolation == this.canHaveViolation &&
          other.isSelfCreated == this.isSelfCreated &&
          other.comment == this.comment &&
          other.formId == this.formId &&
          other.sectionId == this.sectionId &&
          other.localSectionId == this.localSectionId &&
          other.multiple == this.multiple &&
          other.limitFiles == this.limitFiles &&
          other.limitVideoDuration == this.limitVideoDuration);
}

class ReviewTemplateStepsCompanion extends UpdateCompanion<ReviewTemplateStep> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<int?> parentId;
  final Value<String?> remoteUuid;
  final Value<String> companyUuid;
  final Value<int> templateId;
  final Value<String?> reviewUuid;
  final Value<String> type;
  final Value<String> title;
  final Value<String?> subtitle;
  final Value<String?> contentText;
  final Value<String?> contentImage;
  final Value<String?> contentMask;
  final Value<int> weight;
  final Value<bool> required;
  final Value<String?> multimedia;
  final Value<bool> requiredCommentWhenSkipping;
  final Value<bool> expandable;
  final Value<bool> repeatable;
  final Value<bool> canHaveViolation;
  final Value<bool> isSelfCreated;
  final Value<String?> comment;
  final Value<int?> formId;
  final Value<int?> sectionId;
  final Value<int?> localSectionId;
  final Value<bool?> multiple;
  final Value<String?> limitFiles;
  final Value<String?> limitVideoDuration;
  const ReviewTemplateStepsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.remoteUuid = const Value.absent(),
    this.companyUuid = const Value.absent(),
    this.templateId = const Value.absent(),
    this.reviewUuid = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.contentText = const Value.absent(),
    this.contentImage = const Value.absent(),
    this.contentMask = const Value.absent(),
    this.weight = const Value.absent(),
    this.required = const Value.absent(),
    this.multimedia = const Value.absent(),
    this.requiredCommentWhenSkipping = const Value.absent(),
    this.expandable = const Value.absent(),
    this.repeatable = const Value.absent(),
    this.canHaveViolation = const Value.absent(),
    this.isSelfCreated = const Value.absent(),
    this.comment = const Value.absent(),
    this.formId = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.localSectionId = const Value.absent(),
    this.multiple = const Value.absent(),
    this.limitFiles = const Value.absent(),
    this.limitVideoDuration = const Value.absent(),
  });
  ReviewTemplateStepsCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.remoteUuid = const Value.absent(),
    required String companyUuid,
    required int templateId,
    this.reviewUuid = const Value.absent(),
    required String type,
    required String title,
    this.subtitle = const Value.absent(),
    this.contentText = const Value.absent(),
    this.contentImage = const Value.absent(),
    this.contentMask = const Value.absent(),
    required int weight,
    required bool required,
    this.multimedia = const Value.absent(),
    this.requiredCommentWhenSkipping = const Value.absent(),
    required bool expandable,
    required bool repeatable,
    required bool canHaveViolation,
    this.isSelfCreated = const Value.absent(),
    this.comment = const Value.absent(),
    this.formId = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.localSectionId = const Value.absent(),
    this.multiple = const Value.absent(),
    this.limitFiles = const Value.absent(),
    this.limitVideoDuration = const Value.absent(),
  })  : companyUuid = Value(companyUuid),
        templateId = Value(templateId),
        type = Value(type),
        title = Value(title),
        weight = Value(weight),
        required = Value(required),
        expandable = Value(expandable),
        repeatable = Value(repeatable),
        canHaveViolation = Value(canHaveViolation);
  static Insertable<ReviewTemplateStep> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<int>? parentId,
    Expression<String>? remoteUuid,
    Expression<String>? companyUuid,
    Expression<int>? templateId,
    Expression<String>? reviewUuid,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<String>? contentText,
    Expression<String>? contentImage,
    Expression<String>? contentMask,
    Expression<int>? weight,
    Expression<bool>? required,
    Expression<String>? multimedia,
    Expression<bool>? requiredCommentWhenSkipping,
    Expression<bool>? expandable,
    Expression<bool>? repeatable,
    Expression<bool>? canHaveViolation,
    Expression<bool>? isSelfCreated,
    Expression<String>? comment,
    Expression<int>? formId,
    Expression<int>? sectionId,
    Expression<int>? localSectionId,
    Expression<bool>? multiple,
    Expression<String>? limitFiles,
    Expression<String>? limitVideoDuration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (parentId != null) 'parent_id': parentId,
      if (remoteUuid != null) 'remote_uuid': remoteUuid,
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (templateId != null) 'template_id': templateId,
      if (reviewUuid != null) 'review_uuid': reviewUuid,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (contentText != null) 'content_text': contentText,
      if (contentImage != null) 'content_image': contentImage,
      if (contentMask != null) 'content_mask': contentMask,
      if (weight != null) 'weight': weight,
      if (required != null) 'required': required,
      if (multimedia != null) 'multimedia': multimedia,
      if (requiredCommentWhenSkipping != null)
        'required_comment_when_skipping': requiredCommentWhenSkipping,
      if (expandable != null) 'expandable': expandable,
      if (repeatable != null) 'repeatable': repeatable,
      if (canHaveViolation != null) 'can_have_violation': canHaveViolation,
      if (isSelfCreated != null) 'is_self_created': isSelfCreated,
      if (comment != null) 'comment': comment,
      if (formId != null) 'form_id': formId,
      if (sectionId != null) 'section_id': sectionId,
      if (localSectionId != null) 'local_section_id': localSectionId,
      if (multiple != null) 'multiple': multiple,
      if (limitFiles != null) 'limit_files': limitFiles,
      if (limitVideoDuration != null)
        'limit_video_duration': limitVideoDuration,
    });
  }

  ReviewTemplateStepsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? remoteId,
      Value<int?>? parentId,
      Value<String?>? remoteUuid,
      Value<String>? companyUuid,
      Value<int>? templateId,
      Value<String?>? reviewUuid,
      Value<String>? type,
      Value<String>? title,
      Value<String?>? subtitle,
      Value<String?>? contentText,
      Value<String?>? contentImage,
      Value<String?>? contentMask,
      Value<int>? weight,
      Value<bool>? required,
      Value<String?>? multimedia,
      Value<bool>? requiredCommentWhenSkipping,
      Value<bool>? expandable,
      Value<bool>? repeatable,
      Value<bool>? canHaveViolation,
      Value<bool>? isSelfCreated,
      Value<String?>? comment,
      Value<int?>? formId,
      Value<int?>? sectionId,
      Value<int?>? localSectionId,
      Value<bool?>? multiple,
      Value<String?>? limitFiles,
      Value<String?>? limitVideoDuration}) {
    return ReviewTemplateStepsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      parentId: parentId ?? this.parentId,
      remoteUuid: remoteUuid ?? this.remoteUuid,
      companyUuid: companyUuid ?? this.companyUuid,
      templateId: templateId ?? this.templateId,
      reviewUuid: reviewUuid ?? this.reviewUuid,
      type: type ?? this.type,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      contentText: contentText ?? this.contentText,
      contentImage: contentImage ?? this.contentImage,
      contentMask: contentMask ?? this.contentMask,
      weight: weight ?? this.weight,
      required: required ?? this.required,
      multimedia: multimedia ?? this.multimedia,
      requiredCommentWhenSkipping:
          requiredCommentWhenSkipping ?? this.requiredCommentWhenSkipping,
      expandable: expandable ?? this.expandable,
      repeatable: repeatable ?? this.repeatable,
      canHaveViolation: canHaveViolation ?? this.canHaveViolation,
      isSelfCreated: isSelfCreated ?? this.isSelfCreated,
      comment: comment ?? this.comment,
      formId: formId ?? this.formId,
      sectionId: sectionId ?? this.sectionId,
      localSectionId: localSectionId ?? this.localSectionId,
      multiple: multiple ?? this.multiple,
      limitFiles: limitFiles ?? this.limitFiles,
      limitVideoDuration: limitVideoDuration ?? this.limitVideoDuration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (remoteUuid.present) {
      map['remote_uuid'] = Variable<String>(remoteUuid.value);
    }
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (reviewUuid.present) {
      map['review_uuid'] = Variable<String>(reviewUuid.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (contentText.present) {
      map['content_text'] = Variable<String>(contentText.value);
    }
    if (contentImage.present) {
      map['content_image'] = Variable<String>(contentImage.value);
    }
    if (contentMask.present) {
      map['content_mask'] = Variable<String>(contentMask.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (required.present) {
      map['required'] = Variable<bool>(required.value);
    }
    if (multimedia.present) {
      map['multimedia'] = Variable<String>(multimedia.value);
    }
    if (requiredCommentWhenSkipping.present) {
      map['required_comment_when_skipping'] =
          Variable<bool>(requiredCommentWhenSkipping.value);
    }
    if (expandable.present) {
      map['expandable'] = Variable<bool>(expandable.value);
    }
    if (repeatable.present) {
      map['repeatable'] = Variable<bool>(repeatable.value);
    }
    if (canHaveViolation.present) {
      map['can_have_violation'] = Variable<bool>(canHaveViolation.value);
    }
    if (isSelfCreated.present) {
      map['is_self_created'] = Variable<bool>(isSelfCreated.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (formId.present) {
      map['form_id'] = Variable<int>(formId.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<int>(sectionId.value);
    }
    if (localSectionId.present) {
      map['local_section_id'] = Variable<int>(localSectionId.value);
    }
    if (multiple.present) {
      map['multiple'] = Variable<bool>(multiple.value);
    }
    if (limitFiles.present) {
      map['limit_files'] = Variable<String>(limitFiles.value);
    }
    if (limitVideoDuration.present) {
      map['limit_video_duration'] = Variable<String>(limitVideoDuration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewTemplateStepsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('parentId: $parentId, ')
          ..write('remoteUuid: $remoteUuid, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('templateId: $templateId, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('contentText: $contentText, ')
          ..write('contentImage: $contentImage, ')
          ..write('contentMask: $contentMask, ')
          ..write('weight: $weight, ')
          ..write('required: $required, ')
          ..write('multimedia: $multimedia, ')
          ..write('requiredCommentWhenSkipping: $requiredCommentWhenSkipping, ')
          ..write('expandable: $expandable, ')
          ..write('repeatable: $repeatable, ')
          ..write('canHaveViolation: $canHaveViolation, ')
          ..write('isSelfCreated: $isSelfCreated, ')
          ..write('comment: $comment, ')
          ..write('formId: $formId, ')
          ..write('sectionId: $sectionId, ')
          ..write('localSectionId: $localSectionId, ')
          ..write('multiple: $multiple, ')
          ..write('limitFiles: $limitFiles, ')
          ..write('limitVideoDuration: $limitVideoDuration')
          ..write(')'))
        .toString();
  }
}

class $ReviewTemplateArticlesTable extends ReviewTemplateArticles
    with TableInfo<$ReviewTemplateArticlesTable, ReviewTemplateArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewTemplateArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (remote_uuid) ON DELETE CASCADE'));
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES review_templates (id)'));
  static const VerificationMeta _articleIdMeta =
      const VerificationMeta('articleId');
  @override
  late final GeneratedColumn<int> articleId = GeneratedColumn<int>(
      'article_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES articles (id)'));
  @override
  List<GeneratedColumn> get $columns => [companyUuid, templateId, articleId];
  @override
  String get aliasedName => _alias ?? 'review_template_articles';
  @override
  String get actualTableName => 'review_template_articles';
  @override
  VerificationContext validateIntegrity(
      Insertable<ReviewTemplateArticle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('article_id')) {
      context.handle(_articleIdMeta,
          articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta));
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {companyUuid, templateId, articleId};
  @override
  ReviewTemplateArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewTemplateArticle(
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id'])!,
      articleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}article_id'])!,
    );
  }

  @override
  $ReviewTemplateArticlesTable createAlias(String alias) {
    return $ReviewTemplateArticlesTable(attachedDatabase, alias);
  }
}

class ReviewTemplateArticle extends DataClass
    implements Insertable<ReviewTemplateArticle> {
  final String companyUuid;
  final int templateId;
  final int articleId;
  const ReviewTemplateArticle(
      {required this.companyUuid,
      required this.templateId,
      required this.articleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['company_uuid'] = Variable<String>(companyUuid);
    map['template_id'] = Variable<int>(templateId);
    map['article_id'] = Variable<int>(articleId);
    return map;
  }

  ReviewTemplateArticlesCompanion toCompanion(bool nullToAbsent) {
    return ReviewTemplateArticlesCompanion(
      companyUuid: Value(companyUuid),
      templateId: Value(templateId),
      articleId: Value(articleId),
    );
  }

  factory ReviewTemplateArticle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewTemplateArticle(
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      templateId: serializer.fromJson<int>(json['templateId']),
      articleId: serializer.fromJson<int>(json['articleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'companyUuid': serializer.toJson<String>(companyUuid),
      'templateId': serializer.toJson<int>(templateId),
      'articleId': serializer.toJson<int>(articleId),
    };
  }

  ReviewTemplateArticle copyWith(
          {String? companyUuid, int? templateId, int? articleId}) =>
      ReviewTemplateArticle(
        companyUuid: companyUuid ?? this.companyUuid,
        templateId: templateId ?? this.templateId,
        articleId: articleId ?? this.articleId,
      );
  @override
  String toString() {
    return (StringBuffer('ReviewTemplateArticle(')
          ..write('companyUuid: $companyUuid, ')
          ..write('templateId: $templateId, ')
          ..write('articleId: $articleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(companyUuid, templateId, articleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewTemplateArticle &&
          other.companyUuid == this.companyUuid &&
          other.templateId == this.templateId &&
          other.articleId == this.articleId);
}

class ReviewTemplateArticlesCompanion
    extends UpdateCompanion<ReviewTemplateArticle> {
  final Value<String> companyUuid;
  final Value<int> templateId;
  final Value<int> articleId;
  const ReviewTemplateArticlesCompanion({
    this.companyUuid = const Value.absent(),
    this.templateId = const Value.absent(),
    this.articleId = const Value.absent(),
  });
  ReviewTemplateArticlesCompanion.insert({
    required String companyUuid,
    required int templateId,
    required int articleId,
  })  : companyUuid = Value(companyUuid),
        templateId = Value(templateId),
        articleId = Value(articleId);
  static Insertable<ReviewTemplateArticle> custom({
    Expression<String>? companyUuid,
    Expression<int>? templateId,
    Expression<int>? articleId,
  }) {
    return RawValuesInsertable({
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (templateId != null) 'template_id': templateId,
      if (articleId != null) 'article_id': articleId,
    });
  }

  ReviewTemplateArticlesCompanion copyWith(
      {Value<String>? companyUuid,
      Value<int>? templateId,
      Value<int>? articleId}) {
    return ReviewTemplateArticlesCompanion(
      companyUuid: companyUuid ?? this.companyUuid,
      templateId: templateId ?? this.templateId,
      articleId: articleId ?? this.articleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (articleId.present) {
      map['article_id'] = Variable<int>(articleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewTemplateArticlesCompanion(')
          ..write('companyUuid: $companyUuid, ')
          ..write('templateId: $templateId, ')
          ..write('articleId: $articleId')
          ..write(')'))
        .toString();
  }
}

class $ReviewsTable extends Reviews with TableInfo<$ReviewsTable, Review> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _articleIdMeta =
      const VerificationMeta('articleId');
  @override
  late final GeneratedColumn<int> articleId = GeneratedColumn<int>(
      'article_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _remoteArticleIdMeta =
      const VerificationMeta('remoteArticleId');
  @override
  late final GeneratedColumn<int> remoteArticleId = GeneratedColumn<int>(
      'remote_article_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteTemplateIdMeta =
      const VerificationMeta('remoteTemplateId');
  @override
  late final GeneratedColumn<int> remoteTemplateId = GeneratedColumn<int>(
      'remote_template_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remoteTaskIdMeta =
      const VerificationMeta('remoteTaskId');
  @override
  late final GeneratedColumn<int> remoteTaskId = GeneratedColumn<int>(
      'remote_task_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _offlineMeta =
      const VerificationMeta('offline');
  @override
  late final GeneratedColumn<bool> offline =
      GeneratedColumn<bool>('offline', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("offline" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _onDeviceStartedAtMeta =
      const VerificationMeta('onDeviceStartedAt');
  @override
  late final GeneratedColumn<DateTime> onDeviceStartedAt =
      GeneratedColumn<DateTime>('on_device_started_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startPointUploadedAtMeta =
      const VerificationMeta('startPointUploadedAt');
  @override
  late final GeneratedColumn<DateTime> startPointUploadedAt =
      GeneratedColumn<DateTime>('start_point_uploaded_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _interruptedAtMeta =
      const VerificationMeta('interruptedAt');
  @override
  late final GeneratedColumn<DateTime> interruptedAt =
      GeneratedColumn<DateTime>('interrupted_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _onDeviceInterruptedAtMeta =
      const VerificationMeta('onDeviceInterruptedAt');
  @override
  late final GeneratedColumn<DateTime> onDeviceInterruptedAt =
      GeneratedColumn<DateTime>('on_device_interrupted_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _interruptPointUploadedAtMeta =
      const VerificationMeta('interruptPointUploadedAt');
  @override
  late final GeneratedColumn<DateTime> interruptPointUploadedAt =
      GeneratedColumn<DateTime>(
          'interrupt_point_uploaded_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _finishedAtMeta =
      const VerificationMeta('finishedAt');
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
      'finished_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _onDeviceFinishedAtMeta =
      const VerificationMeta('onDeviceFinishedAt');
  @override
  late final GeneratedColumn<DateTime> onDeviceFinishedAt =
      GeneratedColumn<DateTime>('on_device_finished_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _finishedUploadedAtMeta =
      const VerificationMeta('finishedUploadedAt');
  @override
  late final GeneratedColumn<DateTime> finishedUploadedAt =
      GeneratedColumn<DateTime>('finished_uploaded_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _violationsUploadedAtMeta =
      const VerificationMeta('violationsUploadedAt');
  @override
  late final GeneratedColumn<DateTime> violationsUploadedAt =
      GeneratedColumn<DateTime>('violations_uploaded_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _commentsUploadedAtMeta =
      const VerificationMeta('commentsUploadedAt');
  @override
  late final GeneratedColumn<DateTime> commentsUploadedAt =
      GeneratedColumn<DateTime>('comments_uploaded_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletingMediaUploadedAtMeta =
      const VerificationMeta('deletingMediaUploadedAt');
  @override
  late final GeneratedColumn<DateTime> deletingMediaUploadedAt =
      GeneratedColumn<DateTime>('deleting_media_uploaded_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uuid,
        companyUuid,
        articleId,
        remoteArticleId,
        templateId,
        remoteTemplateId,
        remoteTaskId,
        offline,
        startedAt,
        onDeviceStartedAt,
        startPointUploadedAt,
        interruptedAt,
        onDeviceInterruptedAt,
        interruptPointUploadedAt,
        finishedAt,
        onDeviceFinishedAt,
        finishedUploadedAt,
        violationsUploadedAt,
        commentsUploadedAt,
        deletingMediaUploadedAt
      ];
  @override
  String get aliasedName => _alias ?? 'reviews';
  @override
  String get actualTableName => 'reviews';
  @override
  VerificationContext validateIntegrity(Insertable<Review> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('article_id')) {
      context.handle(_articleIdMeta,
          articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta));
    }
    if (data.containsKey('remote_article_id')) {
      context.handle(
          _remoteArticleIdMeta,
          remoteArticleId.isAcceptableOrUnknown(
              data['remote_article_id']!, _remoteArticleIdMeta));
    } else if (isInserting) {
      context.missing(_remoteArticleIdMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('remote_template_id')) {
      context.handle(
          _remoteTemplateIdMeta,
          remoteTemplateId.isAcceptableOrUnknown(
              data['remote_template_id']!, _remoteTemplateIdMeta));
    } else if (isInserting) {
      context.missing(_remoteTemplateIdMeta);
    }
    if (data.containsKey('remote_task_id')) {
      context.handle(
          _remoteTaskIdMeta,
          remoteTaskId.isAcceptableOrUnknown(
              data['remote_task_id']!, _remoteTaskIdMeta));
    }
    if (data.containsKey('offline')) {
      context.handle(_offlineMeta,
          offline.isAcceptableOrUnknown(data['offline']!, _offlineMeta));
    } else if (isInserting) {
      context.missing(_offlineMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('on_device_started_at')) {
      context.handle(
          _onDeviceStartedAtMeta,
          onDeviceStartedAt.isAcceptableOrUnknown(
              data['on_device_started_at']!, _onDeviceStartedAtMeta));
    } else if (isInserting) {
      context.missing(_onDeviceStartedAtMeta);
    }
    if (data.containsKey('start_point_uploaded_at')) {
      context.handle(
          _startPointUploadedAtMeta,
          startPointUploadedAt.isAcceptableOrUnknown(
              data['start_point_uploaded_at']!, _startPointUploadedAtMeta));
    }
    if (data.containsKey('interrupted_at')) {
      context.handle(
          _interruptedAtMeta,
          interruptedAt.isAcceptableOrUnknown(
              data['interrupted_at']!, _interruptedAtMeta));
    }
    if (data.containsKey('on_device_interrupted_at')) {
      context.handle(
          _onDeviceInterruptedAtMeta,
          onDeviceInterruptedAt.isAcceptableOrUnknown(
              data['on_device_interrupted_at']!, _onDeviceInterruptedAtMeta));
    }
    if (data.containsKey('interrupt_point_uploaded_at')) {
      context.handle(
          _interruptPointUploadedAtMeta,
          interruptPointUploadedAt.isAcceptableOrUnknown(
              data['interrupt_point_uploaded_at']!,
              _interruptPointUploadedAtMeta));
    }
    if (data.containsKey('finished_at')) {
      context.handle(
          _finishedAtMeta,
          finishedAt.isAcceptableOrUnknown(
              data['finished_at']!, _finishedAtMeta));
    }
    if (data.containsKey('on_device_finished_at')) {
      context.handle(
          _onDeviceFinishedAtMeta,
          onDeviceFinishedAt.isAcceptableOrUnknown(
              data['on_device_finished_at']!, _onDeviceFinishedAtMeta));
    }
    if (data.containsKey('finished_uploaded_at')) {
      context.handle(
          _finishedUploadedAtMeta,
          finishedUploadedAt.isAcceptableOrUnknown(
              data['finished_uploaded_at']!, _finishedUploadedAtMeta));
    }
    if (data.containsKey('violations_uploaded_at')) {
      context.handle(
          _violationsUploadedAtMeta,
          violationsUploadedAt.isAcceptableOrUnknown(
              data['violations_uploaded_at']!, _violationsUploadedAtMeta));
    }
    if (data.containsKey('comments_uploaded_at')) {
      context.handle(
          _commentsUploadedAtMeta,
          commentsUploadedAt.isAcceptableOrUnknown(
              data['comments_uploaded_at']!, _commentsUploadedAtMeta));
    }
    if (data.containsKey('deleting_media_uploaded_at')) {
      context.handle(
          _deletingMediaUploadedAtMeta,
          deletingMediaUploadedAt.isAcceptableOrUnknown(
              data['deleting_media_uploaded_at']!,
              _deletingMediaUploadedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid, companyUuid};
  @override
  Review map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Review(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      articleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}article_id']),
      remoteArticleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_article_id'])!,
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id'])!,
      remoteTemplateId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}remote_template_id'])!,
      remoteTaskId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_task_id']),
      offline: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}offline'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      onDeviceStartedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}on_device_started_at'])!,
      startPointUploadedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}start_point_uploaded_at']),
      interruptedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}interrupted_at']),
      onDeviceInterruptedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}on_device_interrupted_at']),
      interruptPointUploadedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}interrupt_point_uploaded_at']),
      finishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}finished_at']),
      onDeviceFinishedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}on_device_finished_at']),
      finishedUploadedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}finished_uploaded_at']),
      violationsUploadedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}violations_uploaded_at']),
      commentsUploadedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}comments_uploaded_at']),
      deletingMediaUploadedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}deleting_media_uploaded_at']),
    );
  }

  @override
  $ReviewsTable createAlias(String alias) {
    return $ReviewsTable(attachedDatabase, alias);
  }
}

class Review extends DataClass implements Insertable<Review> {
  final String uuid;
  final String companyUuid;
  final int? articleId;
  final int remoteArticleId;
  final int templateId;
  final int remoteTemplateId;
  final int? remoteTaskId;
  final bool offline;
  final DateTime startedAt;
  final DateTime onDeviceStartedAt;
  final DateTime? startPointUploadedAt;
  final DateTime? interruptedAt;
  final DateTime? onDeviceInterruptedAt;
  final DateTime? interruptPointUploadedAt;
  final DateTime? finishedAt;
  final DateTime? onDeviceFinishedAt;
  final DateTime? finishedUploadedAt;
  final DateTime? violationsUploadedAt;
  final DateTime? commentsUploadedAt;
  final DateTime? deletingMediaUploadedAt;
  const Review(
      {required this.uuid,
      required this.companyUuid,
      this.articleId,
      required this.remoteArticleId,
      required this.templateId,
      required this.remoteTemplateId,
      this.remoteTaskId,
      required this.offline,
      required this.startedAt,
      required this.onDeviceStartedAt,
      this.startPointUploadedAt,
      this.interruptedAt,
      this.onDeviceInterruptedAt,
      this.interruptPointUploadedAt,
      this.finishedAt,
      this.onDeviceFinishedAt,
      this.finishedUploadedAt,
      this.violationsUploadedAt,
      this.commentsUploadedAt,
      this.deletingMediaUploadedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['company_uuid'] = Variable<String>(companyUuid);
    if (!nullToAbsent || articleId != null) {
      map['article_id'] = Variable<int>(articleId);
    }
    map['remote_article_id'] = Variable<int>(remoteArticleId);
    map['template_id'] = Variable<int>(templateId);
    map['remote_template_id'] = Variable<int>(remoteTemplateId);
    if (!nullToAbsent || remoteTaskId != null) {
      map['remote_task_id'] = Variable<int>(remoteTaskId);
    }
    map['offline'] = Variable<bool>(offline);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['on_device_started_at'] = Variable<DateTime>(onDeviceStartedAt);
    if (!nullToAbsent || startPointUploadedAt != null) {
      map['start_point_uploaded_at'] = Variable<DateTime>(startPointUploadedAt);
    }
    if (!nullToAbsent || interruptedAt != null) {
      map['interrupted_at'] = Variable<DateTime>(interruptedAt);
    }
    if (!nullToAbsent || onDeviceInterruptedAt != null) {
      map['on_device_interrupted_at'] =
          Variable<DateTime>(onDeviceInterruptedAt);
    }
    if (!nullToAbsent || interruptPointUploadedAt != null) {
      map['interrupt_point_uploaded_at'] =
          Variable<DateTime>(interruptPointUploadedAt);
    }
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    if (!nullToAbsent || onDeviceFinishedAt != null) {
      map['on_device_finished_at'] = Variable<DateTime>(onDeviceFinishedAt);
    }
    if (!nullToAbsent || finishedUploadedAt != null) {
      map['finished_uploaded_at'] = Variable<DateTime>(finishedUploadedAt);
    }
    if (!nullToAbsent || violationsUploadedAt != null) {
      map['violations_uploaded_at'] = Variable<DateTime>(violationsUploadedAt);
    }
    if (!nullToAbsent || commentsUploadedAt != null) {
      map['comments_uploaded_at'] = Variable<DateTime>(commentsUploadedAt);
    }
    if (!nullToAbsent || deletingMediaUploadedAt != null) {
      map['deleting_media_uploaded_at'] =
          Variable<DateTime>(deletingMediaUploadedAt);
    }
    return map;
  }

  ReviewsCompanion toCompanion(bool nullToAbsent) {
    return ReviewsCompanion(
      uuid: Value(uuid),
      companyUuid: Value(companyUuid),
      articleId: articleId == null && nullToAbsent
          ? const Value.absent()
          : Value(articleId),
      remoteArticleId: Value(remoteArticleId),
      templateId: Value(templateId),
      remoteTemplateId: Value(remoteTemplateId),
      remoteTaskId: remoteTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteTaskId),
      offline: Value(offline),
      startedAt: Value(startedAt),
      onDeviceStartedAt: Value(onDeviceStartedAt),
      startPointUploadedAt: startPointUploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startPointUploadedAt),
      interruptedAt: interruptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(interruptedAt),
      onDeviceInterruptedAt: onDeviceInterruptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(onDeviceInterruptedAt),
      interruptPointUploadedAt: interruptPointUploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(interruptPointUploadedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      onDeviceFinishedAt: onDeviceFinishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(onDeviceFinishedAt),
      finishedUploadedAt: finishedUploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedUploadedAt),
      violationsUploadedAt: violationsUploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(violationsUploadedAt),
      commentsUploadedAt: commentsUploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(commentsUploadedAt),
      deletingMediaUploadedAt: deletingMediaUploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletingMediaUploadedAt),
    );
  }

  factory Review.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Review(
      uuid: serializer.fromJson<String>(json['uuid']),
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      articleId: serializer.fromJson<int?>(json['articleId']),
      remoteArticleId: serializer.fromJson<int>(json['remoteArticleId']),
      templateId: serializer.fromJson<int>(json['templateId']),
      remoteTemplateId: serializer.fromJson<int>(json['remoteTemplateId']),
      remoteTaskId: serializer.fromJson<int?>(json['remoteTaskId']),
      offline: serializer.fromJson<bool>(json['offline']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      onDeviceStartedAt:
          serializer.fromJson<DateTime>(json['onDeviceStartedAt']),
      startPointUploadedAt:
          serializer.fromJson<DateTime?>(json['startPointUploadedAt']),
      interruptedAt: serializer.fromJson<DateTime?>(json['interruptedAt']),
      onDeviceInterruptedAt:
          serializer.fromJson<DateTime?>(json['onDeviceInterruptedAt']),
      interruptPointUploadedAt:
          serializer.fromJson<DateTime?>(json['interruptPointUploadedAt']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
      onDeviceFinishedAt:
          serializer.fromJson<DateTime?>(json['onDeviceFinishedAt']),
      finishedUploadedAt:
          serializer.fromJson<DateTime?>(json['finishedUploadedAt']),
      violationsUploadedAt:
          serializer.fromJson<DateTime?>(json['violationsUploadedAt']),
      commentsUploadedAt:
          serializer.fromJson<DateTime?>(json['commentsUploadedAt']),
      deletingMediaUploadedAt:
          serializer.fromJson<DateTime?>(json['deletingMediaUploadedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'companyUuid': serializer.toJson<String>(companyUuid),
      'articleId': serializer.toJson<int?>(articleId),
      'remoteArticleId': serializer.toJson<int>(remoteArticleId),
      'templateId': serializer.toJson<int>(templateId),
      'remoteTemplateId': serializer.toJson<int>(remoteTemplateId),
      'remoteTaskId': serializer.toJson<int?>(remoteTaskId),
      'offline': serializer.toJson<bool>(offline),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'onDeviceStartedAt': serializer.toJson<DateTime>(onDeviceStartedAt),
      'startPointUploadedAt':
          serializer.toJson<DateTime?>(startPointUploadedAt),
      'interruptedAt': serializer.toJson<DateTime?>(interruptedAt),
      'onDeviceInterruptedAt':
          serializer.toJson<DateTime?>(onDeviceInterruptedAt),
      'interruptPointUploadedAt':
          serializer.toJson<DateTime?>(interruptPointUploadedAt),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
      'onDeviceFinishedAt': serializer.toJson<DateTime?>(onDeviceFinishedAt),
      'finishedUploadedAt': serializer.toJson<DateTime?>(finishedUploadedAt),
      'violationsUploadedAt':
          serializer.toJson<DateTime?>(violationsUploadedAt),
      'commentsUploadedAt': serializer.toJson<DateTime?>(commentsUploadedAt),
      'deletingMediaUploadedAt':
          serializer.toJson<DateTime?>(deletingMediaUploadedAt),
    };
  }

  Review copyWith(
          {String? uuid,
          String? companyUuid,
          Value<int?> articleId = const Value.absent(),
          int? remoteArticleId,
          int? templateId,
          int? remoteTemplateId,
          Value<int?> remoteTaskId = const Value.absent(),
          bool? offline,
          DateTime? startedAt,
          DateTime? onDeviceStartedAt,
          Value<DateTime?> startPointUploadedAt = const Value.absent(),
          Value<DateTime?> interruptedAt = const Value.absent(),
          Value<DateTime?> onDeviceInterruptedAt = const Value.absent(),
          Value<DateTime?> interruptPointUploadedAt = const Value.absent(),
          Value<DateTime?> finishedAt = const Value.absent(),
          Value<DateTime?> onDeviceFinishedAt = const Value.absent(),
          Value<DateTime?> finishedUploadedAt = const Value.absent(),
          Value<DateTime?> violationsUploadedAt = const Value.absent(),
          Value<DateTime?> commentsUploadedAt = const Value.absent(),
          Value<DateTime?> deletingMediaUploadedAt = const Value.absent()}) =>
      Review(
        uuid: uuid ?? this.uuid,
        companyUuid: companyUuid ?? this.companyUuid,
        articleId: articleId.present ? articleId.value : this.articleId,
        remoteArticleId: remoteArticleId ?? this.remoteArticleId,
        templateId: templateId ?? this.templateId,
        remoteTemplateId: remoteTemplateId ?? this.remoteTemplateId,
        remoteTaskId:
            remoteTaskId.present ? remoteTaskId.value : this.remoteTaskId,
        offline: offline ?? this.offline,
        startedAt: startedAt ?? this.startedAt,
        onDeviceStartedAt: onDeviceStartedAt ?? this.onDeviceStartedAt,
        startPointUploadedAt: startPointUploadedAt.present
            ? startPointUploadedAt.value
            : this.startPointUploadedAt,
        interruptedAt:
            interruptedAt.present ? interruptedAt.value : this.interruptedAt,
        onDeviceInterruptedAt: onDeviceInterruptedAt.present
            ? onDeviceInterruptedAt.value
            : this.onDeviceInterruptedAt,
        interruptPointUploadedAt: interruptPointUploadedAt.present
            ? interruptPointUploadedAt.value
            : this.interruptPointUploadedAt,
        finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
        onDeviceFinishedAt: onDeviceFinishedAt.present
            ? onDeviceFinishedAt.value
            : this.onDeviceFinishedAt,
        finishedUploadedAt: finishedUploadedAt.present
            ? finishedUploadedAt.value
            : this.finishedUploadedAt,
        violationsUploadedAt: violationsUploadedAt.present
            ? violationsUploadedAt.value
            : this.violationsUploadedAt,
        commentsUploadedAt: commentsUploadedAt.present
            ? commentsUploadedAt.value
            : this.commentsUploadedAt,
        deletingMediaUploadedAt: deletingMediaUploadedAt.present
            ? deletingMediaUploadedAt.value
            : this.deletingMediaUploadedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Review(')
          ..write('uuid: $uuid, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('articleId: $articleId, ')
          ..write('remoteArticleId: $remoteArticleId, ')
          ..write('templateId: $templateId, ')
          ..write('remoteTemplateId: $remoteTemplateId, ')
          ..write('remoteTaskId: $remoteTaskId, ')
          ..write('offline: $offline, ')
          ..write('startedAt: $startedAt, ')
          ..write('onDeviceStartedAt: $onDeviceStartedAt, ')
          ..write('startPointUploadedAt: $startPointUploadedAt, ')
          ..write('interruptedAt: $interruptedAt, ')
          ..write('onDeviceInterruptedAt: $onDeviceInterruptedAt, ')
          ..write('interruptPointUploadedAt: $interruptPointUploadedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('onDeviceFinishedAt: $onDeviceFinishedAt, ')
          ..write('finishedUploadedAt: $finishedUploadedAt, ')
          ..write('violationsUploadedAt: $violationsUploadedAt, ')
          ..write('commentsUploadedAt: $commentsUploadedAt, ')
          ..write('deletingMediaUploadedAt: $deletingMediaUploadedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uuid,
      companyUuid,
      articleId,
      remoteArticleId,
      templateId,
      remoteTemplateId,
      remoteTaskId,
      offline,
      startedAt,
      onDeviceStartedAt,
      startPointUploadedAt,
      interruptedAt,
      onDeviceInterruptedAt,
      interruptPointUploadedAt,
      finishedAt,
      onDeviceFinishedAt,
      finishedUploadedAt,
      violationsUploadedAt,
      commentsUploadedAt,
      deletingMediaUploadedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Review &&
          other.uuid == this.uuid &&
          other.companyUuid == this.companyUuid &&
          other.articleId == this.articleId &&
          other.remoteArticleId == this.remoteArticleId &&
          other.templateId == this.templateId &&
          other.remoteTemplateId == this.remoteTemplateId &&
          other.remoteTaskId == this.remoteTaskId &&
          other.offline == this.offline &&
          other.startedAt == this.startedAt &&
          other.onDeviceStartedAt == this.onDeviceStartedAt &&
          other.startPointUploadedAt == this.startPointUploadedAt &&
          other.interruptedAt == this.interruptedAt &&
          other.onDeviceInterruptedAt == this.onDeviceInterruptedAt &&
          other.interruptPointUploadedAt == this.interruptPointUploadedAt &&
          other.finishedAt == this.finishedAt &&
          other.onDeviceFinishedAt == this.onDeviceFinishedAt &&
          other.finishedUploadedAt == this.finishedUploadedAt &&
          other.violationsUploadedAt == this.violationsUploadedAt &&
          other.commentsUploadedAt == this.commentsUploadedAt &&
          other.deletingMediaUploadedAt == this.deletingMediaUploadedAt);
}

class ReviewsCompanion extends UpdateCompanion<Review> {
  final Value<String> uuid;
  final Value<String> companyUuid;
  final Value<int?> articleId;
  final Value<int> remoteArticleId;
  final Value<int> templateId;
  final Value<int> remoteTemplateId;
  final Value<int?> remoteTaskId;
  final Value<bool> offline;
  final Value<DateTime> startedAt;
  final Value<DateTime> onDeviceStartedAt;
  final Value<DateTime?> startPointUploadedAt;
  final Value<DateTime?> interruptedAt;
  final Value<DateTime?> onDeviceInterruptedAt;
  final Value<DateTime?> interruptPointUploadedAt;
  final Value<DateTime?> finishedAt;
  final Value<DateTime?> onDeviceFinishedAt;
  final Value<DateTime?> finishedUploadedAt;
  final Value<DateTime?> violationsUploadedAt;
  final Value<DateTime?> commentsUploadedAt;
  final Value<DateTime?> deletingMediaUploadedAt;
  const ReviewsCompanion({
    this.uuid = const Value.absent(),
    this.companyUuid = const Value.absent(),
    this.articleId = const Value.absent(),
    this.remoteArticleId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.remoteTemplateId = const Value.absent(),
    this.remoteTaskId = const Value.absent(),
    this.offline = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.onDeviceStartedAt = const Value.absent(),
    this.startPointUploadedAt = const Value.absent(),
    this.interruptedAt = const Value.absent(),
    this.onDeviceInterruptedAt = const Value.absent(),
    this.interruptPointUploadedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.onDeviceFinishedAt = const Value.absent(),
    this.finishedUploadedAt = const Value.absent(),
    this.violationsUploadedAt = const Value.absent(),
    this.commentsUploadedAt = const Value.absent(),
    this.deletingMediaUploadedAt = const Value.absent(),
  });
  ReviewsCompanion.insert({
    required String uuid,
    required String companyUuid,
    this.articleId = const Value.absent(),
    required int remoteArticleId,
    required int templateId,
    required int remoteTemplateId,
    this.remoteTaskId = const Value.absent(),
    required bool offline,
    required DateTime startedAt,
    required DateTime onDeviceStartedAt,
    this.startPointUploadedAt = const Value.absent(),
    this.interruptedAt = const Value.absent(),
    this.onDeviceInterruptedAt = const Value.absent(),
    this.interruptPointUploadedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.onDeviceFinishedAt = const Value.absent(),
    this.finishedUploadedAt = const Value.absent(),
    this.violationsUploadedAt = const Value.absent(),
    this.commentsUploadedAt = const Value.absent(),
    this.deletingMediaUploadedAt = const Value.absent(),
  })  : uuid = Value(uuid),
        companyUuid = Value(companyUuid),
        remoteArticleId = Value(remoteArticleId),
        templateId = Value(templateId),
        remoteTemplateId = Value(remoteTemplateId),
        offline = Value(offline),
        startedAt = Value(startedAt),
        onDeviceStartedAt = Value(onDeviceStartedAt);
  static Insertable<Review> custom({
    Expression<String>? uuid,
    Expression<String>? companyUuid,
    Expression<int>? articleId,
    Expression<int>? remoteArticleId,
    Expression<int>? templateId,
    Expression<int>? remoteTemplateId,
    Expression<int>? remoteTaskId,
    Expression<bool>? offline,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? onDeviceStartedAt,
    Expression<DateTime>? startPointUploadedAt,
    Expression<DateTime>? interruptedAt,
    Expression<DateTime>? onDeviceInterruptedAt,
    Expression<DateTime>? interruptPointUploadedAt,
    Expression<DateTime>? finishedAt,
    Expression<DateTime>? onDeviceFinishedAt,
    Expression<DateTime>? finishedUploadedAt,
    Expression<DateTime>? violationsUploadedAt,
    Expression<DateTime>? commentsUploadedAt,
    Expression<DateTime>? deletingMediaUploadedAt,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (articleId != null) 'article_id': articleId,
      if (remoteArticleId != null) 'remote_article_id': remoteArticleId,
      if (templateId != null) 'template_id': templateId,
      if (remoteTemplateId != null) 'remote_template_id': remoteTemplateId,
      if (remoteTaskId != null) 'remote_task_id': remoteTaskId,
      if (offline != null) 'offline': offline,
      if (startedAt != null) 'started_at': startedAt,
      if (onDeviceStartedAt != null) 'on_device_started_at': onDeviceStartedAt,
      if (startPointUploadedAt != null)
        'start_point_uploaded_at': startPointUploadedAt,
      if (interruptedAt != null) 'interrupted_at': interruptedAt,
      if (onDeviceInterruptedAt != null)
        'on_device_interrupted_at': onDeviceInterruptedAt,
      if (interruptPointUploadedAt != null)
        'interrupt_point_uploaded_at': interruptPointUploadedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (onDeviceFinishedAt != null)
        'on_device_finished_at': onDeviceFinishedAt,
      if (finishedUploadedAt != null)
        'finished_uploaded_at': finishedUploadedAt,
      if (violationsUploadedAt != null)
        'violations_uploaded_at': violationsUploadedAt,
      if (commentsUploadedAt != null)
        'comments_uploaded_at': commentsUploadedAt,
      if (deletingMediaUploadedAt != null)
        'deleting_media_uploaded_at': deletingMediaUploadedAt,
    });
  }

  ReviewsCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? companyUuid,
      Value<int?>? articleId,
      Value<int>? remoteArticleId,
      Value<int>? templateId,
      Value<int>? remoteTemplateId,
      Value<int?>? remoteTaskId,
      Value<bool>? offline,
      Value<DateTime>? startedAt,
      Value<DateTime>? onDeviceStartedAt,
      Value<DateTime?>? startPointUploadedAt,
      Value<DateTime?>? interruptedAt,
      Value<DateTime?>? onDeviceInterruptedAt,
      Value<DateTime?>? interruptPointUploadedAt,
      Value<DateTime?>? finishedAt,
      Value<DateTime?>? onDeviceFinishedAt,
      Value<DateTime?>? finishedUploadedAt,
      Value<DateTime?>? violationsUploadedAt,
      Value<DateTime?>? commentsUploadedAt,
      Value<DateTime?>? deletingMediaUploadedAt}) {
    return ReviewsCompanion(
      uuid: uuid ?? this.uuid,
      companyUuid: companyUuid ?? this.companyUuid,
      articleId: articleId ?? this.articleId,
      remoteArticleId: remoteArticleId ?? this.remoteArticleId,
      templateId: templateId ?? this.templateId,
      remoteTemplateId: remoteTemplateId ?? this.remoteTemplateId,
      remoteTaskId: remoteTaskId ?? this.remoteTaskId,
      offline: offline ?? this.offline,
      startedAt: startedAt ?? this.startedAt,
      onDeviceStartedAt: onDeviceStartedAt ?? this.onDeviceStartedAt,
      startPointUploadedAt: startPointUploadedAt ?? this.startPointUploadedAt,
      interruptedAt: interruptedAt ?? this.interruptedAt,
      onDeviceInterruptedAt:
          onDeviceInterruptedAt ?? this.onDeviceInterruptedAt,
      interruptPointUploadedAt:
          interruptPointUploadedAt ?? this.interruptPointUploadedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      onDeviceFinishedAt: onDeviceFinishedAt ?? this.onDeviceFinishedAt,
      finishedUploadedAt: finishedUploadedAt ?? this.finishedUploadedAt,
      violationsUploadedAt: violationsUploadedAt ?? this.violationsUploadedAt,
      commentsUploadedAt: commentsUploadedAt ?? this.commentsUploadedAt,
      deletingMediaUploadedAt:
          deletingMediaUploadedAt ?? this.deletingMediaUploadedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (articleId.present) {
      map['article_id'] = Variable<int>(articleId.value);
    }
    if (remoteArticleId.present) {
      map['remote_article_id'] = Variable<int>(remoteArticleId.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (remoteTemplateId.present) {
      map['remote_template_id'] = Variable<int>(remoteTemplateId.value);
    }
    if (remoteTaskId.present) {
      map['remote_task_id'] = Variable<int>(remoteTaskId.value);
    }
    if (offline.present) {
      map['offline'] = Variable<bool>(offline.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (onDeviceStartedAt.present) {
      map['on_device_started_at'] = Variable<DateTime>(onDeviceStartedAt.value);
    }
    if (startPointUploadedAt.present) {
      map['start_point_uploaded_at'] =
          Variable<DateTime>(startPointUploadedAt.value);
    }
    if (interruptedAt.present) {
      map['interrupted_at'] = Variable<DateTime>(interruptedAt.value);
    }
    if (onDeviceInterruptedAt.present) {
      map['on_device_interrupted_at'] =
          Variable<DateTime>(onDeviceInterruptedAt.value);
    }
    if (interruptPointUploadedAt.present) {
      map['interrupt_point_uploaded_at'] =
          Variable<DateTime>(interruptPointUploadedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (onDeviceFinishedAt.present) {
      map['on_device_finished_at'] =
          Variable<DateTime>(onDeviceFinishedAt.value);
    }
    if (finishedUploadedAt.present) {
      map['finished_uploaded_at'] =
          Variable<DateTime>(finishedUploadedAt.value);
    }
    if (violationsUploadedAt.present) {
      map['violations_uploaded_at'] =
          Variable<DateTime>(violationsUploadedAt.value);
    }
    if (commentsUploadedAt.present) {
      map['comments_uploaded_at'] =
          Variable<DateTime>(commentsUploadedAt.value);
    }
    if (deletingMediaUploadedAt.present) {
      map['deleting_media_uploaded_at'] =
          Variable<DateTime>(deletingMediaUploadedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('articleId: $articleId, ')
          ..write('remoteArticleId: $remoteArticleId, ')
          ..write('templateId: $templateId, ')
          ..write('remoteTemplateId: $remoteTemplateId, ')
          ..write('remoteTaskId: $remoteTaskId, ')
          ..write('offline: $offline, ')
          ..write('startedAt: $startedAt, ')
          ..write('onDeviceStartedAt: $onDeviceStartedAt, ')
          ..write('startPointUploadedAt: $startPointUploadedAt, ')
          ..write('interruptedAt: $interruptedAt, ')
          ..write('onDeviceInterruptedAt: $onDeviceInterruptedAt, ')
          ..write('interruptPointUploadedAt: $interruptPointUploadedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('onDeviceFinishedAt: $onDeviceFinishedAt, ')
          ..write('finishedUploadedAt: $finishedUploadedAt, ')
          ..write('violationsUploadedAt: $violationsUploadedAt, ')
          ..write('commentsUploadedAt: $commentsUploadedAt, ')
          ..write('deletingMediaUploadedAt: $deletingMediaUploadedAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewLocationsTable extends ReviewLocations
    with TableInfo<$ReviewLocationsTable, ReviewLocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewLocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewUuidMeta =
      const VerificationMeta('reviewUuid');
  @override
  late final GeneratedColumn<String> reviewUuid = GeneratedColumn<String>(
      'review_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _accuracyMeta =
      const VerificationMeta('accuracy');
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
      'accuracy', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _mockedMeta = const VerificationMeta('mocked');
  @override
  late final GeneratedColumn<bool> mocked =
      GeneratedColumn<bool>('mocked', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("mocked" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _onDeviceCreatedAtMeta =
      const VerificationMeta('onDeviceCreatedAt');
  @override
  late final GeneratedColumn<DateTime> onDeviceCreatedAt =
      GeneratedColumn<DateTime>('on_device_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _gpsCreatedAtMeta =
      const VerificationMeta('gpsCreatedAt');
  @override
  late final GeneratedColumn<DateTime> gpsCreatedAt = GeneratedColumn<DateTime>(
      'gps_created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _uploadedAtMeta =
      const VerificationMeta('uploadedAt');
  @override
  late final GeneratedColumn<DateTime> uploadedAt = GeneratedColumn<DateTime>(
      'uploaded_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uuid,
        reviewUuid,
        latitude,
        longitude,
        accuracy,
        mocked,
        createdAt,
        onDeviceCreatedAt,
        gpsCreatedAt,
        uploadedAt
      ];
  @override
  String get aliasedName => _alias ?? 'review_locations';
  @override
  String get actualTableName => 'review_locations';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewLocation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('review_uuid')) {
      context.handle(
          _reviewUuidMeta,
          reviewUuid.isAcceptableOrUnknown(
              data['review_uuid']!, _reviewUuidMeta));
    } else if (isInserting) {
      context.missing(_reviewUuidMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('accuracy')) {
      context.handle(_accuracyMeta,
          accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta));
    } else if (isInserting) {
      context.missing(_accuracyMeta);
    }
    if (data.containsKey('mocked')) {
      context.handle(_mockedMeta,
          mocked.isAcceptableOrUnknown(data['mocked']!, _mockedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('on_device_created_at')) {
      context.handle(
          _onDeviceCreatedAtMeta,
          onDeviceCreatedAt.isAcceptableOrUnknown(
              data['on_device_created_at']!, _onDeviceCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_onDeviceCreatedAtMeta);
    }
    if (data.containsKey('gps_created_at')) {
      context.handle(
          _gpsCreatedAtMeta,
          gpsCreatedAt.isAcceptableOrUnknown(
              data['gps_created_at']!, _gpsCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_gpsCreatedAtMeta);
    }
    if (data.containsKey('uploaded_at')) {
      context.handle(
          _uploadedAtMeta,
          uploadedAt.isAcceptableOrUnknown(
              data['uploaded_at']!, _uploadedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ReviewLocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewLocation(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      reviewUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_uuid'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      accuracy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}accuracy'])!,
      mocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}mocked']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      onDeviceCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}on_device_created_at'])!,
      gpsCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}gps_created_at'])!,
      uploadedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}uploaded_at']),
    );
  }

  @override
  $ReviewLocationsTable createAlias(String alias) {
    return $ReviewLocationsTable(attachedDatabase, alias);
  }
}

class ReviewLocation extends DataClass implements Insertable<ReviewLocation> {
  final String uuid;
  final String reviewUuid;
  final double latitude;
  final double longitude;
  final double accuracy;
  final bool? mocked;
  final DateTime createdAt;
  final DateTime onDeviceCreatedAt;
  final DateTime gpsCreatedAt;
  final DateTime? uploadedAt;
  const ReviewLocation(
      {required this.uuid,
      required this.reviewUuid,
      required this.latitude,
      required this.longitude,
      required this.accuracy,
      this.mocked,
      required this.createdAt,
      required this.onDeviceCreatedAt,
      required this.gpsCreatedAt,
      this.uploadedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['review_uuid'] = Variable<String>(reviewUuid);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['accuracy'] = Variable<double>(accuracy);
    if (!nullToAbsent || mocked != null) {
      map['mocked'] = Variable<bool>(mocked);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['on_device_created_at'] = Variable<DateTime>(onDeviceCreatedAt);
    map['gps_created_at'] = Variable<DateTime>(gpsCreatedAt);
    if (!nullToAbsent || uploadedAt != null) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt);
    }
    return map;
  }

  ReviewLocationsCompanion toCompanion(bool nullToAbsent) {
    return ReviewLocationsCompanion(
      uuid: Value(uuid),
      reviewUuid: Value(reviewUuid),
      latitude: Value(latitude),
      longitude: Value(longitude),
      accuracy: Value(accuracy),
      mocked:
          mocked == null && nullToAbsent ? const Value.absent() : Value(mocked),
      createdAt: Value(createdAt),
      onDeviceCreatedAt: Value(onDeviceCreatedAt),
      gpsCreatedAt: Value(gpsCreatedAt),
      uploadedAt: uploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadedAt),
    );
  }

  factory ReviewLocation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewLocation(
      uuid: serializer.fromJson<String>(json['uuid']),
      reviewUuid: serializer.fromJson<String>(json['reviewUuid']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      accuracy: serializer.fromJson<double>(json['accuracy']),
      mocked: serializer.fromJson<bool?>(json['mocked']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      onDeviceCreatedAt:
          serializer.fromJson<DateTime>(json['onDeviceCreatedAt']),
      gpsCreatedAt: serializer.fromJson<DateTime>(json['gpsCreatedAt']),
      uploadedAt: serializer.fromJson<DateTime?>(json['uploadedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'reviewUuid': serializer.toJson<String>(reviewUuid),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'accuracy': serializer.toJson<double>(accuracy),
      'mocked': serializer.toJson<bool?>(mocked),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'onDeviceCreatedAt': serializer.toJson<DateTime>(onDeviceCreatedAt),
      'gpsCreatedAt': serializer.toJson<DateTime>(gpsCreatedAt),
      'uploadedAt': serializer.toJson<DateTime?>(uploadedAt),
    };
  }

  ReviewLocation copyWith(
          {String? uuid,
          String? reviewUuid,
          double? latitude,
          double? longitude,
          double? accuracy,
          Value<bool?> mocked = const Value.absent(),
          DateTime? createdAt,
          DateTime? onDeviceCreatedAt,
          DateTime? gpsCreatedAt,
          Value<DateTime?> uploadedAt = const Value.absent()}) =>
      ReviewLocation(
        uuid: uuid ?? this.uuid,
        reviewUuid: reviewUuid ?? this.reviewUuid,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        accuracy: accuracy ?? this.accuracy,
        mocked: mocked.present ? mocked.value : this.mocked,
        createdAt: createdAt ?? this.createdAt,
        onDeviceCreatedAt: onDeviceCreatedAt ?? this.onDeviceCreatedAt,
        gpsCreatedAt: gpsCreatedAt ?? this.gpsCreatedAt,
        uploadedAt: uploadedAt.present ? uploadedAt.value : this.uploadedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ReviewLocation(')
          ..write('uuid: $uuid, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('mocked: $mocked, ')
          ..write('createdAt: $createdAt, ')
          ..write('onDeviceCreatedAt: $onDeviceCreatedAt, ')
          ..write('gpsCreatedAt: $gpsCreatedAt, ')
          ..write('uploadedAt: $uploadedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, reviewUuid, latitude, longitude,
      accuracy, mocked, createdAt, onDeviceCreatedAt, gpsCreatedAt, uploadedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewLocation &&
          other.uuid == this.uuid &&
          other.reviewUuid == this.reviewUuid &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracy == this.accuracy &&
          other.mocked == this.mocked &&
          other.createdAt == this.createdAt &&
          other.onDeviceCreatedAt == this.onDeviceCreatedAt &&
          other.gpsCreatedAt == this.gpsCreatedAt &&
          other.uploadedAt == this.uploadedAt);
}

class ReviewLocationsCompanion extends UpdateCompanion<ReviewLocation> {
  final Value<String> uuid;
  final Value<String> reviewUuid;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> accuracy;
  final Value<bool?> mocked;
  final Value<DateTime> createdAt;
  final Value<DateTime> onDeviceCreatedAt;
  final Value<DateTime> gpsCreatedAt;
  final Value<DateTime?> uploadedAt;
  const ReviewLocationsCompanion({
    this.uuid = const Value.absent(),
    this.reviewUuid = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.mocked = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.onDeviceCreatedAt = const Value.absent(),
    this.gpsCreatedAt = const Value.absent(),
    this.uploadedAt = const Value.absent(),
  });
  ReviewLocationsCompanion.insert({
    required String uuid,
    required String reviewUuid,
    required double latitude,
    required double longitude,
    required double accuracy,
    this.mocked = const Value.absent(),
    required DateTime createdAt,
    required DateTime onDeviceCreatedAt,
    required DateTime gpsCreatedAt,
    this.uploadedAt = const Value.absent(),
  })  : uuid = Value(uuid),
        reviewUuid = Value(reviewUuid),
        latitude = Value(latitude),
        longitude = Value(longitude),
        accuracy = Value(accuracy),
        createdAt = Value(createdAt),
        onDeviceCreatedAt = Value(onDeviceCreatedAt),
        gpsCreatedAt = Value(gpsCreatedAt);
  static Insertable<ReviewLocation> custom({
    Expression<String>? uuid,
    Expression<String>? reviewUuid,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracy,
    Expression<bool>? mocked,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? onDeviceCreatedAt,
    Expression<DateTime>? gpsCreatedAt,
    Expression<DateTime>? uploadedAt,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (reviewUuid != null) 'review_uuid': reviewUuid,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (mocked != null) 'mocked': mocked,
      if (createdAt != null) 'created_at': createdAt,
      if (onDeviceCreatedAt != null) 'on_device_created_at': onDeviceCreatedAt,
      if (gpsCreatedAt != null) 'gps_created_at': gpsCreatedAt,
      if (uploadedAt != null) 'uploaded_at': uploadedAt,
    });
  }

  ReviewLocationsCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? reviewUuid,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<double>? accuracy,
      Value<bool?>? mocked,
      Value<DateTime>? createdAt,
      Value<DateTime>? onDeviceCreatedAt,
      Value<DateTime>? gpsCreatedAt,
      Value<DateTime?>? uploadedAt}) {
    return ReviewLocationsCompanion(
      uuid: uuid ?? this.uuid,
      reviewUuid: reviewUuid ?? this.reviewUuid,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      mocked: mocked ?? this.mocked,
      createdAt: createdAt ?? this.createdAt,
      onDeviceCreatedAt: onDeviceCreatedAt ?? this.onDeviceCreatedAt,
      gpsCreatedAt: gpsCreatedAt ?? this.gpsCreatedAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (reviewUuid.present) {
      map['review_uuid'] = Variable<String>(reviewUuid.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (mocked.present) {
      map['mocked'] = Variable<bool>(mocked.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (onDeviceCreatedAt.present) {
      map['on_device_created_at'] = Variable<DateTime>(onDeviceCreatedAt.value);
    }
    if (gpsCreatedAt.present) {
      map['gps_created_at'] = Variable<DateTime>(gpsCreatedAt.value);
    }
    if (uploadedAt.present) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewLocationsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('mocked: $mocked, ')
          ..write('createdAt: $createdAt, ')
          ..write('onDeviceCreatedAt: $onDeviceCreatedAt, ')
          ..write('gpsCreatedAt: $gpsCreatedAt, ')
          ..write('uploadedAt: $uploadedAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewStepFilesTable extends ReviewStepFiles
    with TableInfo<$ReviewStepFilesTable, ReviewStepFile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewStepFilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewUuidMeta =
      const VerificationMeta('reviewUuid');
  @override
  late final GeneratedColumn<String> reviewUuid = GeneratedColumn<String>(
      'review_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stepIdMeta = const VerificationMeta('stepId');
  @override
  late final GeneratedColumn<int> stepId = GeneratedColumn<int>(
      'step_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _compressedPathMeta =
      const VerificationMeta('compressedPath');
  @override
  late final GeneratedColumn<String> compressedPath = GeneratedColumn<String>(
      'compressed_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commentMeta =
      const VerificationMeta('comment');
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
      'comment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
      'hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _onDeviceCreatedAtMeta =
      const VerificationMeta('onDeviceCreatedAt');
  @override
  late final GeneratedColumn<DateTime> onDeviceCreatedAt =
      GeneratedColumn<DateTime>('on_device_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _uploadedAtMeta =
      const VerificationMeta('uploadedAt');
  @override
  late final GeneratedColumn<DateTime> uploadedAt = GeneratedColumn<DateTime>(
      'uploaded_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deletedByUserAtMeta =
      const VerificationMeta('deletedByUserAt');
  @override
  late final GeneratedColumn<DateTime> deletedByUserAt =
      GeneratedColumn<DateTime>('deleted_by_user_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuid,
        reviewUuid,
        stepId,
        type,
        path,
        compressedPath,
        comment,
        hash,
        createdAt,
        onDeviceCreatedAt,
        uploadedAt,
        deletedByUserAt
      ];
  @override
  String get aliasedName => _alias ?? 'review_step_files';
  @override
  String get actualTableName => 'review_step_files';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewStepFile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('review_uuid')) {
      context.handle(
          _reviewUuidMeta,
          reviewUuid.isAcceptableOrUnknown(
              data['review_uuid']!, _reviewUuidMeta));
    } else if (isInserting) {
      context.missing(_reviewUuidMeta);
    }
    if (data.containsKey('step_id')) {
      context.handle(_stepIdMeta,
          stepId.isAcceptableOrUnknown(data['step_id']!, _stepIdMeta));
    } else if (isInserting) {
      context.missing(_stepIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('compressed_path')) {
      context.handle(
          _compressedPathMeta,
          compressedPath.isAcceptableOrUnknown(
              data['compressed_path']!, _compressedPathMeta));
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment']!, _commentMeta));
    }
    if (data.containsKey('hash')) {
      context.handle(
          _hashMeta, hash.isAcceptableOrUnknown(data['hash']!, _hashMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('on_device_created_at')) {
      context.handle(
          _onDeviceCreatedAtMeta,
          onDeviceCreatedAt.isAcceptableOrUnknown(
              data['on_device_created_at']!, _onDeviceCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_onDeviceCreatedAtMeta);
    }
    if (data.containsKey('uploaded_at')) {
      context.handle(
          _uploadedAtMeta,
          uploadedAt.isAcceptableOrUnknown(
              data['uploaded_at']!, _uploadedAtMeta));
    }
    if (data.containsKey('deleted_by_user_at')) {
      context.handle(
          _deletedByUserAtMeta,
          deletedByUserAt.isAcceptableOrUnknown(
              data['deleted_by_user_at']!, _deletedByUserAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewStepFile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewStepFile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      reviewUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_uuid'])!,
      stepId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}step_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      compressedPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}compressed_path']),
      comment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment']),
      hash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hash']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      onDeviceCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}on_device_created_at'])!,
      uploadedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}uploaded_at']),
      deletedByUserAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}deleted_by_user_at']),
    );
  }

  @override
  $ReviewStepFilesTable createAlias(String alias) {
    return $ReviewStepFilesTable(attachedDatabase, alias);
  }
}

class ReviewStepFile extends DataClass implements Insertable<ReviewStepFile> {
  final int id;
  final String uuid;
  final String reviewUuid;
  final int stepId;
  final String type;
  final String? path;
  final String? compressedPath;
  final String? comment;
  final String? hash;
  final DateTime createdAt;
  final DateTime onDeviceCreatedAt;
  final DateTime? uploadedAt;
  final DateTime? deletedByUserAt;
  const ReviewStepFile(
      {required this.id,
      required this.uuid,
      required this.reviewUuid,
      required this.stepId,
      required this.type,
      this.path,
      this.compressedPath,
      this.comment,
      this.hash,
      required this.createdAt,
      required this.onDeviceCreatedAt,
      this.uploadedAt,
      this.deletedByUserAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['review_uuid'] = Variable<String>(reviewUuid);
    map['step_id'] = Variable<int>(stepId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    if (!nullToAbsent || compressedPath != null) {
      map['compressed_path'] = Variable<String>(compressedPath);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || hash != null) {
      map['hash'] = Variable<String>(hash);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['on_device_created_at'] = Variable<DateTime>(onDeviceCreatedAt);
    if (!nullToAbsent || uploadedAt != null) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt);
    }
    if (!nullToAbsent || deletedByUserAt != null) {
      map['deleted_by_user_at'] = Variable<DateTime>(deletedByUserAt);
    }
    return map;
  }

  ReviewStepFilesCompanion toCompanion(bool nullToAbsent) {
    return ReviewStepFilesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      reviewUuid: Value(reviewUuid),
      stepId: Value(stepId),
      type: Value(type),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      compressedPath: compressedPath == null && nullToAbsent
          ? const Value.absent()
          : Value(compressedPath),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      hash: hash == null && nullToAbsent ? const Value.absent() : Value(hash),
      createdAt: Value(createdAt),
      onDeviceCreatedAt: Value(onDeviceCreatedAt),
      uploadedAt: uploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadedAt),
      deletedByUserAt: deletedByUserAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedByUserAt),
    );
  }

  factory ReviewStepFile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewStepFile(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      reviewUuid: serializer.fromJson<String>(json['reviewUuid']),
      stepId: serializer.fromJson<int>(json['stepId']),
      type: serializer.fromJson<String>(json['type']),
      path: serializer.fromJson<String?>(json['path']),
      compressedPath: serializer.fromJson<String?>(json['compressedPath']),
      comment: serializer.fromJson<String?>(json['comment']),
      hash: serializer.fromJson<String?>(json['hash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      onDeviceCreatedAt:
          serializer.fromJson<DateTime>(json['onDeviceCreatedAt']),
      uploadedAt: serializer.fromJson<DateTime?>(json['uploadedAt']),
      deletedByUserAt: serializer.fromJson<DateTime?>(json['deletedByUserAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'reviewUuid': serializer.toJson<String>(reviewUuid),
      'stepId': serializer.toJson<int>(stepId),
      'type': serializer.toJson<String>(type),
      'path': serializer.toJson<String?>(path),
      'compressedPath': serializer.toJson<String?>(compressedPath),
      'comment': serializer.toJson<String?>(comment),
      'hash': serializer.toJson<String?>(hash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'onDeviceCreatedAt': serializer.toJson<DateTime>(onDeviceCreatedAt),
      'uploadedAt': serializer.toJson<DateTime?>(uploadedAt),
      'deletedByUserAt': serializer.toJson<DateTime?>(deletedByUserAt),
    };
  }

  ReviewStepFile copyWith(
          {int? id,
          String? uuid,
          String? reviewUuid,
          int? stepId,
          String? type,
          Value<String?> path = const Value.absent(),
          Value<String?> compressedPath = const Value.absent(),
          Value<String?> comment = const Value.absent(),
          Value<String?> hash = const Value.absent(),
          DateTime? createdAt,
          DateTime? onDeviceCreatedAt,
          Value<DateTime?> uploadedAt = const Value.absent(),
          Value<DateTime?> deletedByUserAt = const Value.absent()}) =>
      ReviewStepFile(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        reviewUuid: reviewUuid ?? this.reviewUuid,
        stepId: stepId ?? this.stepId,
        type: type ?? this.type,
        path: path.present ? path.value : this.path,
        compressedPath:
            compressedPath.present ? compressedPath.value : this.compressedPath,
        comment: comment.present ? comment.value : this.comment,
        hash: hash.present ? hash.value : this.hash,
        createdAt: createdAt ?? this.createdAt,
        onDeviceCreatedAt: onDeviceCreatedAt ?? this.onDeviceCreatedAt,
        uploadedAt: uploadedAt.present ? uploadedAt.value : this.uploadedAt,
        deletedByUserAt: deletedByUserAt.present
            ? deletedByUserAt.value
            : this.deletedByUserAt,
      );
  @override
  String toString() {
    return (StringBuffer('ReviewStepFile(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('stepId: $stepId, ')
          ..write('type: $type, ')
          ..write('path: $path, ')
          ..write('compressedPath: $compressedPath, ')
          ..write('comment: $comment, ')
          ..write('hash: $hash, ')
          ..write('createdAt: $createdAt, ')
          ..write('onDeviceCreatedAt: $onDeviceCreatedAt, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('deletedByUserAt: $deletedByUserAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuid,
      reviewUuid,
      stepId,
      type,
      path,
      compressedPath,
      comment,
      hash,
      createdAt,
      onDeviceCreatedAt,
      uploadedAt,
      deletedByUserAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewStepFile &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.reviewUuid == this.reviewUuid &&
          other.stepId == this.stepId &&
          other.type == this.type &&
          other.path == this.path &&
          other.compressedPath == this.compressedPath &&
          other.comment == this.comment &&
          other.hash == this.hash &&
          other.createdAt == this.createdAt &&
          other.onDeviceCreatedAt == this.onDeviceCreatedAt &&
          other.uploadedAt == this.uploadedAt &&
          other.deletedByUserAt == this.deletedByUserAt);
}

class ReviewStepFilesCompanion extends UpdateCompanion<ReviewStepFile> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> reviewUuid;
  final Value<int> stepId;
  final Value<String> type;
  final Value<String?> path;
  final Value<String?> compressedPath;
  final Value<String?> comment;
  final Value<String?> hash;
  final Value<DateTime> createdAt;
  final Value<DateTime> onDeviceCreatedAt;
  final Value<DateTime?> uploadedAt;
  final Value<DateTime?> deletedByUserAt;
  const ReviewStepFilesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.reviewUuid = const Value.absent(),
    this.stepId = const Value.absent(),
    this.type = const Value.absent(),
    this.path = const Value.absent(),
    this.compressedPath = const Value.absent(),
    this.comment = const Value.absent(),
    this.hash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.onDeviceCreatedAt = const Value.absent(),
    this.uploadedAt = const Value.absent(),
    this.deletedByUserAt = const Value.absent(),
  });
  ReviewStepFilesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String reviewUuid,
    required int stepId,
    required String type,
    this.path = const Value.absent(),
    this.compressedPath = const Value.absent(),
    this.comment = const Value.absent(),
    this.hash = const Value.absent(),
    required DateTime createdAt,
    required DateTime onDeviceCreatedAt,
    this.uploadedAt = const Value.absent(),
    this.deletedByUserAt = const Value.absent(),
  })  : uuid = Value(uuid),
        reviewUuid = Value(reviewUuid),
        stepId = Value(stepId),
        type = Value(type),
        createdAt = Value(createdAt),
        onDeviceCreatedAt = Value(onDeviceCreatedAt);
  static Insertable<ReviewStepFile> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? reviewUuid,
    Expression<int>? stepId,
    Expression<String>? type,
    Expression<String>? path,
    Expression<String>? compressedPath,
    Expression<String>? comment,
    Expression<String>? hash,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? onDeviceCreatedAt,
    Expression<DateTime>? uploadedAt,
    Expression<DateTime>? deletedByUserAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (reviewUuid != null) 'review_uuid': reviewUuid,
      if (stepId != null) 'step_id': stepId,
      if (type != null) 'type': type,
      if (path != null) 'path': path,
      if (compressedPath != null) 'compressed_path': compressedPath,
      if (comment != null) 'comment': comment,
      if (hash != null) 'hash': hash,
      if (createdAt != null) 'created_at': createdAt,
      if (onDeviceCreatedAt != null) 'on_device_created_at': onDeviceCreatedAt,
      if (uploadedAt != null) 'uploaded_at': uploadedAt,
      if (deletedByUserAt != null) 'deleted_by_user_at': deletedByUserAt,
    });
  }

  ReviewStepFilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? uuid,
      Value<String>? reviewUuid,
      Value<int>? stepId,
      Value<String>? type,
      Value<String?>? path,
      Value<String?>? compressedPath,
      Value<String?>? comment,
      Value<String?>? hash,
      Value<DateTime>? createdAt,
      Value<DateTime>? onDeviceCreatedAt,
      Value<DateTime?>? uploadedAt,
      Value<DateTime?>? deletedByUserAt}) {
    return ReviewStepFilesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      reviewUuid: reviewUuid ?? this.reviewUuid,
      stepId: stepId ?? this.stepId,
      type: type ?? this.type,
      path: path ?? this.path,
      compressedPath: compressedPath ?? this.compressedPath,
      comment: comment ?? this.comment,
      hash: hash ?? this.hash,
      createdAt: createdAt ?? this.createdAt,
      onDeviceCreatedAt: onDeviceCreatedAt ?? this.onDeviceCreatedAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      deletedByUserAt: deletedByUserAt ?? this.deletedByUserAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (reviewUuid.present) {
      map['review_uuid'] = Variable<String>(reviewUuid.value);
    }
    if (stepId.present) {
      map['step_id'] = Variable<int>(stepId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (compressedPath.present) {
      map['compressed_path'] = Variable<String>(compressedPath.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (onDeviceCreatedAt.present) {
      map['on_device_created_at'] = Variable<DateTime>(onDeviceCreatedAt.value);
    }
    if (uploadedAt.present) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt.value);
    }
    if (deletedByUserAt.present) {
      map['deleted_by_user_at'] = Variable<DateTime>(deletedByUserAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewStepFilesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('stepId: $stepId, ')
          ..write('type: $type, ')
          ..write('path: $path, ')
          ..write('compressedPath: $compressedPath, ')
          ..write('comment: $comment, ')
          ..write('hash: $hash, ')
          ..write('createdAt: $createdAt, ')
          ..write('onDeviceCreatedAt: $onDeviceCreatedAt, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('deletedByUserAt: $deletedByUserAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewStepViolationsTable extends ReviewStepViolations
    with TableInfo<$ReviewStepViolationsTable, ReviewStepViolation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewStepViolationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewUuidMeta =
      const VerificationMeta('reviewUuid');
  @override
  late final GeneratedColumn<String> reviewUuid = GeneratedColumn<String>(
      'review_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stepIdMeta = const VerificationMeta('stepId');
  @override
  late final GeneratedColumn<int> stepId = GeneratedColumn<int>(
      'step_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [companyUuid, reviewUuid, stepId];
  @override
  String get aliasedName => _alias ?? 'review_step_violations';
  @override
  String get actualTableName => 'review_step_violations';
  @override
  VerificationContext validateIntegrity(
      Insertable<ReviewStepViolation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('review_uuid')) {
      context.handle(
          _reviewUuidMeta,
          reviewUuid.isAcceptableOrUnknown(
              data['review_uuid']!, _reviewUuidMeta));
    } else if (isInserting) {
      context.missing(_reviewUuidMeta);
    }
    if (data.containsKey('step_id')) {
      context.handle(_stepIdMeta,
          stepId.isAcceptableOrUnknown(data['step_id']!, _stepIdMeta));
    } else if (isInserting) {
      context.missing(_stepIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {companyUuid, reviewUuid, stepId};
  @override
  ReviewStepViolation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewStepViolation(
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      reviewUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_uuid'])!,
      stepId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}step_id'])!,
    );
  }

  @override
  $ReviewStepViolationsTable createAlias(String alias) {
    return $ReviewStepViolationsTable(attachedDatabase, alias);
  }
}

class ReviewStepViolation extends DataClass
    implements Insertable<ReviewStepViolation> {
  final String companyUuid;
  final String reviewUuid;
  final int stepId;
  const ReviewStepViolation(
      {required this.companyUuid,
      required this.reviewUuid,
      required this.stepId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['company_uuid'] = Variable<String>(companyUuid);
    map['review_uuid'] = Variable<String>(reviewUuid);
    map['step_id'] = Variable<int>(stepId);
    return map;
  }

  ReviewStepViolationsCompanion toCompanion(bool nullToAbsent) {
    return ReviewStepViolationsCompanion(
      companyUuid: Value(companyUuid),
      reviewUuid: Value(reviewUuid),
      stepId: Value(stepId),
    );
  }

  factory ReviewStepViolation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewStepViolation(
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      reviewUuid: serializer.fromJson<String>(json['reviewUuid']),
      stepId: serializer.fromJson<int>(json['stepId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'companyUuid': serializer.toJson<String>(companyUuid),
      'reviewUuid': serializer.toJson<String>(reviewUuid),
      'stepId': serializer.toJson<int>(stepId),
    };
  }

  ReviewStepViolation copyWith(
          {String? companyUuid, String? reviewUuid, int? stepId}) =>
      ReviewStepViolation(
        companyUuid: companyUuid ?? this.companyUuid,
        reviewUuid: reviewUuid ?? this.reviewUuid,
        stepId: stepId ?? this.stepId,
      );
  @override
  String toString() {
    return (StringBuffer('ReviewStepViolation(')
          ..write('companyUuid: $companyUuid, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('stepId: $stepId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(companyUuid, reviewUuid, stepId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewStepViolation &&
          other.companyUuid == this.companyUuid &&
          other.reviewUuid == this.reviewUuid &&
          other.stepId == this.stepId);
}

class ReviewStepViolationsCompanion
    extends UpdateCompanion<ReviewStepViolation> {
  final Value<String> companyUuid;
  final Value<String> reviewUuid;
  final Value<int> stepId;
  const ReviewStepViolationsCompanion({
    this.companyUuid = const Value.absent(),
    this.reviewUuid = const Value.absent(),
    this.stepId = const Value.absent(),
  });
  ReviewStepViolationsCompanion.insert({
    required String companyUuid,
    required String reviewUuid,
    required int stepId,
  })  : companyUuid = Value(companyUuid),
        reviewUuid = Value(reviewUuid),
        stepId = Value(stepId);
  static Insertable<ReviewStepViolation> custom({
    Expression<String>? companyUuid,
    Expression<String>? reviewUuid,
    Expression<int>? stepId,
  }) {
    return RawValuesInsertable({
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (reviewUuid != null) 'review_uuid': reviewUuid,
      if (stepId != null) 'step_id': stepId,
    });
  }

  ReviewStepViolationsCompanion copyWith(
      {Value<String>? companyUuid,
      Value<String>? reviewUuid,
      Value<int>? stepId}) {
    return ReviewStepViolationsCompanion(
      companyUuid: companyUuid ?? this.companyUuid,
      reviewUuid: reviewUuid ?? this.reviewUuid,
      stepId: stepId ?? this.stepId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (reviewUuid.present) {
      map['review_uuid'] = Variable<String>(reviewUuid.value);
    }
    if (stepId.present) {
      map['step_id'] = Variable<int>(stepId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewStepViolationsCompanion(')
          ..write('companyUuid: $companyUuid, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('stepId: $stepId')
          ..write(')'))
        .toString();
  }
}

class $UploadsTable extends Uploads with TableInfo<$UploadsTable, Upload> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UploadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewUuidMeta =
      const VerificationMeta('reviewUuid');
  @override
  late final GeneratedColumn<String> reviewUuid = GeneratedColumn<String>(
      'review_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityActionMeta =
      const VerificationMeta('entityAction');
  @override
  late final GeneratedColumn<String> entityAction = GeneratedColumn<String>(
      'entity_action', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
      'progress', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _onDeviceCreatedAtMeta =
      const VerificationMeta('onDeviceCreatedAt');
  @override
  late final GeneratedColumn<DateTime> onDeviceCreatedAt =
      GeneratedColumn<DateTime>('on_device_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _uploadedAtMeta =
      const VerificationMeta('uploadedAt');
  @override
  late final GeneratedColumn<DateTime> uploadedAt = GeneratedColumn<DateTime>(
      'uploaded_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taskId,
        reviewUuid,
        entityType,
        entityAction,
        entityId,
        progress,
        status,
        createdAt,
        onDeviceCreatedAt,
        uploadedAt
      ];
  @override
  String get aliasedName => _alias ?? 'uploads';
  @override
  String get actualTableName => 'uploads';
  @override
  VerificationContext validateIntegrity(Insertable<Upload> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('review_uuid')) {
      context.handle(
          _reviewUuidMeta,
          reviewUuid.isAcceptableOrUnknown(
              data['review_uuid']!, _reviewUuidMeta));
    } else if (isInserting) {
      context.missing(_reviewUuidMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_action')) {
      context.handle(
          _entityActionMeta,
          entityAction.isAcceptableOrUnknown(
              data['entity_action']!, _entityActionMeta));
    } else if (isInserting) {
      context.missing(_entityActionMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('on_device_created_at')) {
      context.handle(
          _onDeviceCreatedAtMeta,
          onDeviceCreatedAt.isAcceptableOrUnknown(
              data['on_device_created_at']!, _onDeviceCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_onDeviceCreatedAtMeta);
    }
    if (data.containsKey('uploaded_at')) {
      context.handle(
          _uploadedAtMeta,
          uploadedAt.isAcceptableOrUnknown(
              data['uploaded_at']!, _uploadedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Upload map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Upload(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      reviewUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_uuid'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityAction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_action'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}progress'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      onDeviceCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}on_device_created_at'])!,
      uploadedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}uploaded_at']),
    );
  }

  @override
  $UploadsTable createAlias(String alias) {
    return $UploadsTable(attachedDatabase, alias);
  }
}

class Upload extends DataClass implements Insertable<Upload> {
  final int id;
  final String taskId;
  final String reviewUuid;
  final String entityType;
  final String entityAction;
  final String entityId;
  final int progress;
  final int status;
  final DateTime createdAt;
  final DateTime onDeviceCreatedAt;
  final DateTime? uploadedAt;
  const Upload(
      {required this.id,
      required this.taskId,
      required this.reviewUuid,
      required this.entityType,
      required this.entityAction,
      required this.entityId,
      required this.progress,
      required this.status,
      required this.createdAt,
      required this.onDeviceCreatedAt,
      this.uploadedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_id'] = Variable<String>(taskId);
    map['review_uuid'] = Variable<String>(reviewUuid);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_action'] = Variable<String>(entityAction);
    map['entity_id'] = Variable<String>(entityId);
    map['progress'] = Variable<int>(progress);
    map['status'] = Variable<int>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['on_device_created_at'] = Variable<DateTime>(onDeviceCreatedAt);
    if (!nullToAbsent || uploadedAt != null) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt);
    }
    return map;
  }

  UploadsCompanion toCompanion(bool nullToAbsent) {
    return UploadsCompanion(
      id: Value(id),
      taskId: Value(taskId),
      reviewUuid: Value(reviewUuid),
      entityType: Value(entityType),
      entityAction: Value(entityAction),
      entityId: Value(entityId),
      progress: Value(progress),
      status: Value(status),
      createdAt: Value(createdAt),
      onDeviceCreatedAt: Value(onDeviceCreatedAt),
      uploadedAt: uploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadedAt),
    );
  }

  factory Upload.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Upload(
      id: serializer.fromJson<int>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      reviewUuid: serializer.fromJson<String>(json['reviewUuid']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityAction: serializer.fromJson<String>(json['entityAction']),
      entityId: serializer.fromJson<String>(json['entityId']),
      progress: serializer.fromJson<int>(json['progress']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      onDeviceCreatedAt:
          serializer.fromJson<DateTime>(json['onDeviceCreatedAt']),
      uploadedAt: serializer.fromJson<DateTime?>(json['uploadedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskId': serializer.toJson<String>(taskId),
      'reviewUuid': serializer.toJson<String>(reviewUuid),
      'entityType': serializer.toJson<String>(entityType),
      'entityAction': serializer.toJson<String>(entityAction),
      'entityId': serializer.toJson<String>(entityId),
      'progress': serializer.toJson<int>(progress),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'onDeviceCreatedAt': serializer.toJson<DateTime>(onDeviceCreatedAt),
      'uploadedAt': serializer.toJson<DateTime?>(uploadedAt),
    };
  }

  Upload copyWith(
          {int? id,
          String? taskId,
          String? reviewUuid,
          String? entityType,
          String? entityAction,
          String? entityId,
          int? progress,
          int? status,
          DateTime? createdAt,
          DateTime? onDeviceCreatedAt,
          Value<DateTime?> uploadedAt = const Value.absent()}) =>
      Upload(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        reviewUuid: reviewUuid ?? this.reviewUuid,
        entityType: entityType ?? this.entityType,
        entityAction: entityAction ?? this.entityAction,
        entityId: entityId ?? this.entityId,
        progress: progress ?? this.progress,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        onDeviceCreatedAt: onDeviceCreatedAt ?? this.onDeviceCreatedAt,
        uploadedAt: uploadedAt.present ? uploadedAt.value : this.uploadedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Upload(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('entityType: $entityType, ')
          ..write('entityAction: $entityAction, ')
          ..write('entityId: $entityId, ')
          ..write('progress: $progress, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('onDeviceCreatedAt: $onDeviceCreatedAt, ')
          ..write('uploadedAt: $uploadedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      taskId,
      reviewUuid,
      entityType,
      entityAction,
      entityId,
      progress,
      status,
      createdAt,
      onDeviceCreatedAt,
      uploadedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Upload &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.reviewUuid == this.reviewUuid &&
          other.entityType == this.entityType &&
          other.entityAction == this.entityAction &&
          other.entityId == this.entityId &&
          other.progress == this.progress &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.onDeviceCreatedAt == this.onDeviceCreatedAt &&
          other.uploadedAt == this.uploadedAt);
}

class UploadsCompanion extends UpdateCompanion<Upload> {
  final Value<int> id;
  final Value<String> taskId;
  final Value<String> reviewUuid;
  final Value<String> entityType;
  final Value<String> entityAction;
  final Value<String> entityId;
  final Value<int> progress;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> onDeviceCreatedAt;
  final Value<DateTime?> uploadedAt;
  const UploadsCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.reviewUuid = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityAction = const Value.absent(),
    this.entityId = const Value.absent(),
    this.progress = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.onDeviceCreatedAt = const Value.absent(),
    this.uploadedAt = const Value.absent(),
  });
  UploadsCompanion.insert({
    this.id = const Value.absent(),
    required String taskId,
    required String reviewUuid,
    required String entityType,
    required String entityAction,
    required String entityId,
    required int progress,
    required int status,
    required DateTime createdAt,
    required DateTime onDeviceCreatedAt,
    this.uploadedAt = const Value.absent(),
  })  : taskId = Value(taskId),
        reviewUuid = Value(reviewUuid),
        entityType = Value(entityType),
        entityAction = Value(entityAction),
        entityId = Value(entityId),
        progress = Value(progress),
        status = Value(status),
        createdAt = Value(createdAt),
        onDeviceCreatedAt = Value(onDeviceCreatedAt);
  static Insertable<Upload> custom({
    Expression<int>? id,
    Expression<String>? taskId,
    Expression<String>? reviewUuid,
    Expression<String>? entityType,
    Expression<String>? entityAction,
    Expression<String>? entityId,
    Expression<int>? progress,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? onDeviceCreatedAt,
    Expression<DateTime>? uploadedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (reviewUuid != null) 'review_uuid': reviewUuid,
      if (entityType != null) 'entity_type': entityType,
      if (entityAction != null) 'entity_action': entityAction,
      if (entityId != null) 'entity_id': entityId,
      if (progress != null) 'progress': progress,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (onDeviceCreatedAt != null) 'on_device_created_at': onDeviceCreatedAt,
      if (uploadedAt != null) 'uploaded_at': uploadedAt,
    });
  }

  UploadsCompanion copyWith(
      {Value<int>? id,
      Value<String>? taskId,
      Value<String>? reviewUuid,
      Value<String>? entityType,
      Value<String>? entityAction,
      Value<String>? entityId,
      Value<int>? progress,
      Value<int>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? onDeviceCreatedAt,
      Value<DateTime?>? uploadedAt}) {
    return UploadsCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      reviewUuid: reviewUuid ?? this.reviewUuid,
      entityType: entityType ?? this.entityType,
      entityAction: entityAction ?? this.entityAction,
      entityId: entityId ?? this.entityId,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      onDeviceCreatedAt: onDeviceCreatedAt ?? this.onDeviceCreatedAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (reviewUuid.present) {
      map['review_uuid'] = Variable<String>(reviewUuid.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityAction.present) {
      map['entity_action'] = Variable<String>(entityAction.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (onDeviceCreatedAt.present) {
      map['on_device_created_at'] = Variable<DateTime>(onDeviceCreatedAt.value);
    }
    if (uploadedAt.present) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UploadsCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('reviewUuid: $reviewUuid, ')
          ..write('entityType: $entityType, ')
          ..write('entityAction: $entityAction, ')
          ..write('entityId: $entityId, ')
          ..write('progress: $progress, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('onDeviceCreatedAt: $onDeviceCreatedAt, ')
          ..write('uploadedAt: $uploadedAt')
          ..write(')'))
        .toString();
  }
}

class $HelpQuestionsTable extends HelpQuestions
    with TableInfo<$HelpQuestionsTable, HelpQuestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HelpQuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _companyUuidMeta =
      const VerificationMeta('companyUuid');
  @override
  late final GeneratedColumn<String> companyUuid = GeneratedColumn<String>(
      'company_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (remote_uuid) ON DELETE CASCADE'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, remoteId, companyUuid, title, description, weight];
  @override
  String get aliasedName => _alias ?? 'help_questions';
  @override
  String get actualTableName => 'help_questions';
  @override
  VerificationContext validateIntegrity(Insertable<HelpQuestion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('company_uuid')) {
      context.handle(
          _companyUuidMeta,
          companyUuid.isAcceptableOrUnknown(
              data['company_uuid']!, _companyUuidMeta));
    } else if (isInserting) {
      context.missing(_companyUuidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HelpQuestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HelpQuestion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id'])!,
      companyUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_uuid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
    );
  }

  @override
  $HelpQuestionsTable createAlias(String alias) {
    return $HelpQuestionsTable(attachedDatabase, alias);
  }
}

class HelpQuestion extends DataClass implements Insertable<HelpQuestion> {
  final int id;
  final int remoteId;
  final String companyUuid;
  final String title;
  final String description;
  final int weight;
  const HelpQuestion(
      {required this.id,
      required this.remoteId,
      required this.companyUuid,
      required this.title,
      required this.description,
      required this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<int>(remoteId);
    map['company_uuid'] = Variable<String>(companyUuid);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['weight'] = Variable<int>(weight);
    return map;
  }

  HelpQuestionsCompanion toCompanion(bool nullToAbsent) {
    return HelpQuestionsCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      companyUuid: Value(companyUuid),
      title: Value(title),
      description: Value(description),
      weight: Value(weight),
    );
  }

  factory HelpQuestion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HelpQuestion(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int>(json['remoteId']),
      companyUuid: serializer.fromJson<String>(json['companyUuid']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      weight: serializer.fromJson<int>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int>(remoteId),
      'companyUuid': serializer.toJson<String>(companyUuid),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'weight': serializer.toJson<int>(weight),
    };
  }

  HelpQuestion copyWith(
          {int? id,
          int? remoteId,
          String? companyUuid,
          String? title,
          String? description,
          int? weight}) =>
      HelpQuestion(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        companyUuid: companyUuid ?? this.companyUuid,
        title: title ?? this.title,
        description: description ?? this.description,
        weight: weight ?? this.weight,
      );
  @override
  String toString() {
    return (StringBuffer('HelpQuestion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, remoteId, companyUuid, title, description, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HelpQuestion &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.companyUuid == this.companyUuid &&
          other.title == this.title &&
          other.description == this.description &&
          other.weight == this.weight);
}

class HelpQuestionsCompanion extends UpdateCompanion<HelpQuestion> {
  final Value<int> id;
  final Value<int> remoteId;
  final Value<String> companyUuid;
  final Value<String> title;
  final Value<String> description;
  final Value<int> weight;
  const HelpQuestionsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.companyUuid = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.weight = const Value.absent(),
  });
  HelpQuestionsCompanion.insert({
    this.id = const Value.absent(),
    required int remoteId,
    required String companyUuid,
    required String title,
    required String description,
    required int weight,
  })  : remoteId = Value(remoteId),
        companyUuid = Value(companyUuid),
        title = Value(title),
        description = Value(description),
        weight = Value(weight);
  static Insertable<HelpQuestion> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? companyUuid,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? weight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (companyUuid != null) 'company_uuid': companyUuid,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (weight != null) 'weight': weight,
    });
  }

  HelpQuestionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? remoteId,
      Value<String>? companyUuid,
      Value<String>? title,
      Value<String>? description,
      Value<int>? weight}) {
    return HelpQuestionsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      companyUuid: companyUuid ?? this.companyUuid,
      title: title ?? this.title,
      description: description ?? this.description,
      weight: weight ?? this.weight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (companyUuid.present) {
      map['company_uuid'] = Variable<String>(companyUuid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HelpQuestionsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('companyUuid: $companyUuid, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

class $ReviewSectionsTable extends ReviewSections
    with TableInfo<$ReviewSectionsTable, ReviewSection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewSectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES companies (remote_uuid) ON DELETE CASCADE'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subtitleMeta =
      const VerificationMeta('subtitle');
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
      'subtitle', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _repeatableMeta =
      const VerificationMeta('repeatable');
  @override
  late final GeneratedColumn<bool> repeatable =
      GeneratedColumn<bool>('repeatable', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("repeatable" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isSelfCreatedMeta =
      const VerificationMeta('isSelfCreated');
  @override
  late final GeneratedColumn<bool> isSelfCreated =
      GeneratedColumn<bool>('is_self_created', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_self_created" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        remoteId,
        templateId,
        parentId,
        uuid,
        title,
        subtitle,
        description,
        repeatable,
        isSelfCreated
      ];
  @override
  String get aliasedName => _alias ?? 'review_sections';
  @override
  String get actualTableName => 'review_sections';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewSection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(_subtitleMeta,
          subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('repeatable')) {
      context.handle(
          _repeatableMeta,
          repeatable.isAcceptableOrUnknown(
              data['repeatable']!, _repeatableMeta));
    } else if (isInserting) {
      context.missing(_repeatableMeta);
    }
    if (data.containsKey('is_self_created')) {
      context.handle(
          _isSelfCreatedMeta,
          isSelfCreated.isAcceptableOrUnknown(
              data['is_self_created']!, _isSelfCreatedMeta));
    } else if (isInserting) {
      context.missing(_isSelfCreatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewSection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewSection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_id']),
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subtitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subtitle']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      repeatable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}repeatable'])!,
      isSelfCreated: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_self_created'])!,
    );
  }

  @override
  $ReviewSectionsTable createAlias(String alias) {
    return $ReviewSectionsTable(attachedDatabase, alias);
  }
}

class ReviewSection extends DataClass implements Insertable<ReviewSection> {
  final int id;
  final int? remoteId;
  final int templateId;
  final int? parentId;
  final String uuid;
  final String title;
  final String? subtitle;
  final String? description;
  final bool repeatable;
  final bool isSelfCreated;
  const ReviewSection(
      {required this.id,
      this.remoteId,
      required this.templateId,
      this.parentId,
      required this.uuid,
      required this.title,
      this.subtitle,
      this.description,
      required this.repeatable,
      required this.isSelfCreated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['template_id'] = Variable<int>(templateId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['uuid'] = Variable<String>(uuid);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['repeatable'] = Variable<bool>(repeatable);
    map['is_self_created'] = Variable<bool>(isSelfCreated);
    return map;
  }

  ReviewSectionsCompanion toCompanion(bool nullToAbsent) {
    return ReviewSectionsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      templateId: Value(templateId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      uuid: Value(uuid),
      title: Value(title),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      repeatable: Value(repeatable),
      isSelfCreated: Value(isSelfCreated),
    );
  }

  factory ReviewSection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewSection(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      templateId: serializer.fromJson<int>(json['templateId']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      uuid: serializer.fromJson<String>(json['uuid']),
      title: serializer.fromJson<String>(json['title']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      description: serializer.fromJson<String?>(json['description']),
      repeatable: serializer.fromJson<bool>(json['repeatable']),
      isSelfCreated: serializer.fromJson<bool>(json['isSelfCreated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'templateId': serializer.toJson<int>(templateId),
      'parentId': serializer.toJson<int?>(parentId),
      'uuid': serializer.toJson<String>(uuid),
      'title': serializer.toJson<String>(title),
      'subtitle': serializer.toJson<String?>(subtitle),
      'description': serializer.toJson<String?>(description),
      'repeatable': serializer.toJson<bool>(repeatable),
      'isSelfCreated': serializer.toJson<bool>(isSelfCreated),
    };
  }

  ReviewSection copyWith(
          {int? id,
          Value<int?> remoteId = const Value.absent(),
          int? templateId,
          Value<int?> parentId = const Value.absent(),
          String? uuid,
          String? title,
          Value<String?> subtitle = const Value.absent(),
          Value<String?> description = const Value.absent(),
          bool? repeatable,
          bool? isSelfCreated}) =>
      ReviewSection(
        id: id ?? this.id,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        templateId: templateId ?? this.templateId,
        parentId: parentId.present ? parentId.value : this.parentId,
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        subtitle: subtitle.present ? subtitle.value : this.subtitle,
        description: description.present ? description.value : this.description,
        repeatable: repeatable ?? this.repeatable,
        isSelfCreated: isSelfCreated ?? this.isSelfCreated,
      );
  @override
  String toString() {
    return (StringBuffer('ReviewSection(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('templateId: $templateId, ')
          ..write('parentId: $parentId, ')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('description: $description, ')
          ..write('repeatable: $repeatable, ')
          ..write('isSelfCreated: $isSelfCreated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, remoteId, templateId, parentId, uuid,
      title, subtitle, description, repeatable, isSelfCreated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewSection &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.templateId == this.templateId &&
          other.parentId == this.parentId &&
          other.uuid == this.uuid &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.description == this.description &&
          other.repeatable == this.repeatable &&
          other.isSelfCreated == this.isSelfCreated);
}

class ReviewSectionsCompanion extends UpdateCompanion<ReviewSection> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<int> templateId;
  final Value<int?> parentId;
  final Value<String> uuid;
  final Value<String> title;
  final Value<String?> subtitle;
  final Value<String?> description;
  final Value<bool> repeatable;
  final Value<bool> isSelfCreated;
  const ReviewSectionsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.uuid = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.description = const Value.absent(),
    this.repeatable = const Value.absent(),
    this.isSelfCreated = const Value.absent(),
  });
  ReviewSectionsCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    required int templateId,
    this.parentId = const Value.absent(),
    required String uuid,
    required String title,
    this.subtitle = const Value.absent(),
    this.description = const Value.absent(),
    required bool repeatable,
    required bool isSelfCreated,
  })  : templateId = Value(templateId),
        uuid = Value(uuid),
        title = Value(title),
        repeatable = Value(repeatable),
        isSelfCreated = Value(isSelfCreated);
  static Insertable<ReviewSection> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<int>? templateId,
    Expression<int>? parentId,
    Expression<String>? uuid,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<String>? description,
    Expression<bool>? repeatable,
    Expression<bool>? isSelfCreated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (templateId != null) 'template_id': templateId,
      if (parentId != null) 'parent_id': parentId,
      if (uuid != null) 'uuid': uuid,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (description != null) 'description': description,
      if (repeatable != null) 'repeatable': repeatable,
      if (isSelfCreated != null) 'is_self_created': isSelfCreated,
    });
  }

  ReviewSectionsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? remoteId,
      Value<int>? templateId,
      Value<int?>? parentId,
      Value<String>? uuid,
      Value<String>? title,
      Value<String?>? subtitle,
      Value<String?>? description,
      Value<bool>? repeatable,
      Value<bool>? isSelfCreated}) {
    return ReviewSectionsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      templateId: templateId ?? this.templateId,
      parentId: parentId ?? this.parentId,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      repeatable: repeatable ?? this.repeatable,
      isSelfCreated: isSelfCreated ?? this.isSelfCreated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (repeatable.present) {
      map['repeatable'] = Variable<bool>(repeatable.value);
    }
    if (isSelfCreated.present) {
      map['is_self_created'] = Variable<bool>(isSelfCreated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewSectionsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('templateId: $templateId, ')
          ..write('parentId: $parentId, ')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('description: $description, ')
          ..write('repeatable: $repeatable, ')
          ..write('isSelfCreated: $isSelfCreated')
          ..write(')'))
        .toString();
  }
}

class $PropertiesArticlesTable extends PropertiesArticles
    with TableInfo<$PropertiesArticlesTable, PropertiesArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertiesArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _articleIdMeta =
      const VerificationMeta('articleId');
  @override
  late final GeneratedColumn<int> articleId = GeneratedColumn<int>(
      'article_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [name, value, articleId];
  @override
  String get aliasedName => _alias ?? 'properties_articles';
  @override
  String get actualTableName => 'properties_articles';
  @override
  VerificationContext validateIntegrity(Insertable<PropertiesArticle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('article_id')) {
      context.handle(_articleIdMeta,
          articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PropertiesArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PropertiesArticle(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value']),
      articleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}article_id']),
    );
  }

  @override
  $PropertiesArticlesTable createAlias(String alias) {
    return $PropertiesArticlesTable(attachedDatabase, alias);
  }
}

class PropertiesArticle extends DataClass
    implements Insertable<PropertiesArticle> {
  final String? name;
  final String? value;
  final int? articleId;
  const PropertiesArticle({this.name, this.value, this.articleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    if (!nullToAbsent || articleId != null) {
      map['article_id'] = Variable<int>(articleId);
    }
    return map;
  }

  PropertiesArticlesCompanion toCompanion(bool nullToAbsent) {
    return PropertiesArticlesCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      articleId: articleId == null && nullToAbsent
          ? const Value.absent()
          : Value(articleId),
    );
  }

  factory PropertiesArticle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PropertiesArticle(
      name: serializer.fromJson<String?>(json['name']),
      value: serializer.fromJson<String?>(json['value']),
      articleId: serializer.fromJson<int?>(json['articleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String?>(name),
      'value': serializer.toJson<String?>(value),
      'articleId': serializer.toJson<int?>(articleId),
    };
  }

  PropertiesArticle copyWith(
          {Value<String?> name = const Value.absent(),
          Value<String?> value = const Value.absent(),
          Value<int?> articleId = const Value.absent()}) =>
      PropertiesArticle(
        name: name.present ? name.value : this.name,
        value: value.present ? value.value : this.value,
        articleId: articleId.present ? articleId.value : this.articleId,
      );
  @override
  String toString() {
    return (StringBuffer('PropertiesArticle(')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('articleId: $articleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, value, articleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PropertiesArticle &&
          other.name == this.name &&
          other.value == this.value &&
          other.articleId == this.articleId);
}

class PropertiesArticlesCompanion extends UpdateCompanion<PropertiesArticle> {
  final Value<String?> name;
  final Value<String?> value;
  final Value<int?> articleId;
  const PropertiesArticlesCompanion({
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.articleId = const Value.absent(),
  });
  PropertiesArticlesCompanion.insert({
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.articleId = const Value.absent(),
  });
  static Insertable<PropertiesArticle> custom({
    Expression<String>? name,
    Expression<String>? value,
    Expression<int>? articleId,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (articleId != null) 'article_id': articleId,
    });
  }

  PropertiesArticlesCompanion copyWith(
      {Value<String?>? name, Value<String?>? value, Value<int?>? articleId}) {
    return PropertiesArticlesCompanion(
      name: name ?? this.name,
      value: value ?? this.value,
      articleId: articleId ?? this.articleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (articleId.present) {
      map['article_id'] = Variable<int>(articleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertiesArticlesCompanion(')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('articleId: $articleId')
          ..write(')'))
        .toString();
  }
}

class $InfoModalsTable extends InfoModals
    with TableInfo<$InfoModalsTable, InfoModal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InfoModalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _enableMeta = const VerificationMeta('enable');
  @override
  late final GeneratedColumn<bool> enable =
      GeneratedColumn<bool>('enable', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("enable" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _titleTemplateMeta =
      const VerificationMeta('titleTemplate');
  @override
  late final GeneratedColumn<String> titleTemplate = GeneratedColumn<String>(
      'title_template', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textTemplateMeta =
      const VerificationMeta('textTemplate');
  @override
  late final GeneratedColumn<String> textTemplate = GeneratedColumn<String>(
      'text_template', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, enable, titleTemplate, textTemplate, type];
  @override
  String get aliasedName => _alias ?? 'info_modals';
  @override
  String get actualTableName => 'info_modals';
  @override
  VerificationContext validateIntegrity(Insertable<InfoModal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('enable')) {
      context.handle(_enableMeta,
          enable.isAcceptableOrUnknown(data['enable']!, _enableMeta));
    } else if (isInserting) {
      context.missing(_enableMeta);
    }
    if (data.containsKey('title_template')) {
      context.handle(
          _titleTemplateMeta,
          titleTemplate.isAcceptableOrUnknown(
              data['title_template']!, _titleTemplateMeta));
    } else if (isInserting) {
      context.missing(_titleTemplateMeta);
    }
    if (data.containsKey('text_template')) {
      context.handle(
          _textTemplateMeta,
          textTemplate.isAcceptableOrUnknown(
              data['text_template']!, _textTemplateMeta));
    } else if (isInserting) {
      context.missing(_textTemplateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InfoModal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InfoModal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      enable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enable'])!,
      titleTemplate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_template'])!,
      textTemplate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_template'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $InfoModalsTable createAlias(String alias) {
    return $InfoModalsTable(attachedDatabase, alias);
  }
}

class InfoModal extends DataClass implements Insertable<InfoModal> {
  final int id;
  final bool enable;
  final String titleTemplate;
  final String textTemplate;
  final String type;
  const InfoModal(
      {required this.id,
      required this.enable,
      required this.titleTemplate,
      required this.textTemplate,
      required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['enable'] = Variable<bool>(enable);
    map['title_template'] = Variable<String>(titleTemplate);
    map['text_template'] = Variable<String>(textTemplate);
    map['type'] = Variable<String>(type);
    return map;
  }

  InfoModalsCompanion toCompanion(bool nullToAbsent) {
    return InfoModalsCompanion(
      id: Value(id),
      enable: Value(enable),
      titleTemplate: Value(titleTemplate),
      textTemplate: Value(textTemplate),
      type: Value(type),
    );
  }

  factory InfoModal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InfoModal(
      id: serializer.fromJson<int>(json['id']),
      enable: serializer.fromJson<bool>(json['enable']),
      titleTemplate: serializer.fromJson<String>(json['titleTemplate']),
      textTemplate: serializer.fromJson<String>(json['textTemplate']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'enable': serializer.toJson<bool>(enable),
      'titleTemplate': serializer.toJson<String>(titleTemplate),
      'textTemplate': serializer.toJson<String>(textTemplate),
      'type': serializer.toJson<String>(type),
    };
  }

  InfoModal copyWith(
          {int? id,
          bool? enable,
          String? titleTemplate,
          String? textTemplate,
          String? type}) =>
      InfoModal(
        id: id ?? this.id,
        enable: enable ?? this.enable,
        titleTemplate: titleTemplate ?? this.titleTemplate,
        textTemplate: textTemplate ?? this.textTemplate,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('InfoModal(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('titleTemplate: $titleTemplate, ')
          ..write('textTemplate: $textTemplate, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, enable, titleTemplate, textTemplate, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InfoModal &&
          other.id == this.id &&
          other.enable == this.enable &&
          other.titleTemplate == this.titleTemplate &&
          other.textTemplate == this.textTemplate &&
          other.type == this.type);
}

class InfoModalsCompanion extends UpdateCompanion<InfoModal> {
  final Value<int> id;
  final Value<bool> enable;
  final Value<String> titleTemplate;
  final Value<String> textTemplate;
  final Value<String> type;
  const InfoModalsCompanion({
    this.id = const Value.absent(),
    this.enable = const Value.absent(),
    this.titleTemplate = const Value.absent(),
    this.textTemplate = const Value.absent(),
    this.type = const Value.absent(),
  });
  InfoModalsCompanion.insert({
    this.id = const Value.absent(),
    required bool enable,
    required String titleTemplate,
    required String textTemplate,
    required String type,
  })  : enable = Value(enable),
        titleTemplate = Value(titleTemplate),
        textTemplate = Value(textTemplate),
        type = Value(type);
  static Insertable<InfoModal> custom({
    Expression<int>? id,
    Expression<bool>? enable,
    Expression<String>? titleTemplate,
    Expression<String>? textTemplate,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enable != null) 'enable': enable,
      if (titleTemplate != null) 'title_template': titleTemplate,
      if (textTemplate != null) 'text_template': textTemplate,
      if (type != null) 'type': type,
    });
  }

  InfoModalsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? enable,
      Value<String>? titleTemplate,
      Value<String>? textTemplate,
      Value<String>? type}) {
    return InfoModalsCompanion(
      id: id ?? this.id,
      enable: enable ?? this.enable,
      titleTemplate: titleTemplate ?? this.titleTemplate,
      textTemplate: textTemplate ?? this.textTemplate,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (enable.present) {
      map['enable'] = Variable<bool>(enable.value);
    }
    if (titleTemplate.present) {
      map['title_template'] = Variable<String>(titleTemplate.value);
    }
    if (textTemplate.present) {
      map['text_template'] = Variable<String>(textTemplate.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InfoModalsCompanion(')
          ..write('id: $id, ')
          ..write('enable: $enable, ')
          ..write('titleTemplate: $titleTemplate, ')
          ..write('textTemplate: $textTemplate, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $CompaniesTable companies = $CompaniesTable(this);
  late final $ArticleTypesTable articleTypes = $ArticleTypesTable(this);
  late final $ArticleTypePropertiesTable articleTypeProperties =
      $ArticleTypePropertiesTable(this);
  late final $ArticlesTable articles = $ArticlesTable(this);
  late final $ReviewTemplatesTable reviewTemplates =
      $ReviewTemplatesTable(this);
  late final $ReviewTemplateFormsTable reviewTemplateForms =
      $ReviewTemplateFormsTable(this);
  late final $ReviewTemplateFormFieldsTable reviewTemplateFormFields =
      $ReviewTemplateFormFieldsTable(this);
  late final $ReviewTemplateStepsTable reviewTemplateSteps =
      $ReviewTemplateStepsTable(this);
  late final $ReviewTemplateArticlesTable reviewTemplateArticles =
      $ReviewTemplateArticlesTable(this);
  late final $ReviewsTable reviews = $ReviewsTable(this);
  late final $ReviewLocationsTable reviewLocations =
      $ReviewLocationsTable(this);
  late final $ReviewStepFilesTable reviewStepFiles =
      $ReviewStepFilesTable(this);
  late final $ReviewStepViolationsTable reviewStepViolations =
      $ReviewStepViolationsTable(this);
  late final $UploadsTable uploads = $UploadsTable(this);
  late final $HelpQuestionsTable helpQuestions = $HelpQuestionsTable(this);
  late final $ReviewSectionsTable reviewSections = $ReviewSectionsTable(this);
  late final $PropertiesArticlesTable propertiesArticles =
      $PropertiesArticlesTable(this);
  late final $InfoModalsTable infoModals = $InfoModalsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        companies,
        articleTypes,
        articleTypeProperties,
        articles,
        reviewTemplates,
        reviewTemplateForms,
        reviewTemplateFormFields,
        reviewTemplateSteps,
        reviewTemplateArticles,
        reviews,
        reviewLocations,
        reviewStepFiles,
        reviewStepViolations,
        uploads,
        helpQuestions,
        reviewSections,
        propertiesArticles,
        infoModals
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('article_types', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('article_type_properties', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('articles', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('review_template_forms', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('review_template_form_fields',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('review_template_steps', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('review_template_articles', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('help_questions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('companies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('review_sections', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}
