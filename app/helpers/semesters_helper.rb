module SemestersHelper
  def semesters_periods
    Semester.periods.map{|p| p[0] = key_to_text_semester(p[0]), p[1] = p[0]}
  end

  def key_to_text_semester key
    return t("semester.hoc_ky_mot") if key == "hoc_ky_mot"
    return t("semester.hoc_ky_hai") if key == "hoc_ky_hai"
    t("semester.hoc_ky_he")
  end
end
