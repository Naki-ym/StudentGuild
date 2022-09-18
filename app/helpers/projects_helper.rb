module ProjectsHelper
  def get_current_year
    d = Time.current
    return d.year
  end
end
