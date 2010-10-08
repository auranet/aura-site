Thin CMS/Blogging site built using Hobo.  Many things you need, quite possibly nothing you don't.

Installing
----------

    $ git clone git://github.com/auranet/aura-site.git
    $ gem install pg
    $ gem install rails -v 2.3.5
    $ gem install hobo hobosupport hobofields will_paginate --ignore-dependencies # Hobo will install rails 3 otherwise
    $ rake gems:install
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

Getting Started
---------------

1. ./script/server
2. Open a browser and go to http://localhost:8000/
3. You will be prompted to sign up.  This first user will be made an administrator.
4. Content is managed through the *Admin* menu.

Customizing
-----------

You can change the logo and set the hobo theme by creating
*app/views/taglibs/local.dryml* and placing something like the following
inside:

    <extend tag="app-name">
      My Aura Site
    </extend>
    <set-theme name="my_cool_theme"/>

This is also the place to add any install specific DRYML, like Google Analytics:

    <extend tag="page">
      <old-page merge>
        <append-head:>
          <script type="text/javascript">
            //<![CDATA[
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-XXXXXXXX-1']);
            _gaq.push(['_trackPageview']);

            (function() {
              var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
              ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
              var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();
            //]]>
          </script>
        </append-head:>
      </old-page>
    </extend>

Testing
-------

    $ RAILS_ENV=cucumber rake gems:install
    $ rake cucumber
