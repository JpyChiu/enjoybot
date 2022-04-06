defmodule Enjoybot.EventConsumer.CommandHandler do
  @moduledoc false
  alias Nostrum.Api

  @exist_commands ["!uptime", "!hello", "!help"]

  @spec handle_message(Nostrum.Struct.Message.t()) ::
          {:error, :not_command | :unknown_command, String.t()}
          | {:ok, binary, list(String.t())}
  def handle_message(msg) do
    [command | rest] = String.split(msg.content, " ")

    cond do
      not String.starts_with?(command, "!") ->
        {:error, :not_command, ""}

      command not in @exist_commands ->
        {:error, :unknown_command, Enum.join(@exist_commands, ", ")}

      true ->
        {:ok, command, rest}
    end
  end

  def fetch_command("!help", [], msg) do
    Api.create_message(msg.channel_id, "!uptime\n!hello")
  end

  def fetch_command("!uptime", [], msg) do
    Api.create_message(msg.channel_id, "Don't ask me")
  end

  def fetch_command("!hello", [], msg) do
    Api.create_message(msg.channel_id, "Hi #{msg.author.username}")
  end

  def fetch_command(_, _, _), do: :ignore
end
