FactoryGirl.define do
  factory :quote_proposal do
    demands_garage_id   { FactoryGirl.create(:demands_garage).id }
    status              { QuoteProposal.statuses.keys.sample }
    proposal            { "#{Faker::StarWars.quote}. #{Faker::Hipster.paragraph(4)}" }
    ttc_price           { Faker::Commerce.price }
    expiration          { Faker::Date.between(7.days.from_now, Faker::Date.forward(rand(100))) }

    factory :quote_proposal_with_attachments do
      doc1_file_name      { "#{Faker::StarWars.character.parameterize.underscore}.pdf" }
      doc1_content_type   'application/pdf'
      doc1_file_size      1024
      doc2_file_name      { "prestacion_#{Faker::Company.buzzword.parameterize.underscore}.pdf" }
      doc2_content_type   'application/pdf'
      doc2_file_size      1024
      doc3_file_name      { "pro_forma_#{Faker::StarWars.droid}.pdf" }
      doc3_content_type   'application/pdf'
      doc3_file_size      1024
    end
  end
end
