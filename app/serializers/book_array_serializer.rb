class BookArraySerializer < ActiveModel::ArraySerializer
  def as_json(*args)

    meta_hash = {
      current_page: @object.current_page,
      per_page: @object.per_page,
      total_entries: @object.total_entries
    }

    {meta: meta_hash}.merge(super(root: :books))
  end
end
