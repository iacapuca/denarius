defmodule Denarius.Utils.Clock do
  @moduledoc """
  Provides functions that are able to return a freezed DateTime
  Such as `utc_now/0` and `freeze/0`
  """
  def utc_now do
    Process.get(:mock_utc_now) || DateTime.utc_now()
  end

  def freeze do
    Process.put(:mock_utc_now, utc_now())
  end
end
