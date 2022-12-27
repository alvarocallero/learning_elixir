defmodule GraphqlApiWeb.Resolver.RequestsCounter do
  alias GraphqlApi.RequestsManager

  def get_requests_hits(%{key: key} = params, _) do
    hit_counter = RequestsManager.get_request_hits(key)

    if nil === hit_counter do
      {:error, %{message: "not found", details: "the key did not match with any request"}}
    else
      {:ok, hit_counter}
    end
  end
end
