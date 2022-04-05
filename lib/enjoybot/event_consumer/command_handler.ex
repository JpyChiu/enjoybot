defmodule Enjoybot.EventConsumer.CommandHandler do
  @moduledoc false
  alias Nostrum.Api

  @exist_commands ["!ping", "!hello", "!help"]

  @spec handle_message(Nostrum.Struct.Message.t()) ::
          {:error, :not_command | :unknown_command, Nostrum.Struct.Message.t()}
          | {:ok, binary, list(String.t())}
  def handle_message(msg) do
    [command | rest] = String.split(msg.content, " ")

    cond do
      not String.starts_with?(command, "!") ->
        {:error, :not_command, msg}

      command not in @exist_commands ->
        {:error, :unknown_command, Enum.join(@exist_commands, ", ")}

      true ->
        {:ok, command, rest}
    end
  end

  def fetch_command("!help", [], msg) do
    Api.create_message(msg.channel_id, "!ping\n!hello")
  end

  def fetch_command("!ping", [], msg) do
    Api.create_message(msg.channel_id, "pyongyang!")
  end

  def fetch_command("!hello", [], msg) do
    Api.create_message(msg.channel_id, "Hi #{msg.author.username}")
  end

  def fetch_command(_, _, _), do: :ignore
end
