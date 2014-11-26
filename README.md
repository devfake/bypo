Bypo
===============

Use this ruby script to create two local git repositorys. One for **local** and one `--bare` repository for **remote**, but on the same machine.

Useful to host your remote repo e.g on your dropbox folder and sync them between your workplace and your home and devices.

**Do not use this technique for working in a team!**

### How to

Change the paths in the script:

```ruby
LOCAL_PATH = 'C:\xampp\htdocs'
REMOTE_PATH = 'C:\Users\Windows\Desktop\Dropbox\repos'
UPSTREAM_NAME = 'dropbox'
```

**Warning:** If you on windows, dont use double quotes `"` for the path string. Because windows has backslashes, they would be escaped.

The upstream name in git is normally **origin**, but i named it **dropbox**, because it is clearer what it means.

Call the file in your terminal:

```
$ ruby path/to/bypo.rb
```

You will be prompted for a name for your repository. This command will create a `name.git` folder in your remote path, and a `name` folder in your local path. Further it creates a `.gitignore` file with few placeholders and makes a "initial commit" and push it to your remote repository.

**Notice:** If you have a folder in your `LOCAL_PATH` or `REMOTE_PATH` with the same name, you will be prompted and you can enter a new name.

The script automatically sets a new remote connection for your local file to the remote file. So you can use normally `git push` and others from your local file.

### Tip for OSX and Linux user

You can make the script executable with a double click. Run this in your terminal:

```
$ chmod a+x path/to/bypo.rb
```

and change the `.rb` extension to `.sh`.

### ToDo

* Rewrite code
* Validating
* Enter paths in console as first step and save them
* Smart GUI
* Two modes: Clone repo and Create new repo