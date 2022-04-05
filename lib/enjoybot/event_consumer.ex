defmodule Enjoybot.EventConsumer do
  @moduledoc false
  use Nostrum.Consumer

  alias Nostrum.Api
  alias Enjoybot.EventConsumer.CommandHandler

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    if is_bot_message?(msg) do
      :ignore
    else
      case CommandHandler.handle_message(msg) do
        {:error, :not_command, _} ->
          :ignore

        {:error, :unknown_command, reply} ->
          Api.create_message(
            msg.channel_id,
            "🚫 unknown command, known subcommands: `#{reply}`"
          )

        {:ok, command, args} ->
          CommandHandler.fetch_command(command, args, msg)
      end
    end
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end

  defp is_bot_message?(msg) do
    msg.author.bot
  end
end
