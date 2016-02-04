json.array!(@objectives) do |objective|
  json.array! objective.flashcards
end
