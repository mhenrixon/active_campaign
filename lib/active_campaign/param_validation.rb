module ActiveCampaign
  module ParamValidation
    def filter_params(allowed_keys = [], params = {})
      params.keys.select do |k,v|
        allowed_keys.each do |param|
          params.include?(k) ||
          param.match(k)
        end
      end
    end
  end
end