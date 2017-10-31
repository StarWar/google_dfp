require 'json'
require 'google_dfp/size'
require 'google_dfp/tag'

module GoogleDFP

  class Engine < ::Rails::Engine
  end

  module ViewHelper
    def dfp_tag(name, targeting=nil)
      tag  = GoogleDFP::Tag.get(name)
      data = tag.data
      data = data.merge(targeting: targeting) if targeting.present?
      content_tag :div,
        "",
        id: data[:id],
        class:    "gpt-ad",
        data: { 'gpt-path': data[:unit], 'gpt-dimensions': data[:size] }
    end
  end

end

ActionView::Base.send :include, GoogleDFP::ViewHelper
