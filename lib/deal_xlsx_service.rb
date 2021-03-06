class DealXlsxService
  VERTICAL_MARGIN = 2
  INFO_COLUMNS = 'A'..'F'
  VALUE_COLUMNS = 'H'..'S'
  COLUMNS = {
    name: 0, sku: 1, currency_name: 2, unit_price: 3, promo_unit_price: 4, unit: 5,
    plan_level: 6, values: (7..-4), accepted: -2, description: -1
  }

  def initialize(path)
    @path = path
  end

  def export(deals)
    @deals = [deals].flatten
    Axlsx::Package.new do |package|
      workbook = package.workbook

      workbook.add_worksheet(name: 'Sheet1') do |sheet|
        align = sheet.styles.add_style(alignment: {horizontal: :center, vertical: :center})

        sheet.add_row(deals_header(@deals.last), style: align)
        write_deals(sheet, align)
      end

      package.serialize(@path)
      # `libreoffice #{@path}`
    end
  end

  def import(type)
    xlsx = Roo::Spreadsheet.open(@path.to_s)
    sheet_name = xlsx.sheets.first
    sheet = xlsx.sheet(sheet_name)
    start_at = Date.parse(xlsx.row(1)[7])
    end_at = Date.parse(xlsx.row(1)[-4])
    deal = nil
    (VERTICAL_MARGIN..xlsx.last_row).each do |row_index|
      row = sheet.row(row_index)
      deal_attributes = {
        name: row[COLUMNS[:name]],
        sku: row[COLUMNS[:sku]],
        currency_id: Currency.find_by(abbr: row[COLUMNS[:currency_name]]).id,
        unit_price: row[COLUMNS[:unit_price]],
        promo_unit_price: row[COLUMNS[:promo_unit_price]],
        unit_type: row[COLUMNS[:unit]],
        type: type,
        start_at: start_at,
        end_at: end_at,
        accepted: row[COLUMNS[:accepted]],
        description: row[COLUMNS[:description]]
      }
      deal ||= Deal.create!(deal_attributes)
      plan = deal.plans.where(name: row[COLUMNS[:plan_level]]).first
      row[COLUMNS[:values]].compact.each_with_index do |value, index|
        plan.values[index].value = value
        plan.values[index].save!
      end
      plan.save!
      # binding.pry
    end
    deal
  end

  private

  def write_deals(sheet, style)
    @deals.each_with_index do |deal, deal_index|
      deal.plans.each_with_index do |plan, plan_index|

        sheet.add_row(extract_data(deal, deal_index, plan.name), style: style)
        merge_value_columns(sheet, deal_index, plan_index, plan.name)
      end
      merge_info_rows(sheet, deal_index)
    end
  end

  def merge_value_columns(sheet, deal_index, plan_index, plan_name)
    cell_width = value_cell_width(plan_name) - 1
    start_position = 7
    while start_position < @deals.last.header_dates.size do
      last_cell = start_position + cell_width
      sheet.merge_cells sheet.rows[plan_index + VERTICAL_MARGIN - 1].cells[(start_position..last_cell)]
      start_position = last_cell + 1
    end
  end

  def extract_data(deal, index, plan_name)
    repeat_count = value_cell_width(plan_name) - 1

    plan_values = deal.plans.where(name: plan_name).flat_map(&:values).map(&:value).map(&:to_f)
    repeated_plan_values = plan_values.map { |value| [value] + [nil] * repeat_count }.flatten
    data = [
      deal.name,
      deal.sku,
      deal.currency.abbr,
      deal.unit_price,
      deal.promo_unit_price,
      deal.unit_type,
      plan_name,
      repeated_plan_values.first(deal.header_dates.length),
      plan_values.sum,
      deal.accepted.inspect,
      deal.description
    ].flatten
    data + []
  end

  def value_cell_width(plan_name)
    case plan_name
    when 'STRATEGIC' then 12
    when 'PERSPECTIVE' then 3
    else 1
    end
  end

  def deals_header(deal)
    header_dates = deal.header_dates.map(&:to_date).map(&:inspect)
    [
      I18n.t('activerecord.attributes.deal.name'),
      I18n.t('activerecord.attributes.deal.sku'),
      I18n.t('activerecord.attributes.currency.name'),
      I18n.t('activerecord.attributes.deal.unit_price'),
      I18n.t('activerecord.attributes.deal.promo_unit_price'),
      I18n.t('activerecord.attributes.deal.unit'),
      I18n.t('activerecord.attributes.plan.name'),
      header_dates,
      I18n.t('export.total', default: 'Total'),
      I18n.t('activerecord.attributes.plan.accepted'),
      I18n.t('activerecord.attributes.plan.description')
    ].flatten
  end

  def blank_row(width)
    line = []
    width.times { line << '' }
    line
  end

  def merge_info_rows(sheet, index)
    INFO_COLUMNS.each do |column|
      sheet.merge_cells("#{column}#{VERTICAL_MARGIN + index * 5}:#{column}#{VERTICAL_MARGIN + index * 5 + 4}")
    end
  end

end
