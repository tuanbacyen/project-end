module SchoolHelper
  def school_collection
    School.pluck :name, :id
  end
end
