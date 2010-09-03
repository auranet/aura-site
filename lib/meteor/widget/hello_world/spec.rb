module Meteor
  module Widget
    module HelloWorld
      # You've generated a new Meteor Widget!
      #
      # Your new widget can be rendered with the following:
      #
      # <%= render_meteor_widget(::Meteor::Widget::HelloWorld::Spec.new(...) -%>
      #   
      # This renders its partial, app/views/meteor/hello_world/_render.rhtml.
      #
      # In your partial you can get a hold of your spec object with a local cal

      class Spec < ::Meteor::SpecBase
        def initialize(options={},&block)
          super(options,&block)
        end
      end
    end
  end
end
