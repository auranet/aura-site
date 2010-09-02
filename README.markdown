Thin CMS/Blogging site built using Hobo.  Many things you need, quite possibly nothing you don't.

Note: The first user to sign up is made an admin.

Customizing
-----------

You can change the logo and set the hobo theme by creating
*app/views/taglibs/local.dryml* and placing something like the following
inside:

    <extend tag="app-name">
      My Aura Site
    </extend>
    <set-theme name="my_cool_theme"/>
