-- COMMAND: schéma D1. À exécuter une seule fois dans la console SQL de la nouvelle base.
CREATE TABLE IF NOT EXISTS command_users (
  id TEXT PRIMARY KEY,
  username TEXT NOT NULL UNIQUE,
  display_name TEXT NOT NULL,
  role TEXT NOT NULL CHECK(role IN ('admin','r4r5')),
  slot INTEGER NOT NULL DEFAULT 0,
  password_hash TEXT NOT NULL,
  salt TEXT NOT NULL,
  active INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS command_users_slot_unique ON command_users(slot) WHERE role='r4r5';
CREATE TABLE IF NOT EXISTS command_sessions (
  token_hash TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  expires_at INTEGER NOT NULL,
  FOREIGN KEY(user_id) REFERENCES command_users(id) ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS command_sessions_expiry ON command_sessions(expires_at);
CREATE TABLE IF NOT EXISTS command_settings (
  setting_key TEXT PRIMARY KEY,
  setting_value TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS command_data (
  data_key TEXT PRIMARY KEY,
  data_value TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  updated_by TEXT NOT NULL
);
