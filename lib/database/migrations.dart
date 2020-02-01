List<Map<String, dynamic>> migrations = [
  migration_0000_0001,
];

Map<String, dynamic> migration_0000_0001 = {
  'version': 3,
  'migration': '''
    CREATE TABLE user (
    local_id INTEGER PRIMARY KEY AUTOINCREMENT,
    remote_id INTEGER,
    name TEXT,
    email TEXT,
    profile_pic TEXT,
    bio TEXT,
    token TEXT
  )
  '''
};