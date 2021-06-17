defmodule AppLiveview.Repo do
  use Ecto.Repo,
    otp_app: :app_liveview,
    adapter: Ecto.Adapters.Postgres
end
