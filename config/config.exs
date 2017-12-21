use Mix.Config

config(
  :mmss_server_ex,
  mpath: "/path/to/your/music/files",
  user: "username",
  pass: "password",
  port: 9999,
  secret_key_base: "-- LONG STRING WITH AT LEAST 64 BYTES --"
)

# Override
import_config("secret.exs")
