require "administrate/base_dashboard"

class AttemptedQuestionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    objective: Field::BelongsTo,
    user: Field::BelongsTo,
    question: Field::HasOne,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :objective,
    :user,
    :question,
    :id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :objective,
    :user,
    :question,
  ]

  # Overwrite this method to customize how attempted questions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(attempted_question)
  #   "AttemptedQuestion ##{attempted_question.id}"
  # end
end
