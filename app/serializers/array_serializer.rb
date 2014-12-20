class ArraySerializer < ActiveModel::ArraySerializer
  def as_json(*args)

    meta_hash = {
      current_page: @object.current_page,
      next_page: @object.next_page,
      total_entries: @object.total_entries,
      per_page: @object.per_page,
    }

    {meta: meta_hash}.merge(super(root: @object.name.downcase.pluralize))
  end
end
