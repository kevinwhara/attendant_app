// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _employeeCodeMeta = const VerificationMeta(
    'employeeCode',
  );
  @override
  late final GeneratedColumn<String> employeeCode = GeneratedColumn<String>(
    'employee_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _departmentMeta = const VerificationMeta(
    'department',
  );
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
    'department',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    employeeCode,
    name,
    email,
    passwordHash,
    department,
    position,
    photoPath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Employee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employee_code')) {
      context.handle(
        _employeeCodeMeta,
        employeeCode.isAcceptableOrUnknown(
          data['employee_code']!,
          _employeeCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_employeeCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('department')) {
      context.handle(
        _departmentMeta,
        department.isAcceptableOrUnknown(data['department']!, _departmentMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      employeeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      department: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final String employeeCode;
  final String name;
  final String email;
  final String passwordHash;
  final String? department;
  final String? position;
  final String? photoPath;
  final int createdAt;
  final int updatedAt;
  const Employee({
    required this.id,
    required this.employeeCode,
    required this.name,
    required this.email,
    required this.passwordHash,
    this.department,
    this.position,
    this.photoPath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['employee_code'] = Variable<String>(employeeCode);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    if (!nullToAbsent || department != null) {
      map['department'] = Variable<String>(department);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      employeeCode: Value(employeeCode),
      name: Value(name),
      email: Value(email),
      passwordHash: Value(passwordHash),
      department: department == null && nullToAbsent
          ? const Value.absent()
          : Value(department),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Employee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      employeeCode: serializer.fromJson<String>(json['employeeCode']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      department: serializer.fromJson<String?>(json['department']),
      position: serializer.fromJson<String?>(json['position']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeCode': serializer.toJson<String>(employeeCode),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'department': serializer.toJson<String?>(department),
      'position': serializer.toJson<String?>(position),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Employee copyWith({
    int? id,
    String? employeeCode,
    String? name,
    String? email,
    String? passwordHash,
    Value<String?> department = const Value.absent(),
    Value<String?> position = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => Employee(
    id: id ?? this.id,
    employeeCode: employeeCode ?? this.employeeCode,
    name: name ?? this.name,
    email: email ?? this.email,
    passwordHash: passwordHash ?? this.passwordHash,
    department: department.present ? department.value : this.department,
    position: position.present ? position.value : this.position,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Employee copyWithCompanion(EmployeesCompanion data) {
    return Employee(
      id: data.id.present ? data.id.value : this.id,
      employeeCode: data.employeeCode.present
          ? data.employeeCode.value
          : this.employeeCode,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      department: data.department.present
          ? data.department.value
          : this.department,
      position: data.position.present ? data.position.value : this.position,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('employeeCode: $employeeCode, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('department: $department, ')
          ..write('position: $position, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    employeeCode,
    name,
    email,
    passwordHash,
    department,
    position,
    photoPath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.employeeCode == this.employeeCode &&
          other.name == this.name &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.department == this.department &&
          other.position == this.position &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<String> employeeCode;
  final Value<String> name;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<String?> department;
  final Value<String?> position;
  final Value<String?> photoPath;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.employeeCode = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.department = const Value.absent(),
    this.position = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    required String employeeCode,
    required String name,
    required String email,
    required String passwordHash,
    this.department = const Value.absent(),
    this.position = const Value.absent(),
    this.photoPath = const Value.absent(),
    required int createdAt,
    required int updatedAt,
  }) : employeeCode = Value(employeeCode),
       name = Value(name),
       email = Value(email),
       passwordHash = Value(passwordHash),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Employee> custom({
    Expression<int>? id,
    Expression<String>? employeeCode,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? department,
    Expression<String>? position,
    Expression<String>? photoPath,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeCode != null) 'employee_code': employeeCode,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (department != null) 'department': department,
      if (position != null) 'position': position,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EmployeesCompanion copyWith({
    Value<int>? id,
    Value<String>? employeeCode,
    Value<String>? name,
    Value<String>? email,
    Value<String>? passwordHash,
    Value<String?>? department,
    Value<String?>? position,
    Value<String?>? photoPath,
    Value<int>? createdAt,
    Value<int>? updatedAt,
  }) {
    return EmployeesCompanion(
      id: id ?? this.id,
      employeeCode: employeeCode ?? this.employeeCode,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      department: department ?? this.department,
      position: position ?? this.position,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employeeCode.present) {
      map['employee_code'] = Variable<String>(employeeCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('employeeCode: $employeeCode, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('department: $department, ')
          ..write('position: $position, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AttendanceTable extends Attendance
    with TableInfo<$AttendanceTable, AttendanceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<int> employeeId = GeneratedColumn<int>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES employees (id)',
    ),
  );
  static const VerificationMeta _attendanceDateMeta = const VerificationMeta(
    'attendanceDate',
  );
  @override
  late final GeneratedColumn<String> attendanceDate = GeneratedColumn<String>(
    'attendance_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkInMeta = const VerificationMeta(
    'checkIn',
  );
  @override
  late final GeneratedColumn<int> checkIn = GeneratedColumn<int>(
    'check_in',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkOutMeta = const VerificationMeta(
    'checkOut',
  );
  @override
  late final GeneratedColumn<int> checkOut = GeneratedColumn<int>(
    'check_out',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkInFaceDetectedMeta =
      const VerificationMeta('checkInFaceDetected');
  @override
  late final GeneratedColumn<int> checkInFaceDetected = GeneratedColumn<int>(
    'check_in_face_detected',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _checkOutFaceDetectedMeta =
      const VerificationMeta('checkOutFaceDetected');
  @override
  late final GeneratedColumn<int> checkOutFaceDetected = GeneratedColumn<int>(
    'check_out_face_detected',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _checkInPhotoPathMeta = const VerificationMeta(
    'checkInPhotoPath',
  );
  @override
  late final GeneratedColumn<String> checkInPhotoPath = GeneratedColumn<String>(
    'check_in_photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkOutPhotoPathMeta = const VerificationMeta(
    'checkOutPhotoPath',
  );
  @override
  late final GeneratedColumn<String> checkOutPhotoPath =
      GeneratedColumn<String>(
        'check_out_photo_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    employeeId,
    attendanceDate,
    checkIn,
    checkOut,
    checkInFaceDetected,
    checkOutFaceDetected,
    checkInPhotoPath,
    checkOutPhotoPath,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('attendance_date')) {
      context.handle(
        _attendanceDateMeta,
        attendanceDate.isAcceptableOrUnknown(
          data['attendance_date']!,
          _attendanceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attendanceDateMeta);
    }
    if (data.containsKey('check_in')) {
      context.handle(
        _checkInMeta,
        checkIn.isAcceptableOrUnknown(data['check_in']!, _checkInMeta),
      );
    }
    if (data.containsKey('check_out')) {
      context.handle(
        _checkOutMeta,
        checkOut.isAcceptableOrUnknown(data['check_out']!, _checkOutMeta),
      );
    }
    if (data.containsKey('check_in_face_detected')) {
      context.handle(
        _checkInFaceDetectedMeta,
        checkInFaceDetected.isAcceptableOrUnknown(
          data['check_in_face_detected']!,
          _checkInFaceDetectedMeta,
        ),
      );
    }
    if (data.containsKey('check_out_face_detected')) {
      context.handle(
        _checkOutFaceDetectedMeta,
        checkOutFaceDetected.isAcceptableOrUnknown(
          data['check_out_face_detected']!,
          _checkOutFaceDetectedMeta,
        ),
      );
    }
    if (data.containsKey('check_in_photo_path')) {
      context.handle(
        _checkInPhotoPathMeta,
        checkInPhotoPath.isAcceptableOrUnknown(
          data['check_in_photo_path']!,
          _checkInPhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('check_out_photo_path')) {
      context.handle(
        _checkOutPhotoPathMeta,
        checkOutPhotoPath.isAcceptableOrUnknown(
          data['check_out_photo_path']!,
          _checkOutPhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {employeeId, attendanceDate},
  ];
  @override
  AttendanceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}employee_id'],
      )!,
      attendanceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attendance_date'],
      )!,
      checkIn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_in'],
      ),
      checkOut: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_out'],
      ),
      checkInFaceDetected: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_in_face_detected'],
      )!,
      checkOutFaceDetected: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_out_face_detected'],
      )!,
      checkInPhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_in_photo_path'],
      ),
      checkOutPhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_out_photo_path'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AttendanceTable createAlias(String alias) {
    return $AttendanceTable(attachedDatabase, alias);
  }
}

class AttendanceRecord extends DataClass
    implements Insertable<AttendanceRecord> {
  final int id;
  final int employeeId;
  final String attendanceDate;
  final int? checkIn;
  final int? checkOut;
  final int checkInFaceDetected;
  final int checkOutFaceDetected;
  final String? checkInPhotoPath;
  final String? checkOutPhotoPath;
  final String status;
  final String? notes;
  final int createdAt;
  final int updatedAt;
  const AttendanceRecord({
    required this.id,
    required this.employeeId,
    required this.attendanceDate,
    this.checkIn,
    this.checkOut,
    required this.checkInFaceDetected,
    required this.checkOutFaceDetected,
    this.checkInPhotoPath,
    this.checkOutPhotoPath,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['employee_id'] = Variable<int>(employeeId);
    map['attendance_date'] = Variable<String>(attendanceDate);
    if (!nullToAbsent || checkIn != null) {
      map['check_in'] = Variable<int>(checkIn);
    }
    if (!nullToAbsent || checkOut != null) {
      map['check_out'] = Variable<int>(checkOut);
    }
    map['check_in_face_detected'] = Variable<int>(checkInFaceDetected);
    map['check_out_face_detected'] = Variable<int>(checkOutFaceDetected);
    if (!nullToAbsent || checkInPhotoPath != null) {
      map['check_in_photo_path'] = Variable<String>(checkInPhotoPath);
    }
    if (!nullToAbsent || checkOutPhotoPath != null) {
      map['check_out_photo_path'] = Variable<String>(checkOutPhotoPath);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  AttendanceCompanion toCompanion(bool nullToAbsent) {
    return AttendanceCompanion(
      id: Value(id),
      employeeId: Value(employeeId),
      attendanceDate: Value(attendanceDate),
      checkIn: checkIn == null && nullToAbsent
          ? const Value.absent()
          : Value(checkIn),
      checkOut: checkOut == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOut),
      checkInFaceDetected: Value(checkInFaceDetected),
      checkOutFaceDetected: Value(checkOutFaceDetected),
      checkInPhotoPath: checkInPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInPhotoPath),
      checkOutPhotoPath: checkOutPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOutPhotoPath),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AttendanceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceRecord(
      id: serializer.fromJson<int>(json['id']),
      employeeId: serializer.fromJson<int>(json['employeeId']),
      attendanceDate: serializer.fromJson<String>(json['attendanceDate']),
      checkIn: serializer.fromJson<int?>(json['checkIn']),
      checkOut: serializer.fromJson<int?>(json['checkOut']),
      checkInFaceDetected: serializer.fromJson<int>(
        json['checkInFaceDetected'],
      ),
      checkOutFaceDetected: serializer.fromJson<int>(
        json['checkOutFaceDetected'],
      ),
      checkInPhotoPath: serializer.fromJson<String?>(json['checkInPhotoPath']),
      checkOutPhotoPath: serializer.fromJson<String?>(
        json['checkOutPhotoPath'],
      ),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeId': serializer.toJson<int>(employeeId),
      'attendanceDate': serializer.toJson<String>(attendanceDate),
      'checkIn': serializer.toJson<int?>(checkIn),
      'checkOut': serializer.toJson<int?>(checkOut),
      'checkInFaceDetected': serializer.toJson<int>(checkInFaceDetected),
      'checkOutFaceDetected': serializer.toJson<int>(checkOutFaceDetected),
      'checkInPhotoPath': serializer.toJson<String?>(checkInPhotoPath),
      'checkOutPhotoPath': serializer.toJson<String?>(checkOutPhotoPath),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  AttendanceRecord copyWith({
    int? id,
    int? employeeId,
    String? attendanceDate,
    Value<int?> checkIn = const Value.absent(),
    Value<int?> checkOut = const Value.absent(),
    int? checkInFaceDetected,
    int? checkOutFaceDetected,
    Value<String?> checkInPhotoPath = const Value.absent(),
    Value<String?> checkOutPhotoPath = const Value.absent(),
    String? status,
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => AttendanceRecord(
    id: id ?? this.id,
    employeeId: employeeId ?? this.employeeId,
    attendanceDate: attendanceDate ?? this.attendanceDate,
    checkIn: checkIn.present ? checkIn.value : this.checkIn,
    checkOut: checkOut.present ? checkOut.value : this.checkOut,
    checkInFaceDetected: checkInFaceDetected ?? this.checkInFaceDetected,
    checkOutFaceDetected: checkOutFaceDetected ?? this.checkOutFaceDetected,
    checkInPhotoPath: checkInPhotoPath.present
        ? checkInPhotoPath.value
        : this.checkInPhotoPath,
    checkOutPhotoPath: checkOutPhotoPath.present
        ? checkOutPhotoPath.value
        : this.checkOutPhotoPath,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AttendanceRecord copyWithCompanion(AttendanceCompanion data) {
    return AttendanceRecord(
      id: data.id.present ? data.id.value : this.id,
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      attendanceDate: data.attendanceDate.present
          ? data.attendanceDate.value
          : this.attendanceDate,
      checkIn: data.checkIn.present ? data.checkIn.value : this.checkIn,
      checkOut: data.checkOut.present ? data.checkOut.value : this.checkOut,
      checkInFaceDetected: data.checkInFaceDetected.present
          ? data.checkInFaceDetected.value
          : this.checkInFaceDetected,
      checkOutFaceDetected: data.checkOutFaceDetected.present
          ? data.checkOutFaceDetected.value
          : this.checkOutFaceDetected,
      checkInPhotoPath: data.checkInPhotoPath.present
          ? data.checkInPhotoPath.value
          : this.checkInPhotoPath,
      checkOutPhotoPath: data.checkOutPhotoPath.present
          ? data.checkOutPhotoPath.value
          : this.checkOutPhotoPath,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRecord(')
          ..write('id: $id, ')
          ..write('employeeId: $employeeId, ')
          ..write('attendanceDate: $attendanceDate, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('checkInFaceDetected: $checkInFaceDetected, ')
          ..write('checkOutFaceDetected: $checkOutFaceDetected, ')
          ..write('checkInPhotoPath: $checkInPhotoPath, ')
          ..write('checkOutPhotoPath: $checkOutPhotoPath, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    employeeId,
    attendanceDate,
    checkIn,
    checkOut,
    checkInFaceDetected,
    checkOutFaceDetected,
    checkInPhotoPath,
    checkOutPhotoPath,
    status,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceRecord &&
          other.id == this.id &&
          other.employeeId == this.employeeId &&
          other.attendanceDate == this.attendanceDate &&
          other.checkIn == this.checkIn &&
          other.checkOut == this.checkOut &&
          other.checkInFaceDetected == this.checkInFaceDetected &&
          other.checkOutFaceDetected == this.checkOutFaceDetected &&
          other.checkInPhotoPath == this.checkInPhotoPath &&
          other.checkOutPhotoPath == this.checkOutPhotoPath &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AttendanceCompanion extends UpdateCompanion<AttendanceRecord> {
  final Value<int> id;
  final Value<int> employeeId;
  final Value<String> attendanceDate;
  final Value<int?> checkIn;
  final Value<int?> checkOut;
  final Value<int> checkInFaceDetected;
  final Value<int> checkOutFaceDetected;
  final Value<String?> checkInPhotoPath;
  final Value<String?> checkOutPhotoPath;
  final Value<String> status;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const AttendanceCompanion({
    this.id = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.attendanceDate = const Value.absent(),
    this.checkIn = const Value.absent(),
    this.checkOut = const Value.absent(),
    this.checkInFaceDetected = const Value.absent(),
    this.checkOutFaceDetected = const Value.absent(),
    this.checkInPhotoPath = const Value.absent(),
    this.checkOutPhotoPath = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AttendanceCompanion.insert({
    this.id = const Value.absent(),
    required int employeeId,
    required String attendanceDate,
    this.checkIn = const Value.absent(),
    this.checkOut = const Value.absent(),
    this.checkInFaceDetected = const Value.absent(),
    this.checkOutFaceDetected = const Value.absent(),
    this.checkInPhotoPath = const Value.absent(),
    this.checkOutPhotoPath = const Value.absent(),
    required String status,
    this.notes = const Value.absent(),
    required int createdAt,
    required int updatedAt,
  }) : employeeId = Value(employeeId),
       attendanceDate = Value(attendanceDate),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AttendanceRecord> custom({
    Expression<int>? id,
    Expression<int>? employeeId,
    Expression<String>? attendanceDate,
    Expression<int>? checkIn,
    Expression<int>? checkOut,
    Expression<int>? checkInFaceDetected,
    Expression<int>? checkOutFaceDetected,
    Expression<String>? checkInPhotoPath,
    Expression<String>? checkOutPhotoPath,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeId != null) 'employee_id': employeeId,
      if (attendanceDate != null) 'attendance_date': attendanceDate,
      if (checkIn != null) 'check_in': checkIn,
      if (checkOut != null) 'check_out': checkOut,
      if (checkInFaceDetected != null)
        'check_in_face_detected': checkInFaceDetected,
      if (checkOutFaceDetected != null)
        'check_out_face_detected': checkOutFaceDetected,
      if (checkInPhotoPath != null) 'check_in_photo_path': checkInPhotoPath,
      if (checkOutPhotoPath != null) 'check_out_photo_path': checkOutPhotoPath,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AttendanceCompanion copyWith({
    Value<int>? id,
    Value<int>? employeeId,
    Value<String>? attendanceDate,
    Value<int?>? checkIn,
    Value<int?>? checkOut,
    Value<int>? checkInFaceDetected,
    Value<int>? checkOutFaceDetected,
    Value<String?>? checkInPhotoPath,
    Value<String?>? checkOutPhotoPath,
    Value<String>? status,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int>? updatedAt,
  }) {
    return AttendanceCompanion(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      attendanceDate: attendanceDate ?? this.attendanceDate,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      checkInFaceDetected: checkInFaceDetected ?? this.checkInFaceDetected,
      checkOutFaceDetected: checkOutFaceDetected ?? this.checkOutFaceDetected,
      checkInPhotoPath: checkInPhotoPath ?? this.checkInPhotoPath,
      checkOutPhotoPath: checkOutPhotoPath ?? this.checkOutPhotoPath,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<int>(employeeId.value);
    }
    if (attendanceDate.present) {
      map['attendance_date'] = Variable<String>(attendanceDate.value);
    }
    if (checkIn.present) {
      map['check_in'] = Variable<int>(checkIn.value);
    }
    if (checkOut.present) {
      map['check_out'] = Variable<int>(checkOut.value);
    }
    if (checkInFaceDetected.present) {
      map['check_in_face_detected'] = Variable<int>(checkInFaceDetected.value);
    }
    if (checkOutFaceDetected.present) {
      map['check_out_face_detected'] = Variable<int>(
        checkOutFaceDetected.value,
      );
    }
    if (checkInPhotoPath.present) {
      map['check_in_photo_path'] = Variable<String>(checkInPhotoPath.value);
    }
    if (checkOutPhotoPath.present) {
      map['check_out_photo_path'] = Variable<String>(checkOutPhotoPath.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceCompanion(')
          ..write('id: $id, ')
          ..write('employeeId: $employeeId, ')
          ..write('attendanceDate: $attendanceDate, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('checkInFaceDetected: $checkInFaceDetected, ')
          ..write('checkOutFaceDetected: $checkOutFaceDetected, ')
          ..write('checkInPhotoPath: $checkInPhotoPath, ')
          ..write('checkOutPhotoPath: $checkOutPhotoPath, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WorkSchedulesTable extends WorkSchedules
    with TableInfo<$WorkSchedulesTable, WorkScheduleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<int> employeeId = GeneratedColumn<int>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES employees (id)',
    ),
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breakStartMeta = const VerificationMeta(
    'breakStart',
  );
  @override
  late final GeneratedColumn<String> breakStart = GeneratedColumn<String>(
    'break_start',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _breakEndMeta = const VerificationMeta(
    'breakEnd',
  );
  @override
  late final GeneratedColumn<String> breakEnd = GeneratedColumn<String>(
    'break_end',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    employeeId,
    dayOfWeek,
    startTime,
    endTime,
    breakStart,
    breakEnd,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkScheduleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('break_start')) {
      context.handle(
        _breakStartMeta,
        breakStart.isAcceptableOrUnknown(data['break_start']!, _breakStartMeta),
      );
    }
    if (data.containsKey('break_end')) {
      context.handle(
        _breakEndMeta,
        breakEnd.isAcceptableOrUnknown(data['break_end']!, _breakEndMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {employeeId, dayOfWeek},
  ];
  @override
  WorkScheduleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkScheduleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}employee_id'],
      )!,
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_week'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_time'],
      )!,
      breakStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}break_start'],
      ),
      breakEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}break_end'],
      ),
    );
  }

  @override
  $WorkSchedulesTable createAlias(String alias) {
    return $WorkSchedulesTable(attachedDatabase, alias);
  }
}

class WorkScheduleData extends DataClass
    implements Insertable<WorkScheduleData> {
  final int id;
  final int employeeId;
  final int dayOfWeek;
  final String startTime;
  final String endTime;
  final String? breakStart;
  final String? breakEnd;
  const WorkScheduleData({
    required this.id,
    required this.employeeId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.breakStart,
    this.breakEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['employee_id'] = Variable<int>(employeeId);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    if (!nullToAbsent || breakStart != null) {
      map['break_start'] = Variable<String>(breakStart);
    }
    if (!nullToAbsent || breakEnd != null) {
      map['break_end'] = Variable<String>(breakEnd);
    }
    return map;
  }

  WorkSchedulesCompanion toCompanion(bool nullToAbsent) {
    return WorkSchedulesCompanion(
      id: Value(id),
      employeeId: Value(employeeId),
      dayOfWeek: Value(dayOfWeek),
      startTime: Value(startTime),
      endTime: Value(endTime),
      breakStart: breakStart == null && nullToAbsent
          ? const Value.absent()
          : Value(breakStart),
      breakEnd: breakEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(breakEnd),
    );
  }

  factory WorkScheduleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkScheduleData(
      id: serializer.fromJson<int>(json['id']),
      employeeId: serializer.fromJson<int>(json['employeeId']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String>(json['endTime']),
      breakStart: serializer.fromJson<String?>(json['breakStart']),
      breakEnd: serializer.fromJson<String?>(json['breakEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeId': serializer.toJson<int>(employeeId),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'breakStart': serializer.toJson<String?>(breakStart),
      'breakEnd': serializer.toJson<String?>(breakEnd),
    };
  }

  WorkScheduleData copyWith({
    int? id,
    int? employeeId,
    int? dayOfWeek,
    String? startTime,
    String? endTime,
    Value<String?> breakStart = const Value.absent(),
    Value<String?> breakEnd = const Value.absent(),
  }) => WorkScheduleData(
    id: id ?? this.id,
    employeeId: employeeId ?? this.employeeId,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    breakStart: breakStart.present ? breakStart.value : this.breakStart,
    breakEnd: breakEnd.present ? breakEnd.value : this.breakEnd,
  );
  WorkScheduleData copyWithCompanion(WorkSchedulesCompanion data) {
    return WorkScheduleData(
      id: data.id.present ? data.id.value : this.id,
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      breakStart: data.breakStart.present
          ? data.breakStart.value
          : this.breakStart,
      breakEnd: data.breakEnd.present ? data.breakEnd.value : this.breakEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkScheduleData(')
          ..write('id: $id, ')
          ..write('employeeId: $employeeId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('breakStart: $breakStart, ')
          ..write('breakEnd: $breakEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    employeeId,
    dayOfWeek,
    startTime,
    endTime,
    breakStart,
    breakEnd,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkScheduleData &&
          other.id == this.id &&
          other.employeeId == this.employeeId &&
          other.dayOfWeek == this.dayOfWeek &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.breakStart == this.breakStart &&
          other.breakEnd == this.breakEnd);
}

class WorkSchedulesCompanion extends UpdateCompanion<WorkScheduleData> {
  final Value<int> id;
  final Value<int> employeeId;
  final Value<int> dayOfWeek;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<String?> breakStart;
  final Value<String?> breakEnd;
  const WorkSchedulesCompanion({
    this.id = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.breakStart = const Value.absent(),
    this.breakEnd = const Value.absent(),
  });
  WorkSchedulesCompanion.insert({
    this.id = const Value.absent(),
    required int employeeId,
    required int dayOfWeek,
    required String startTime,
    required String endTime,
    this.breakStart = const Value.absent(),
    this.breakEnd = const Value.absent(),
  }) : employeeId = Value(employeeId),
       dayOfWeek = Value(dayOfWeek),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<WorkScheduleData> custom({
    Expression<int>? id,
    Expression<int>? employeeId,
    Expression<int>? dayOfWeek,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<String>? breakStart,
    Expression<String>? breakEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeId != null) 'employee_id': employeeId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (breakStart != null) 'break_start': breakStart,
      if (breakEnd != null) 'break_end': breakEnd,
    });
  }

  WorkSchedulesCompanion copyWith({
    Value<int>? id,
    Value<int>? employeeId,
    Value<int>? dayOfWeek,
    Value<String>? startTime,
    Value<String>? endTime,
    Value<String?>? breakStart,
    Value<String?>? breakEnd,
  }) {
    return WorkSchedulesCompanion(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      breakStart: breakStart ?? this.breakStart,
      breakEnd: breakEnd ?? this.breakEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<int>(employeeId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (breakStart.present) {
      map['break_start'] = Variable<String>(breakStart.value);
    }
    if (breakEnd.present) {
      map['break_end'] = Variable<String>(breakEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('employeeId: $employeeId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('breakStart: $breakStart, ')
          ..write('breakEnd: $breakEnd')
          ..write(')'))
        .toString();
  }
}

class $HolidaysTable extends Holidays
    with TableInfo<$HolidaysTable, HolidayData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HolidaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _holidayDateMeta = const VerificationMeta(
    'holidayDate',
  );
  @override
  late final GeneratedColumn<String> holidayDate = GeneratedColumn<String>(
    'holiday_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, holidayDate, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'holidays';
  @override
  VerificationContext validateIntegrity(
    Insertable<HolidayData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('holiday_date')) {
      context.handle(
        _holidayDateMeta,
        holidayDate.isAcceptableOrUnknown(
          data['holiday_date']!,
          _holidayDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_holidayDateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HolidayData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HolidayData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      holidayDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}holiday_date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $HolidaysTable createAlias(String alias) {
    return $HolidaysTable(attachedDatabase, alias);
  }
}

class HolidayData extends DataClass implements Insertable<HolidayData> {
  final int id;
  final String name;
  final String holidayDate;
  final String? description;
  const HolidayData({
    required this.id,
    required this.name,
    required this.holidayDate,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['holiday_date'] = Variable<String>(holidayDate);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  HolidaysCompanion toCompanion(bool nullToAbsent) {
    return HolidaysCompanion(
      id: Value(id),
      name: Value(name),
      holidayDate: Value(holidayDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory HolidayData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HolidayData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      holidayDate: serializer.fromJson<String>(json['holidayDate']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'holidayDate': serializer.toJson<String>(holidayDate),
      'description': serializer.toJson<String?>(description),
    };
  }

  HolidayData copyWith({
    int? id,
    String? name,
    String? holidayDate,
    Value<String?> description = const Value.absent(),
  }) => HolidayData(
    id: id ?? this.id,
    name: name ?? this.name,
    holidayDate: holidayDate ?? this.holidayDate,
    description: description.present ? description.value : this.description,
  );
  HolidayData copyWithCompanion(HolidaysCompanion data) {
    return HolidayData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      holidayDate: data.holidayDate.present
          ? data.holidayDate.value
          : this.holidayDate,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HolidayData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('holidayDate: $holidayDate, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, holidayDate, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HolidayData &&
          other.id == this.id &&
          other.name == this.name &&
          other.holidayDate == this.holidayDate &&
          other.description == this.description);
}

class HolidaysCompanion extends UpdateCompanion<HolidayData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> holidayDate;
  final Value<String?> description;
  const HolidaysCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.holidayDate = const Value.absent(),
    this.description = const Value.absent(),
  });
  HolidaysCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String holidayDate,
    this.description = const Value.absent(),
  }) : name = Value(name),
       holidayDate = Value(holidayDate);
  static Insertable<HolidayData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? holidayDate,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (holidayDate != null) 'holiday_date': holidayDate,
      if (description != null) 'description': description,
    });
  }

  HolidaysCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? holidayDate,
    Value<String?>? description,
  }) {
    return HolidaysCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      holidayDate: holidayDate ?? this.holidayDate,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (holidayDate.present) {
      map['holiday_date'] = Variable<String>(holidayDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HolidaysCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('holidayDate: $holidayDate, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSettingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _settingKeyMeta = const VerificationMeta(
    'settingKey',
  );
  @override
  late final GeneratedColumn<String> settingKey = GeneratedColumn<String>(
    'setting_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _settingValueMeta = const VerificationMeta(
    'settingValue',
  );
  @override
  late final GeneratedColumn<String> settingValue = GeneratedColumn<String>(
    'setting_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, settingKey, settingValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('setting_key')) {
      context.handle(
        _settingKeyMeta,
        settingKey.isAcceptableOrUnknown(data['setting_key']!, _settingKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_settingKeyMeta);
    }
    if (data.containsKey('setting_value')) {
      context.handle(
        _settingValueMeta,
        settingValue.isAcceptableOrUnknown(
          data['setting_value']!,
          _settingValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_settingValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      settingKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setting_key'],
      )!,
      settingValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setting_value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSettingData extends DataClass implements Insertable<AppSettingData> {
  final int id;
  final String settingKey;
  final String settingValue;
  const AppSettingData({
    required this.id,
    required this.settingKey,
    required this.settingValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['setting_key'] = Variable<String>(settingKey);
    map['setting_value'] = Variable<String>(settingValue);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      settingKey: Value(settingKey),
      settingValue: Value(settingValue),
    );
  }

  factory AppSettingData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingData(
      id: serializer.fromJson<int>(json['id']),
      settingKey: serializer.fromJson<String>(json['settingKey']),
      settingValue: serializer.fromJson<String>(json['settingValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'settingKey': serializer.toJson<String>(settingKey),
      'settingValue': serializer.toJson<String>(settingValue),
    };
  }

  AppSettingData copyWith({
    int? id,
    String? settingKey,
    String? settingValue,
  }) => AppSettingData(
    id: id ?? this.id,
    settingKey: settingKey ?? this.settingKey,
    settingValue: settingValue ?? this.settingValue,
  );
  AppSettingData copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingData(
      id: data.id.present ? data.id.value : this.id,
      settingKey: data.settingKey.present
          ? data.settingKey.value
          : this.settingKey,
      settingValue: data.settingValue.present
          ? data.settingValue.value
          : this.settingValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingData(')
          ..write('id: $id, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, settingKey, settingValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingData &&
          other.id == this.id &&
          other.settingKey == this.settingKey &&
          other.settingValue == this.settingValue);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingData> {
  final Value<int> id;
  final Value<String> settingKey;
  final Value<String> settingValue;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.settingKey = const Value.absent(),
    this.settingValue = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String settingKey,
    required String settingValue,
  }) : settingKey = Value(settingKey),
       settingValue = Value(settingValue);
  static Insertable<AppSettingData> custom({
    Expression<int>? id,
    Expression<String>? settingKey,
    Expression<String>? settingValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (settingKey != null) 'setting_key': settingKey,
      if (settingValue != null) 'setting_value': settingValue,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? settingKey,
    Value<String>? settingValue,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      settingKey: settingKey ?? this.settingKey,
      settingValue: settingValue ?? this.settingValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (settingKey.present) {
      map['setting_key'] = Variable<String>(settingKey.value);
    }
    if (settingValue.present) {
      map['setting_value'] = Variable<String>(settingValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $AttendanceTable attendance = $AttendanceTable(this);
  late final $WorkSchedulesTable workSchedules = $WorkSchedulesTable(this);
  late final $HolidaysTable holidays = $HolidaysTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final EmployeesDao employeesDao = EmployeesDao(this as AppDatabase);
  late final AttendanceDao attendanceDao = AttendanceDao(this as AppDatabase);
  late final WorkSchedulesDao workSchedulesDao = WorkSchedulesDao(
    this as AppDatabase,
  );
  late final AppSettingsDao appSettingsDao = AppSettingsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    employees,
    attendance,
    workSchedules,
    holidays,
    appSettings,
  ];
}

typedef $$EmployeesTableCreateCompanionBuilder =
    EmployeesCompanion Function({
      Value<int> id,
      required String employeeCode,
      required String name,
      required String email,
      required String passwordHash,
      Value<String?> department,
      Value<String?> position,
      Value<String?> photoPath,
      required int createdAt,
      required int updatedAt,
    });
typedef $$EmployeesTableUpdateCompanionBuilder =
    EmployeesCompanion Function({
      Value<int> id,
      Value<String> employeeCode,
      Value<String> name,
      Value<String> email,
      Value<String> passwordHash,
      Value<String?> department,
      Value<String?> position,
      Value<String?> photoPath,
      Value<int> createdAt,
      Value<int> updatedAt,
    });

final class $$EmployeesTableReferences
    extends BaseReferences<_$AppDatabase, $EmployeesTable, Employee> {
  $$EmployeesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AttendanceTable, List<AttendanceRecord>>
  _attendanceRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.attendance,
    aliasName: 'employees__id__attendance__employee_id',
  );

  $$AttendanceTableProcessedTableManager get attendanceRefs {
    final manager = $$AttendanceTableTableManager(
      $_db,
      $_db.attendance,
    ).filter((f) => f.employeeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attendanceRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkSchedulesTable, List<WorkScheduleData>>
  _workSchedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workSchedules,
    aliasName: 'employees__id__work_schedules__employee_id',
  );

  $$WorkSchedulesTableProcessedTableManager get workSchedulesRefs {
    final manager = $$WorkSchedulesTableTableManager(
      $_db,
      $_db.workSchedules,
    ).filter((f) => f.employeeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workSchedulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EmployeesTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get employeeCode => $composableBuilder(
    column: $table.employeeCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> attendanceRefs(
    Expression<bool> Function($$AttendanceTableFilterComposer f) f,
  ) {
    final $$AttendanceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendance,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableFilterComposer(
            $db: $db,
            $table: $db.attendance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workSchedulesRefs(
    Expression<bool> Function($$WorkSchedulesTableFilterComposer f) f,
  ) {
    final $$WorkSchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workSchedules,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkSchedulesTableFilterComposer(
            $db: $db,
            $table: $db.workSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmployeesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get employeeCode => $composableBuilder(
    column: $table.employeeCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmployeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get employeeCode => $composableBuilder(
    column: $table.employeeCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => column,
  );

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> attendanceRefs<T extends Object>(
    Expression<T> Function($$AttendanceTableAnnotationComposer a) f,
  ) {
    final $$AttendanceTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendance,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableAnnotationComposer(
            $db: $db,
            $table: $db.attendance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workSchedulesRefs<T extends Object>(
    Expression<T> Function($$WorkSchedulesTableAnnotationComposer a) f,
  ) {
    final $$WorkSchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workSchedules,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkSchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.workSchedules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmployeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmployeesTable,
          Employee,
          $$EmployeesTableFilterComposer,
          $$EmployeesTableOrderingComposer,
          $$EmployeesTableAnnotationComposer,
          $$EmployeesTableCreateCompanionBuilder,
          $$EmployeesTableUpdateCompanionBuilder,
          (Employee, $$EmployeesTableReferences),
          Employee,
          PrefetchHooks Function({bool attendanceRefs, bool workSchedulesRefs})
        > {
  $$EmployeesTableTableManager(_$AppDatabase db, $EmployeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> employeeCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String?> department = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
              }) => EmployeesCompanion(
                id: id,
                employeeCode: employeeCode,
                name: name,
                email: email,
                passwordHash: passwordHash,
                department: department,
                position: position,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String employeeCode,
                required String name,
                required String email,
                required String passwordHash,
                Value<String?> department = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                required int createdAt,
                required int updatedAt,
              }) => EmployeesCompanion.insert(
                id: id,
                employeeCode: employeeCode,
                name: name,
                email: email,
                passwordHash: passwordHash,
                department: department,
                position: position,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EmployeesTable, Employee>(table),
                  $$EmployeesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({attendanceRefs = false, workSchedulesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (attendanceRefs) db.attendance,
                    if (workSchedulesRefs) db.workSchedules,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (attendanceRefs)
                        await $_getPrefetchedDataByColumns<
                          Employee,
                          $EmployeesTable,
                          AttendanceRecord,
                          $AttendanceTable
                        >(
                          currentTable: table,
                          referencedTable: $$EmployeesTableReferences
                              ._attendanceRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EmployeesTableReferences(
                                db,
                                table,
                                p0,
                              ).attendanceRefs,
                          currentColumn: 'id',
                          referencedColumn: 'employee_id',
                          typedResults: items,
                        ),
                      if (workSchedulesRefs)
                        await $_getPrefetchedDataByColumns<
                          Employee,
                          $EmployeesTable,
                          WorkScheduleData,
                          $WorkSchedulesTable
                        >(
                          currentTable: table,
                          referencedTable: $$EmployeesTableReferences
                              ._workSchedulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EmployeesTableReferences(
                                db,
                                table,
                                p0,
                              ).workSchedulesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'employee_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EmployeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmployeesTable,
      Employee,
      $$EmployeesTableFilterComposer,
      $$EmployeesTableOrderingComposer,
      $$EmployeesTableAnnotationComposer,
      $$EmployeesTableCreateCompanionBuilder,
      $$EmployeesTableUpdateCompanionBuilder,
      (Employee, $$EmployeesTableReferences),
      Employee,
      PrefetchHooks Function({bool attendanceRefs, bool workSchedulesRefs})
    >;
typedef $$AttendanceTableCreateCompanionBuilder =
    AttendanceCompanion Function({
      Value<int> id,
      required int employeeId,
      required String attendanceDate,
      Value<int?> checkIn,
      Value<int?> checkOut,
      Value<int> checkInFaceDetected,
      Value<int> checkOutFaceDetected,
      Value<String?> checkInPhotoPath,
      Value<String?> checkOutPhotoPath,
      required String status,
      Value<String?> notes,
      required int createdAt,
      required int updatedAt,
    });
typedef $$AttendanceTableUpdateCompanionBuilder =
    AttendanceCompanion Function({
      Value<int> id,
      Value<int> employeeId,
      Value<String> attendanceDate,
      Value<int?> checkIn,
      Value<int?> checkOut,
      Value<int> checkInFaceDetected,
      Value<int> checkOutFaceDetected,
      Value<String?> checkInPhotoPath,
      Value<String?> checkOutPhotoPath,
      Value<String> status,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int> updatedAt,
    });

final class $$AttendanceTableReferences
    extends BaseReferences<_$AppDatabase, $AttendanceTable, AttendanceRecord> {
  $$AttendanceTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EmployeesTable _employeeIdTable(_$AppDatabase db) =>
      db.employees.createAlias('attendance__employee_id__employees__id');

  $$EmployeesTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<int>('employee_id')!;

    final manager = $$EmployeesTableTableManager(
      $_db,
      $_db.employees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttendanceTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attendanceDate => $composableBuilder(
    column: $table.attendanceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkIn => $composableBuilder(
    column: $table.checkIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkOut => $composableBuilder(
    column: $table.checkOut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkInFaceDetected => $composableBuilder(
    column: $table.checkInFaceDetected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkOutFaceDetected => $composableBuilder(
    column: $table.checkOutFaceDetected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkInPhotoPath => $composableBuilder(
    column: $table.checkInPhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkOutPhotoPath => $composableBuilder(
    column: $table.checkOutPhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EmployeesTableFilterComposer get employeeId {
    final $$EmployeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableFilterComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attendanceDate => $composableBuilder(
    column: $table.attendanceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkIn => $composableBuilder(
    column: $table.checkIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkOut => $composableBuilder(
    column: $table.checkOut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkInFaceDetected => $composableBuilder(
    column: $table.checkInFaceDetected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkOutFaceDetected => $composableBuilder(
    column: $table.checkOutFaceDetected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkInPhotoPath => $composableBuilder(
    column: $table.checkInPhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkOutPhotoPath => $composableBuilder(
    column: $table.checkOutPhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EmployeesTableOrderingComposer get employeeId {
    final $$EmployeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableOrderingComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get attendanceDate => $composableBuilder(
    column: $table.attendanceDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get checkIn =>
      $composableBuilder(column: $table.checkIn, builder: (column) => column);

  GeneratedColumn<int> get checkOut =>
      $composableBuilder(column: $table.checkOut, builder: (column) => column);

  GeneratedColumn<int> get checkInFaceDetected => $composableBuilder(
    column: $table.checkInFaceDetected,
    builder: (column) => column,
  );

  GeneratedColumn<int> get checkOutFaceDetected => $composableBuilder(
    column: $table.checkOutFaceDetected,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checkInPhotoPath => $composableBuilder(
    column: $table.checkInPhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checkOutPhotoPath => $composableBuilder(
    column: $table.checkOutPhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$EmployeesTableAnnotationComposer get employeeId {
    final $$EmployeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableAnnotationComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceTable,
          AttendanceRecord,
          $$AttendanceTableFilterComposer,
          $$AttendanceTableOrderingComposer,
          $$AttendanceTableAnnotationComposer,
          $$AttendanceTableCreateCompanionBuilder,
          $$AttendanceTableUpdateCompanionBuilder,
          (AttendanceRecord, $$AttendanceTableReferences),
          AttendanceRecord,
          PrefetchHooks Function({bool employeeId})
        > {
  $$AttendanceTableTableManager(_$AppDatabase db, $AttendanceTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> employeeId = const Value.absent(),
                Value<String> attendanceDate = const Value.absent(),
                Value<int?> checkIn = const Value.absent(),
                Value<int?> checkOut = const Value.absent(),
                Value<int> checkInFaceDetected = const Value.absent(),
                Value<int> checkOutFaceDetected = const Value.absent(),
                Value<String?> checkInPhotoPath = const Value.absent(),
                Value<String?> checkOutPhotoPath = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
              }) => AttendanceCompanion(
                id: id,
                employeeId: employeeId,
                attendanceDate: attendanceDate,
                checkIn: checkIn,
                checkOut: checkOut,
                checkInFaceDetected: checkInFaceDetected,
                checkOutFaceDetected: checkOutFaceDetected,
                checkInPhotoPath: checkInPhotoPath,
                checkOutPhotoPath: checkOutPhotoPath,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int employeeId,
                required String attendanceDate,
                Value<int?> checkIn = const Value.absent(),
                Value<int?> checkOut = const Value.absent(),
                Value<int> checkInFaceDetected = const Value.absent(),
                Value<int> checkOutFaceDetected = const Value.absent(),
                Value<String?> checkInPhotoPath = const Value.absent(),
                Value<String?> checkOutPhotoPath = const Value.absent(),
                required String status,
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                required int updatedAt,
              }) => AttendanceCompanion.insert(
                id: id,
                employeeId: employeeId,
                attendanceDate: attendanceDate,
                checkIn: checkIn,
                checkOut: checkOut,
                checkInFaceDetected: checkInFaceDetected,
                checkOutFaceDetected: checkOutFaceDetected,
                checkInPhotoPath: checkInPhotoPath,
                checkOutPhotoPath: checkOutPhotoPath,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttendanceTable, AttendanceRecord>(table),
                  $$AttendanceTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (employeeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.employeeId,
                                referencedTable: $$AttendanceTableReferences
                                    ._employeeIdTable(db),
                                referencedColumn: $$AttendanceTableReferences
                                    ._employeeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttendanceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceTable,
      AttendanceRecord,
      $$AttendanceTableFilterComposer,
      $$AttendanceTableOrderingComposer,
      $$AttendanceTableAnnotationComposer,
      $$AttendanceTableCreateCompanionBuilder,
      $$AttendanceTableUpdateCompanionBuilder,
      (AttendanceRecord, $$AttendanceTableReferences),
      AttendanceRecord,
      PrefetchHooks Function({bool employeeId})
    >;
typedef $$WorkSchedulesTableCreateCompanionBuilder =
    WorkSchedulesCompanion Function({
      Value<int> id,
      required int employeeId,
      required int dayOfWeek,
      required String startTime,
      required String endTime,
      Value<String?> breakStart,
      Value<String?> breakEnd,
    });
typedef $$WorkSchedulesTableUpdateCompanionBuilder =
    WorkSchedulesCompanion Function({
      Value<int> id,
      Value<int> employeeId,
      Value<int> dayOfWeek,
      Value<String> startTime,
      Value<String> endTime,
      Value<String?> breakStart,
      Value<String?> breakEnd,
    });

final class $$WorkSchedulesTableReferences
    extends
        BaseReferences<_$AppDatabase, $WorkSchedulesTable, WorkScheduleData> {
  $$WorkSchedulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EmployeesTable _employeeIdTable(_$AppDatabase db) =>
      db.employees.createAlias('work_schedules__employee_id__employees__id');

  $$EmployeesTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<int>('employee_id')!;

    final manager = $$EmployeesTableTableManager(
      $_db,
      $_db.employees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkSchedulesTable> {
  $$WorkSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breakStart => $composableBuilder(
    column: $table.breakStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breakEnd => $composableBuilder(
    column: $table.breakEnd,
    builder: (column) => ColumnFilters(column),
  );

  $$EmployeesTableFilterComposer get employeeId {
    final $$EmployeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableFilterComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkSchedulesTable> {
  $$WorkSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breakStart => $composableBuilder(
    column: $table.breakStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breakEnd => $composableBuilder(
    column: $table.breakEnd,
    builder: (column) => ColumnOrderings(column),
  );

  $$EmployeesTableOrderingComposer get employeeId {
    final $$EmployeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableOrderingComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkSchedulesTable> {
  $$WorkSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get breakStart => $composableBuilder(
    column: $table.breakStart,
    builder: (column) => column,
  );

  GeneratedColumn<String> get breakEnd =>
      $composableBuilder(column: $table.breakEnd, builder: (column) => column);

  $$EmployeesTableAnnotationComposer get employeeId {
    final $$EmployeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableAnnotationComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkSchedulesTable,
          WorkScheduleData,
          $$WorkSchedulesTableFilterComposer,
          $$WorkSchedulesTableOrderingComposer,
          $$WorkSchedulesTableAnnotationComposer,
          $$WorkSchedulesTableCreateCompanionBuilder,
          $$WorkSchedulesTableUpdateCompanionBuilder,
          (WorkScheduleData, $$WorkSchedulesTableReferences),
          WorkScheduleData,
          PrefetchHooks Function({bool employeeId})
        > {
  $$WorkSchedulesTableTableManager(_$AppDatabase db, $WorkSchedulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkSchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> employeeId = const Value.absent(),
                Value<int> dayOfWeek = const Value.absent(),
                Value<String> startTime = const Value.absent(),
                Value<String> endTime = const Value.absent(),
                Value<String?> breakStart = const Value.absent(),
                Value<String?> breakEnd = const Value.absent(),
              }) => WorkSchedulesCompanion(
                id: id,
                employeeId: employeeId,
                dayOfWeek: dayOfWeek,
                startTime: startTime,
                endTime: endTime,
                breakStart: breakStart,
                breakEnd: breakEnd,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int employeeId,
                required int dayOfWeek,
                required String startTime,
                required String endTime,
                Value<String?> breakStart = const Value.absent(),
                Value<String?> breakEnd = const Value.absent(),
              }) => WorkSchedulesCompanion.insert(
                id: id,
                employeeId: employeeId,
                dayOfWeek: dayOfWeek,
                startTime: startTime,
                endTime: endTime,
                breakStart: breakStart,
                breakEnd: breakEnd,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkSchedulesTable, WorkScheduleData>(table),
                  $$WorkSchedulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (employeeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.employeeId,
                                referencedTable: $$WorkSchedulesTableReferences
                                    ._employeeIdTable(db),
                                referencedColumn: $$WorkSchedulesTableReferences
                                    ._employeeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkSchedulesTable,
      WorkScheduleData,
      $$WorkSchedulesTableFilterComposer,
      $$WorkSchedulesTableOrderingComposer,
      $$WorkSchedulesTableAnnotationComposer,
      $$WorkSchedulesTableCreateCompanionBuilder,
      $$WorkSchedulesTableUpdateCompanionBuilder,
      (WorkScheduleData, $$WorkSchedulesTableReferences),
      WorkScheduleData,
      PrefetchHooks Function({bool employeeId})
    >;
typedef $$HolidaysTableCreateCompanionBuilder =
    HolidaysCompanion Function({
      Value<int> id,
      required String name,
      required String holidayDate,
      Value<String?> description,
    });
typedef $$HolidaysTableUpdateCompanionBuilder =
    HolidaysCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> holidayDate,
      Value<String?> description,
    });

class $$HolidaysTableFilterComposer
    extends Composer<_$AppDatabase, $HolidaysTable> {
  $$HolidaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get holidayDate => $composableBuilder(
    column: $table.holidayDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HolidaysTableOrderingComposer
    extends Composer<_$AppDatabase, $HolidaysTable> {
  $$HolidaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get holidayDate => $composableBuilder(
    column: $table.holidayDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HolidaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $HolidaysTable> {
  $$HolidaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get holidayDate => $composableBuilder(
    column: $table.holidayDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$HolidaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HolidaysTable,
          HolidayData,
          $$HolidaysTableFilterComposer,
          $$HolidaysTableOrderingComposer,
          $$HolidaysTableAnnotationComposer,
          $$HolidaysTableCreateCompanionBuilder,
          $$HolidaysTableUpdateCompanionBuilder,
          (
            HolidayData,
            BaseReferences<_$AppDatabase, $HolidaysTable, HolidayData>,
          ),
          HolidayData,
          PrefetchHooks Function()
        > {
  $$HolidaysTableTableManager(_$AppDatabase db, $HolidaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HolidaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HolidaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HolidaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> holidayDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => HolidaysCompanion(
                id: id,
                name: name,
                holidayDate: holidayDate,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String holidayDate,
                Value<String?> description = const Value.absent(),
              }) => HolidaysCompanion.insert(
                id: id,
                name: name,
                holidayDate: holidayDate,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HolidaysTable, HolidayData>(table),
                  BaseReferences<_$AppDatabase, $HolidaysTable, HolidayData>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HolidaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HolidaysTable,
      HolidayData,
      $$HolidaysTableFilterComposer,
      $$HolidaysTableOrderingComposer,
      $$HolidaysTableAnnotationComposer,
      $$HolidaysTableCreateCompanionBuilder,
      $$HolidaysTableUpdateCompanionBuilder,
      (HolidayData, BaseReferences<_$AppDatabase, $HolidaysTable, HolidayData>),
      HolidayData,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      required String settingKey,
      required String settingValue,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> settingKey,
      Value<String> settingValue,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settingValue => $composableBuilder(
    column: $table.settingValue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settingValue => $composableBuilder(
    column: $table.settingValue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get settingValue => $composableBuilder(
    column: $table.settingValue,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSettingData,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSettingData,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingData>,
          ),
          AppSettingData,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> settingKey = const Value.absent(),
                Value<String> settingValue = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                settingKey: settingKey,
                settingValue: settingValue,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String settingKey,
                required String settingValue,
              }) => AppSettingsCompanion.insert(
                id: id,
                settingKey: settingKey,
                settingValue: settingValue,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSettingData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppSettingsTable,
                    AppSettingData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSettingData,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSettingData,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingData>,
      ),
      AppSettingData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
  $$AttendanceTableTableManager get attendance =>
      $$AttendanceTableTableManager(_db, _db.attendance);
  $$WorkSchedulesTableTableManager get workSchedules =>
      $$WorkSchedulesTableTableManager(_db, _db.workSchedules);
  $$HolidaysTableTableManager get holidays =>
      $$HolidaysTableTableManager(_db, _db.holidays);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
