demand = @quote_proposal.demand.decorate
json.demand do
  json.city demand.city
  json.name_and_surnames demand.name_and_surnames
  json.phone demand.phone
  json.email demand.email
  json.service demand.service_with_category
  json.car demand.car_complete_info
  json.vin_number demand.vin_number
  json.details demand.demand_details
  json.user_comments demand.comments
end

json.quote do
  json.proposal @quote_proposal.proposal
  json.price @quote_proposal.price
  json.expiration @quote_proposal.expiration

  json.set! :docs do
    if @quote_proposal.doc1.present?
      json.doc1 do
        json.id 'doc1'
        json.file_name @quote_proposal.doc1_file_name
        json.file_url @quote_proposal.doc1.url
      end
    end
    if @quote_proposal.doc2.present?
      json.doc2 do
        json.id 'doc2'
        json.file_name @quote_proposal.doc2_file_name
        json.file_url @quote_proposal.doc2.url
      end
    end
    if @quote_proposal.doc3.present?
      json.doc3 do
        json.id 'doc3'
        json.file_name @quote_proposal.doc3_file_name
        json.file_url @quote_proposal.doc3.url
      end
    end
  end
end
