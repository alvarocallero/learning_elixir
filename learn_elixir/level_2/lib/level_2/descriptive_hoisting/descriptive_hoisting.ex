#defmodule Level2.DescriptiveHoisting.DescriptiveHoisting do
#
#  """
#  Get the highest kill rate of a player
#"""
#  @type match :: %{kills: non_neg_integer, deaths: non_neg_integer, game_id: String.t}
#  @type kdr :: %{name: String.t, kdr: float, game_id: String.t}
#  @type player :: %{
#    name: String.t,
#    match_history: list(match)
#  }
#
#  @spec deserialize_player_from_json_and_find_match_kdr :: kdr
#  def deserialize_player_from_json_and_find_match_kdr(player_json) do
#    with{:ok, %{name: name, match_history: history}} <- Jason.deserealize(player_json) do
#      {game_id, kdr} = calculate_kdr_for_history(history)
#      %{name: name, game_id: game_id, kdr: kdr}
#    end
#
#  end
#
#  defp calculate_kdr_for_history(player_history) do
#    game_ids_and_kdrs = Enum.map(player_history, fn %{kills: kills, deaths: deaths, game_id: game_id} ->
#      {game_id, kills/deaths}
#    end)
#
#    find_highest_kdr_game(game_ids_and_kdrs)
#  end
#
#  defp find_highest_kdr_game(game_ids_and_kdrs) do
#    Enum.max_by(game_ids_and_kdrs, fn {_, kdr} ->
#     kdr
#    end)
#  end
#
#end