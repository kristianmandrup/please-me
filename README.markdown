# Please me

*Note: The following is planned functionality only. I have not really started to implement it yet!*

This is a project that tries to please you in any way possible. This is done by executing a number of steps (kinda scripts) based on one or more configured profiles.
Each 'please-me request' can be customized to override the defaults as per defined in the profile(s).

## COMMANDS    
- please [command] [name] [options...]

- please create [name] [--profiles] [--steps] [--user] [--in]
- please update [name] [--profiles] [--steps] [--user] [--in]
- please remove [name] [--user] [--in]

- please install-step [name] [--url] [--user]
- please remove-step [name] [--url] [--user]

- please create-user [name]
- please remove-user [name]

- please create-profile [name] [--user]
- please remove-profile [name] [--user]

## New project

Create a new project (gem) using the default profile found in please-me/profiles.yml
$ please create my-gem --profile gem

Add a README markdown file to the project!
$ please update my-gem --steps readme:markdown

Remove README rdoc file from the project!
$ please remove my-gem --steps readme:markdown

Install new README step from gist!
please install-step readme:markdown --url http://gist.github.com/gists/525897.txt

## GLOBAL CONFIG FILE

Config file that can be fine tuned and individualized as you wish!

~/please-me/config.yml

<pre>
gems-location: ~/development/ruby/gems/mine
name: Kristian Mandrup
github:
  name: kmandrup
...
</pre>

## Multiple users

Please-me has support for multiple users, each having a distinct profile and step configuration. Simply add a folder with the name of the user.
In this user folder, add custom profiles and steps for that user.
Any profile will always be attempted merged with a profile of the same name from the global (shared) folder.
If a step is not found in the user step dir, the global step dir is searched. This allows for maximum reuse and simple overrides.

## PROFILES

Profiles are placed in the profiles dir

~/please-me/profiles/main.yml

The profile config files can take advantage of all the special facilities as provided inherently by YAML. Here the gem profile inherits from (and merges with) default. 
All profiles automatically inherit from the profile 'default' if such a profile exists.

<pre>
default:  
  spec: rspec2
  readme: 
    - markdown
  
gem-default: &gem-default
  readme: 
    - textile

gem: # profile
  <<: *gem-default
  lib:
    - gem

rails-gem: # profile
  <<: *gem
  rails

</pre>  

In the config yaml file, each root entry is a name of a profile, fx 'default' and 'rails-gem'.
Each profile can have one or more step configurations. 
If a step entry is a single value, fx 'rspec2' the step entry will execute with the root step folder as the context. 
Any file named 'rspec2.rb' within this context will be executed.

If the entry is key-value, the key indicates the step folder to use as the context for the step execution. 
The values are the step files to execute within that context.

~/please-me/kmandrup/profiles/main.yml

<pre>
default: # profile
  - rspec2
  - markdown
  - simple
  wiki: markdown

rails: # profile
  - rspec2
  readme: markdown
  rails:
    simple
    mongoid
</pre>

## STEP FILES

The user can modify and add files, share files with other etc.
There is special please-me command support for installation and removal of steps

~/please-me/steps
 - /spec
    - rspec.rb
    - rspec2.rb
 - /readme
    - markdown.rb
 - /lib
    - simple.rb
    - rails.rb
 - /rails
    - simple.rb
    - mongoid.rb
 - /rakefile
    - rspec2.rb
 - /wiki
    - markdown.rb
    - textile.rb

== Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
