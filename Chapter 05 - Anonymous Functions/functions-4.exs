prefix = fn input ->
    fn inner_input ->
      "#{input} #{inner_input}"
    end
  end

mrs = prefix.("Mr")
IO.puts mrs.("Smith")
IO.puts prefix.("Kambing").("Enak")
