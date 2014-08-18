module UsersHelper
  def field_errors_tr(model, field)
    "<tr class='errors_tr'>
      <td id='#{field.to_s}_errors'>
        #{field_errors(model, field)}
      </td>
      <td></td>
    </tr>".html_safe
  end

  def field_errors(model, field)
    messages_string(model,field).html_safe
  end

  private

  def messages_string model, field
    if model.errors.added?(field, :blank)
      model.errors.messages[field] = [error_message(:blank, model, field)]
    end

    model.errors.messages[field].map{|msg| "<p>#{msg}</p>" }.join
  end

  def error_message(type, model, field)
    model_name = model.class.to_s.downcase
    msg = I18n.t("activerecord.errors.models.#{model_name}.attributes.#{field.to_s}.#{type.to_s}")
    attr_name = I18n.t("activerecord.attributes.#{model_name}.#{field.to_s}")

    msg.gsub('%{attribute}', attr_name) if msg !~ /\Atranslation missing:/
  end
end
