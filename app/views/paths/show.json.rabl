object @path
attributes :id
attribute :value => :name
child :paths => :children do
   attributes :id
   attribute :value => :name
    child :paths => :children do
       attributes :id
       attribute :value => :name
    end
end

