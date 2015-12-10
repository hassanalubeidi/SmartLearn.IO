require "administrate/base_dashboard"

class TestPaperDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    subject: Field::BelongsTo,
    questions: Field::HasMany,
    main_questions: Field::HasMany,
    id: Field::Number,
    date: Field::DateTime,
    calc_allowed: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    name: Field::String,
    test_papers: Field::String,
    important: Field::Boolean,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :subject,
    :questions,
    :main_questions,
    :id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :subject,
    :questions,
    :main_questions,
    :date,
    :calc_allowed,
    :name,
    :test_papers,
    :important,
  ]

  # Overwrite this method to customize how test papers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(test_paper)
  #   "TestPaper ##{test_paper.id}"
  # end
end
