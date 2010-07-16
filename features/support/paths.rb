module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    when /project show/
      project_path(@project)
    when /parking index/
      parking_index_path
    when /parking new/
      new_parking_path
    when /new resource/
      new_parking_path
    when /new feature/
      new_feature_path
    when /export feature/
      export_feature_path @feature
    when /import project/
      import_project_path(@project)
    when /import single feature/
      import_feature_project_path @project
    when /feature changes/
      changes_feature_path @feature
    when /feature merge/
      merge_feature_path @feature
    when /system merge/
      system_merge_feature_path @feature
    when /features patch/
      feature_path(@feature,:format => :patch)
    when /export feature file/
      feature_path(@feature,:format => :feature)
    when /new project/
      new_project_path
    when /edit project/
      edit_project_path @project
    when /new feature/
      new_feature_path
    when /edit feature/
      edit_feature_path @feature
    when /new story/
      new_story_path
    when /new parking/
      new_parking_path
    when /edit story/
      edit_story_path @story
    when /new step/
      new_step_path
    when /edit step/
      edit_step_path @step
    when /projects features/
      features_project_path @project
    when /features stories/
      stories_feature_path @feature
    when /stories steps/ 
      steps_story_path @story
    when /a project/
      project_path @project
    when /a feature/
      feature_path @feature
    when /a story/
      story_path @story
    when /a step/
      step_path @step
    when /all projects/
      projects_path
    when /all features/
      features_path
    when /all stories/
      stories_path
    when /all steps/
      steps_path
    
    
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
