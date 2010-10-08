Thin CMS/Blogging site built using Hobo.  Many things you need, quite possibly nothing you don't.

Note: The first user to sign up is made an admin.

Installing
----------

    $ git clone  git://github.com/auranet/aura-site.git
    $ gem install pg
    $ gem install rails -v 2.3.5
    $ gem install hobo hobosupport hobofields will_paginate --ignore-dependencies # Hobo will install rails3 otherwise
    $ rake gems:install
    $ gem list should look like the following:
    $ gem list

    *** LOCAL GEMS ***

    actionmailer (2.3.5)
    actionpack (2.3.5)
    activerecord (2.3.5)
    activeresource (2.3.5)
    activesupport (2.3.5)
    ambethia-recaptcha (0.2.2)
    hobo (1.0.1)
    hobofields (1.0.1)
    hobosupport (1.0.1)
    maruku (0.6.0)
    panztel-actionwebservice (2.3.5)
    pg (0.9.0)
    rack (1.0.1)
    rails (2.3.5)
    rake (0.8.7)
    rakismet (0.4.2)
    syntax (1.0.0)
    will_paginate (2.3.15)

    $ cp config/aura.yml.example config/aura.yml # edit this new file to meet your needs
    $ rake db:migrate

Customizing
-----------

You can change the logo and set the hobo theme by creating
*app/views/taglibs/local.dryml* and placing something like the following
inside:

    <extend tag="app-name">
      My Aura Site
    </extend>
    <set-theme name="my_cool_theme"/>

Testing
-------

    $ RAILS_ENV=cucumber rake gems:install
    $ rake cucumber
