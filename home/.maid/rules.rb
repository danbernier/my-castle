# Test using:
#
#     maid clean -n
#
# Don't forget, it's just Ruby!  You can define custom methods and use them below:
#
#     def magic(*)
#       # ...
#     end
#
# If you come up with some cool tools of your own, please send me a pull
# request on GitHub!  Also, please consider sharing your rules with others via
# [the wiki](https://github.com/benjaminoakes/maid/wiki).
#
# For more help on Maid:
#
# * Run `maid help`
# * Read the README, tutorial, and documentation at https://github.com/benjaminoakes/maid#maid
# * Ask me a question over email (hello@benjaminoakes.com) or Twitter (@benjaminoakes)
# * Check out how others are using Maid in [the Maid wiki](https://github.com/benjaminoakes/maid/wiki)

module Maid::Tools
  def symlink(target, link_name)
    unless File.exist?(link_name)
      target = expand(target)
      command = "ln -s '#{target}' #{link_name}"
      log(command)
      unless @file_options[:noop]
        %x(#{command})
      end
    end
  end
end

Maid.rules do
  repeat '1d' do
    rule 'empty the trash daily' do
      dir('~/.local/share/Trash/files/').each do |path|
        remove(path) if 30.days.since?(added_at(path))
      end
    end
  end

  watch('~/Dropbox/Camera Uploads') do
    rule 'move Dropbox photos to Copy' do |modified, added, removed|
      added.each do |pic|
        move(pic, '~/Copy/Pictures/Camera Uploads')
      end
    end
  end

  # Well, this works.
  # That said, if you rm a dir, it leaves a broken link in ~/Copy,
  # which isn't really great.
  # Of course, that's only on the original machine; future machines
  # will have the copy, and (I guess) they'd have a symlink in ~/projects,
  # which...would be ok, I guess? (And BTW the code doesn't handle any
  # of that shit yet.)
  # Maybe this is why they invented rsync.
  # Maybe I should just get that backup SaaS.
  #
  # repeat '1s' do
  #   rule 'symlink ~/projects w/ no remote git repository' do
  #     extend ProjectBackup

  #     mkdir(backups_root) # idempotent, yay!
  #     projects.each do |project_dir|
  #       backup_link_name = File.join(backups_root, File.basename(project_dir))
  #       if should_have_backup?(project_dir)
  #         symlink(project_dir, backup_link_name)
  #       elsif has_backup?(project_dir)
  #         remove(backup_link_name)
  #       end
  #     end
  #   end
  # end
end

module ProjectBackup
  def projects_root
    '/home/dan/projects/'
  end

  def backups_root
    '/home/dan/Copy/project-backups'
  end

  def projects
    dir(File.join(projects_root, '*'))
  end

  def has_backup?(project_dir)
    File.exist?(File.join(backups_root, File.basename(project_dir)))
  end

  def should_have_backup?(project_dir)
    return false if has_dot_nobackup?(project_dir)
    !(has_dot_git?(project_dir) && has_remote?(project_dir))
  end

  def has_dot_nobackup?(dir)
    File.exist?(File.join(dir, '.nobackup'))
  end

  def has_dot_git?(dir)
    Dir.exist?(File.join(dir, '.git'))
  end

  def has_remote?(dir)
    in_dir(dir) { `git remote -v` }.size > 1
  end

  def in_dir(dir)
    begin
      start_dir = Dir.pwd
      Dir.chdir(dir)
      yield
    ensure
      Dir.chdir(start_dir)
    end
  end
end
