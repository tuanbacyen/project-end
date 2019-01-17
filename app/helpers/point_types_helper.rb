module PointTypesHelper
  def list_point_type point
    if point
      [[point.point_type.name, point.point_type.id]]
    else
      PointType.pluck :name, :id
    end
  end
end
