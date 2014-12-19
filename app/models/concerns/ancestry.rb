module Ancestry
  extend ActiveSupport::Concern

  included do
    belongs_to :parent, class_name: self.name

    has_many :children, -> { order(:order) }, class_name: self.name, foreign_key: 'parent_id', dependent: :destroy

    validates_associated :parent, if: -> (object) { object.parent_id.present? && !loop_in_ancestor_list? }

    validate :loop_in_ancestor_list?
  end

  module ClassMethods
    def flat_hierarchy
      def subsort(all_objects, current_level_objects, indent_level)
        result = []

        current_level_objects.each do |current_level_object|
          result << [current_level_object, indent_level]

          result += subsort(all_objects, all_objects.select { |object| object.parent == current_level_object }.sort_by(&:name), indent_level + 1)
        end

        result
      end

      objects = all

      objects.each do |object|
        if object.loop_in_ancestor_list?
          return nil
        end
      end

      subsort(objects, objects.select { |object| object.parent.nil? }.sort_by(&:name), 0).map(&:first)
    end
  end

  def ancestor_of?(other)
    tortoise = other

    hare = other

    steps_taken = 0

    step_limit = 2

    loop do
      return false if hare.nil?

      hare = hare.parent

      steps_taken += 1

      return true if hare == self

      return false if tortoise == hare

      if steps_taken == step_limit
        steps_taken = 0

        step_limit *= 2

        tortoise = hare
      end
    end
  end

  def descendant_of?(other)
    other.ancestor_of?(self)
  end

  def loop_in_ancestor_list?
    tortoise = self

    hare = self

    steps_taken = 0

    step_limit = 2

    loop do
      return false if hare.nil?

      hare = hare.parent

      steps_taken += 1

      if tortoise == hare
        if respond_to?(:errors) && errors.is_a?(ActiveModel::Errors)
          errors[:base] << 'has loop in ancestor list'
        end

        return true
      end

      if steps_taken == step_limit
        steps_taken = 0

        step_limit *= 2

        tortoise = hare
      end
    end
  end

  def find_ancestor_list_loop_start
    tortoise = self

    hare = self

    loop do
      break if tortoise.nil? || hare.nil?

      tortoise = tortoise.parent

      return nil if hare.parent.nil?

      hare = hare.parent.parent

      if tortoise == hare
        if respond_to?(:errors) && errors.is_a?(ActiveModel::Errors)
          errors[:base] << 'has loop in ancestor list'
        end

        tortoise = self

        loop do
          break if tortoise == hare

          tortoise = tortoise.parent

          hare = hare.parent
        end

        return tortoise
      end
    end

    nil
  end

  def ancestors
    finish = find_ancestor_list_loop_start

    result = []

    current = parent

    result << current if current != finish

    loop do
      break if current == finish || current.parent.nil?

      current = current.parent

      result << current
    end

    result.pop if self == finish

    result
  end

  def dropdown_name
    finish = find_ancestor_list_loop_start

    result = []

    current = self

    loop do
      result.unshift(current.name)

      current = current.parent

      break if current == finish || current.parent.nil?
    end

    result.unshift(current.name) unless current.nil?

    result.shift if self == finish

    "/#{result.join('/')}"
  end
end
