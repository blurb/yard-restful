module YARD
    module CodeObjects
      class Base
        def restful?
          has_tag?(:restful_api)
        end
        def resource?
          children.any?{ |m| m.has_tag?(:url) }
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

  # Select all items from the given list with the tag @restful_api
  def select_restful(list)
    (list || []).select(&:restful?)
  end

  # Select all items from the given list with the tag @url
  def select_actions(method_list)
    (method_list || []).select(&:action?)
  end

  def select_objects(list)
    select_restful(list).reject(&:resource?).sort_by { |o| o.name.to_s }
  end

  def select_resources(list)
    select_restful(list).select(&:resource?).sort_by { |o| o.name.to_s }
  end

  # patch render for yard server - it gets into an infinite loop
  # unless we clear the type field
  def linkify(*args)
    if args.first.is_a?(String)
      case args.first
      when /^render:(\S+)/
        old_type = options.delete(:type)
        output = super
        options.type = old_type
        return output
      end
    end
    super
  end

end

