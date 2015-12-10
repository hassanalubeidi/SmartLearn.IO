require "administrate/base_dashboard"

class QuestionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    topic: Field::BelongsTo,
    main_question: Field::BelongsTo,
    answers: Field::HasMany,
    test_paper: Field::BelongsTo,
    lines: Field::HasMany,
    objectives: Field::HasMany,
    id: Field::Number,
    text: Field::Text,
    total_marks: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    attachment_file_name: Field::String,
    attachment_content_type: Field::String,
    attachment_file_size: Field::Number,
    attachment_updated_at: Field::DateTime,
    html: Field::Text,
    mark_scheme_html: Field::Text,
    exam_notes_html: Field::Text,
    source: Field::Text,
    description: Field::Text,
    type: Field::Text,
    intervention: Field::Text,
    position: Field::String,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :topic,
    :main_question,
    :answers,
    :test_paper,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :topic,
    :main_question,
    :answers,
    :test_paper,
    :lines,
    :objectives,
    :text,
    :total_marks,
    :attachment_file_name,
    :attachment_content_type,
    :attachment_file_size,
    :attachment_updated_at,
    :html,
    :mark_scheme_html,
    :exam_notes_html,
    :source,
    :description,
    :type,
    :intervention,
    :position,
  ]

  # Overwrite this method to customize how questions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(question)
  #   "Question ##{question.id}"
  # end
end
