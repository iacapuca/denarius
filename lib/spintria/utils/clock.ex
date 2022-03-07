defmodule Spintria.Utils.Clock do
  def utc_now do
    Process.get(:mock_utc_now) || DateTime.utc_now()
  end

  def freeze do
    Process.put(:mock_utc_now, utc_now())
  end

  def freeze(%DateTime{} = on) do
    Process.put(:mock_utc_now, on)
  end

  def unfreeze do
    Process.delete(:mock_utc_now)
  end
end
