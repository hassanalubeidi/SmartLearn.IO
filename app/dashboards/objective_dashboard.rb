require "administrate/base_dashboard"

class ObjectiveDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    lines: Field::HasMany,
    questions: Field::HasMany,
    objective_states: Field::HasMany,
    flashcards: Field::HasMany,
    topic: Field::BelongsTo,
    main_questions: Field::HasMany,
    id: Field::Number,
    name: Field::Text,
    module_pack_info: Field::Text,
    total_marks: Field::Number,
    question_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    easier_difficulty: Field::Number,
    harder_difficulty: Field::Number,
    main_question_id: Field::Number,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :lines,
    :questions,
    :objective_states,
    :flashcards,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :lines,
    :questions,
    :objective_states,
    :flashcards,
    :topic,
    :main_questions,
    :name,
    :module_pack_info,
    :total_marks,
    :question_id,
    :easier_difficulty,
    :harder_difficulty,
    :main_question_id,
  ]

  # Overwrite this method to customize how objectives are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(objective)
  #   "Objective ##{objective.id}"
  # end
end
