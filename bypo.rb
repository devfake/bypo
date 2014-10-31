#!/usr/bin/env ruby

require 'fileutils'

class Bypo

  LOCAL_PATH = 'C:\xampp\htdocs'
  REMOTE_PATH = 'C:\Users\Windows\Desktop\Dropbox\repos'
  UPSTREAM_NAME = 'dropbox'

  def initialize(name)
    @name = name

    if ! folder_exists?
      create_local_repo
      create_files_and_commit
      create_remote_repo

      puts "\nRepository for `#{@name}` successfully created!\n\n"
    end
  end

  private

  # Create local repository.
  def create_local_repo
    Dir.chdir "#{LOCAL_PATH}" do
      `git init #{@name}`
    end
  end

  # Create empty remote repository.
  def create_remote_repo
    `git init --bare #{REMOTE_PATH}/#{@name}.git`

    # Connect local repository to remote and push local master branch to remote.
    Dir.chdir "#{LOCAL_PATH}/#{@name}" do
      `git remote add #{UPSTREAM_NAME} #{REMOTE_PATH}/#{@name}.git`
      `git push -u #{UPSTREAM_NAME} master`
    end
  end

  # Create .gitignore and make a init commit.
  def create_files_and_commit
    Dir.chdir "#{LOCAL_PATH}/#{@name}" do
      File.open ".gitignore", 'w+' do |f|
        f.write ".idea\n/vendor\n/node_modules\n.Thumbs.db\n.DS_Store"
      end

      `git add .`
      `git commit -m "initial commit"`
    end
  end

  # Check if folder on local and remote exists.
  def folder_exists?
    empty_name?

    if File.exists? "#{LOCAL_PATH}/#{@name}" or File.exists? "#{REMOTE_PATH}/#{@name}.git"
      if File.exists? "#{LOCAL_PATH}/#{@name}"
        print "Directory `#{@name}` exists in #{LOCAL_PATH}. Pass a new name: "
      elsif File.exists? "#{REMOTE_PATH}/#{@name}.git"
        print "Directory `#{@name}.git` exists in #{REMOTE_PATH}. Pass a new name: "
      end

      @name = gets.chomp
      folder_exists?
    end

    false
  end

  # Check if name is emtpy.
  def empty_name?
    if @name.empty?
      print "You need to pass a name: "
      @name = gets.chomp
      empty_name?
    end

    false
  end
end

print "Name: "
Bypo.new(gets.chomp)