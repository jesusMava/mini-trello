module TaskHelpers
  def create_tasks(project, amount)
    create_list(
      :task,
      amount,
      project: project
    ).sort_by(&:position)
  end
end
