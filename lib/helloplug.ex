defmodule Helloplug do
  def init(default_opts) do
    IO.puts "starting up Helloplug..."
    default_opts
  end

  def call(conn, _opts) do
    route(conn.method, conn.path_info, conn)
  end

  def route("GET", ["hello"], conn) do
    # this route is for /hello
    conn |> Plug.Conn.send_resp(200, "Hello World")
  end

  def route("GET", ["users", user_id], conn) do
    # this route is for /users/<user_id>
    conn |> Plug.Conn.send_resp(200, "You requested user #{user_id}")
  end

  def route(_method, _path, conn) do
    # this route is called if no other routes match
    conn |> Plug.Conn.send_resp(404, "Couldn't find that page, sorry!")
  end

end
