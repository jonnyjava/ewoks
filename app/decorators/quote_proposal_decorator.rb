class QuoteProposalDecorator < ApplicationDecorator

  def shortened_text
    object.proposal.first(18)
  end

  def doc_list
    h.content_tag(:div) do
      h.concat link_to_doc(:doc1) if object.doc1.present?
      h.concat link_to_doc(:doc2) if object.doc2.present?
      h.concat link_to_doc(:doc3) if object.doc3.present?
    end
  end

  def price
    h.number_to_currency(object.ttc_price, unit: "€", separator:",", delimiter: ".", format: "%n%u")
  end

  def identifier
    "#{object.created_at.strftime("%Y%M%d")}-#{object.demand.id}-#{object.garage.id}-#{object.id}"
  end

  private
    def link_to_doc(doc)
      h.link_to(object.send(doc).url, class: 'b-crudbar__btn--default b-file', target: '_blank') do
        filename = object.send("#{doc.to_s}_file_name".to_sym)
        h.concat h.content_tag(:i, nil, class: "fa fa-file")
        h.concat " #{filename}"
      end
    end
end
