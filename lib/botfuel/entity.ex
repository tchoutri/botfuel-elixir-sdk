defmodule Botfuel.Entity do

  defstruct [sentence: "",
             dimensions: [],
             antidimensions: [],
             timezone: "",
             case_sensitive: false,
             keep_quotes: false,
             keep_accents: false
            ]

  @type t :: %__MODULE__{sentence: String.t, dimensions: [dimension()], antidimensions: [dimension()],
                             timezone: String.t, case_sensitive: boolean(), keep_quotes: boolean(), 
                             keep_accents: boolean()
                            }

  @type dimension :: :street_number | :street_type | :postal | :city | :country | :address | :language
                   | :nationality | :email | :hashtag | :number | :ordinal | :time | :duration 
                   | :distance | :area | :volume | :temperature | :forename | :family | :percentage
                   | :url | :item_count | :currency | :money | :color


  def dimensions, do: MapSet.new [:street_number, :street_type, :postal, :city, :country, :address, :language,
                                  :nationality, :email, :hashtag, :number, :ordinal, :time, :duration,
                                  :distance, :area, :volume, :temperature, :forename, :family, :percentage,
                                  :url, :item_count, :currency, :money, :color]

  @spec purify(Botfuel.Entity.t, atom()) :: map()
  def purify(params, field) do
    {values, map} = Map.pop(params, field)
    f_values = dimensions() |> MapSet.intersection(MapSet.new(values)) |> MapSet.to_list
    Map.put(map, field, f_values)
  end

  defmodule Response do
    defstruct [dim: "",
               body: "",
               values: [],
               start: 0,
               end: 0
    ]

    @type t :: %__MODULE__{dim: String.t, body: String.t, values: [String.t],
                           start: non_neg_integer(), end: non_neg_integer()
                          }
  end
end
