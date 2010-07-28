class MeteorTestController < ApplicationController

  include MeteorCrud

  def meteor_specs
    unless @meteor_specs
      @meteor_specs = {}
      [:menu_spec].each do |s|
        if spec = self.send(s)
          @meteor_specs[ spec.name ] = spec
        end
      end
    end
    @meteor_specs
  end
  
  def meteor_spec(h={})
    meteor_specs[h[:name]]
  end

  def menu_spec
    Meteor::MeteorSpec.new do |spec|
      spec.klass = Entry
      spec.parent_klass = User
      spec.controller_class = MeteorTestController
      spec.title = "Menus"

      spec.columns.push(Meteor::MeteorColumn.new{|c|
                          c.name = "name"
                          c.type = :scalar
                          c.edit = true
                          c.create = true
                          #                          c.refsql = "select * from agent where is_deleted <> 'Y' order by agent_name"
                        })
    end
  end

  def index

    @spec = menu_spec


  

    ret =   Meteor::MeteorRenderer.new(:spec => @spec,
                             :controller => self,
                             :frontend => "meteor",
                             :params => params,
                             :id => User.all[0].id).render
    
    
  end

end
