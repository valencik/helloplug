defmodule Helloplug do
  def init(default_opts) do
    IO.puts "starting up Helloplug..."
    default_opts
  end

  def call(conn, _opts) do
    IO.puts "saying hello!"
    # Last statement of a function is returned
    conn |> Plug.Conn.put_resp_header("Server", "Plug") |> Plug.Conn.send_resp(200, "Hello, World!")
  end
end
