defmodule Router do
  defmacro __using__(_opts) do
    quote do
      def init(options) do
        options
      end
      def call(conn, _opts) do
        route(conn.method, conn.path_info, conn)
      end
    end
  end
end

defmodule UserRouter do
  use Router
  def route("GET", ["users", user_id], conn) do
    # this route is for /users/<user_id>
    page_contents = EEx.eval_file("templates/show_user.eex", [user_id: user_id])
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_contents)
  end

  def route(_method, _path, conn) do
    # this route is called if no other routes match
    conn |> Plug.Conn.send_resp(404, "Couldn't find that user page, sorry!")
  end
end

defmodule WebsiteRouter do
  use Router

  @user_router_options UserRouter.init([])
  def route("GET", ["users" | path], conn) do
    UserRouter.call(conn, @user_router_options)
  end
  def route("GET", ["hello"], conn) do
    # this route is for /hello
    conn |> Plug.Conn.send_resp(200, "This is the Hello World page!")
  end
  def route(_method, _path, conn) do
    # this route is called if no other routes match
    conn |> Plug.Conn.send_resp(404, "Couldn't find that page, sorry!")
  end
end
