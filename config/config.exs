use Mix.Config

config(
  :mmss_server_ex,
  mpath: {:system, "MMSS_MPATH", "/path/to/your/music/dir"},
  user: {:system, "MMSS_USER", "username"},
  pass: {:system, "MMSS_PASS", "password"},
  port: {:system, "MMSS_PORT", "9999"}
)
