handle_open = fn
  {:ok, file} -> "First line: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

IO.puts handle_open.(File.open("kambing.txt")) # call with a file that exists IO.puts handle_open.(File.open("nonexistent")) # and then with one that doesn't
IO.puts handle_open.(File.open("Rakefile")) # call with functions that doesn't exists
