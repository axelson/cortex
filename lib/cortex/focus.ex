defmodule Cortex.Focus do
  @type t :: %__MODULE__{
          path: String.t() | nil,
          line: pos_integer | nil,
          regex: Regex.t() | nil
        }

  defstruct [:path, :line, :regex]

  @spec new :: t
  def new do
    %__MODULE__{}
  end

  def empty?(%__MODULE__{path: nil, line: nil, regex: nil}), do: true
  def empty?(%__MODULE__{}), do: false

  def to_exunit_config(%__MODULE__{} = focus) do
    %__MODULE__{line: line, regex: regex} = focus

    cond do
      regex -> [exclude: [:test], include: [test: regex]]
      line -> [exclude: [:test], include: [line: line]]
      true -> []
    end
  end
end
