class ImportExportController < ApplicationController
  def export_template_student
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="template_student.xlsx"'
      }
    end
  end
  
  def import_student
    import = ImportStudentService.new params[:file], current_user.first_school.id
    import.import
    flash[:success] = "Students imported."
    redirect_to students_path
  end
end
