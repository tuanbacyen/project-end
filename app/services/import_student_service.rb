class ImportStudentService
  def initialize file, school_id
    @file = file
    @school_id = school_id
  end

  def import
    spreadsheet = open_spreadsheet @file
    header = spreadsheet.row 1
    return if !(header - Student.get_field_ex_im).present? || spreadsheet.last_row <= 1
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      student = Student.new
      student.attributes = row.to_hash.slice(*row.to_hash.keys)
      student.school_id = @school_id
      student.student_code = ""
      student.save!
    end
  end

  def open_spreadsheet file
    case File.extname file.original_filename
      when ".csv" then Roo::CSV.new file.path
      when ".xls" then Roo::Excel.new file.path
      when ".xlsx" then Roo::Excelx.new file.path
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end

