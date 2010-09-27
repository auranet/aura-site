module Meteor
  module Widget
    module DhtmlMenu
      # You've generated a new Meteor Widget!
      #
      # Your new widget can be rendered with the following:
      #
      # <%= render_meteor_widget(::Meteor::Widget::DhtmlMenu::Spec.new(...) -%>
      #   
      # This renders its partial, vendor/plugins/dhtml_menu/templates/dhtml_menu/_render.rhtml.
      #
      # In your partial you can get a hold of your spec object with a local call 'spec'.

      class Spec < ::Meteor::PluginSpecBase

        include MeteorWidgetPlugin

        attr_accessor :menu_items

        def initialize(options={},&block)
          self.menu_items = []
          super(options,&block)
        end
      end
    end
  end
end
