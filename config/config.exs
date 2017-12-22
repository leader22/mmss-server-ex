use Mix.Config

secret_key_base = 64
                  |> :crypto.strong_rand_bytes()
                  |> Base.url_encode64()
                  |> binary_part(0, 64)

config(
  :mmss_server_ex,
  mpath: {:system, "MMSS_MPATH", "/path/to/your/music/dir"},
  user: {:system, "MMSS_USER", "username"},
  pass: {:system, "MMSS_PASS", "password"},
  port: {:system, "MMSS_PORT", "9999"},
  secret_key_base: {:system, "MMSS_SECRET_KEY_BASE", secret_key_base}
)
