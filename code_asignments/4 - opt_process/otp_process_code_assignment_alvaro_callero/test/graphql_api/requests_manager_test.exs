defmodule GraphqlApi.RequestsManagerTest do
  use ExUnit.Case

  alias GraphqlApi.RequestsManager

  setup do
    {:ok, pid} = RequestsManager.start_link(name: RMTest)
    %{pid: pid}
  end

  describe "&add_request_hit/2" do
    test "add a hit to the requests counter", %{pid: pid} do
      assert RequestsManager.get_request_hits(pid, "users") === nil
      RequestsManager.add_request_hit(pid, "users")
      RequestsManager.add_request_hit(pid, "users")
      RequestsManager.add_request_hit(pid, "users")
      assert RequestsManager.get_request_hits(pid, "users") === 3
    end
  end
end
