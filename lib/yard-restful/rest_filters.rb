module YARD
    module CodeObjects
      class Base
        def restful?
          has_tag?(:topic)
        end
        def resource?
          meths.any?{ |m| m.has_tag?(:url) }
        end
      end
      class MethodObject
        def action?
          has_tag?(:url)
        end
      end
    end
end

module RestFilters

  # Select all items from the given list with the tag @topic
  def select_restful(list)
    (list || []).select(&:restful?)
  end

  # Select all items from the given list with the tag @url
  def select_actions(method_list)
    (method_list || []).select(&:action?)
  end

  def select_objects(list)
    select_restful(list).reject(&:resource?).sort_by(&:name)
  end

  def select_resources(list)
    select_restful(list).select(&:resource?).sort_by(&:name)
  end

end

