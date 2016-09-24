use Mix.Config

config :maru, Misaka.API,
  versioning: [
    using: :accept_version_header
  ],
  http: [
    port: 9999,
  ]
