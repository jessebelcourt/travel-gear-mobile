List<String> initialMigrations = [
  migration_0000_0001,
];

String migration_0000_0001 = '''
  CREATE TABLE user (
    local_id INTEGER PRIMARY KEY AUTOINCREMENT,
    remote_id INTEGER,
    name TEXT,
    email TEXT,
    profile_pic TEXT,
    bio TEXT,
    token TEXT
  )
''';