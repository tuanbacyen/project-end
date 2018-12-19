module UnitsHelper
  def next_unit
    Unit.last ? Unit.last.numunit + 1 : 1
  end
end
