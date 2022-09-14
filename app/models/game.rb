class Game < ApplicationRecord
  has_many :BanHammers


  include PgSearch::Model
  pg_search_scope :filtering,
  against: [ :tags ],
  using: {
    tsearch: { prefix: true }
  }

  pg_search_scope :activesale,
  against: [ :active_sale ],
  using: {
    tsearch: { prefix: true }
  }
end
