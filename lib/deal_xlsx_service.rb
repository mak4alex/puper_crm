class DealXlsxService
  VERTICAL_MARGIN = 2
  INFO_COLUMNS = 'A'..'F'
  VALUE_COLUMNS = 'H'..'S'
  COLUMNS = {
    name: 0, sku: 1, currency_name: 2, unit_price: 3, promo_unit_price: 4, unit: 5,
    plan_level: 6, values: (7..18)
  }

  def initialize(path)
    @path = path
  end

  def export(deals)
    @deals = deals
    Axlsx::Package.new do |package|
      workbook = package.workbook

      workbook.add_worksheet(name: 'Sheet1') do |sheet|
        align = sheet.styles.add_style(alignment: {horizontal: :center, vertical: :center})

        sheet.add_row(deals_header(@deals.last), style: align)
        write_deals(sheet, align)
      end

      package.serialize(@path)
      `libreoffice #{@path}`
    end
  end

  def import(type)
    xlsx = Roo::Spreadsheet.open(@path.to_s)
    sheet_name = xlsx.sheets.first
    sheet = xlsx.sheet(sheet_name)
    (VERTICAL_MARGIN..xlsx.last_row).each do |row|
      deal_attributes = {
        name: sheet.row(row)[COLUMNS[:name]],
        sku: sheet.row(row)[COLUMNS[:sku]],
        currency_id: Currency.find_by(abbr: sheet.row(row)[COLUMNS[:currency_name]]).id,
        unit_price: sheet.row(row)[COLUMNS[:unit_price]],
        promo_unit_price: sheet.row(row)[COLUMNS[:promo_unit_price]],
        unit_type: sheet.row(row)[COLUMNS[:unit]],
        type: type
      }
      deal = Deal.find_or_create_by(deal_attributes)
      plan = deal.plans.new(name: sheet.row(row)[COLUMNS[:plan_level]])
      sheet.row(row)[COLUMNS[:values]].compact.each { |value| plan.values.new(value: value) }
      deal.save
    end
  end

  private

  def write_deals(sheet, style)
    @deals.each_with_index do |deal, index|
      Plan::NAMES.count.times do |plan_name_index|
        merge_value_columns(sheet, index, plan_name_index)
        sheet.add_row(extract_data(deal, index, plan_name_index), style: style)
      end
      merge_info_rows(sheet, index)
    end
  end

  def merge_value_columns(sheet, index, plan_name_index)
    cell_width = value_cell_width(plan_name_index)
    VALUE_COLUMNS.step(cell_width).each do |column|
      first_cell = "#{column}#{VERTICAL_MARGIN + index * 5 + plan_name_index}"
      last_cell = "#{(column.to_i(36) + cell_width - 1).to_s(36).upcase}#{VERTICAL_MARGIN + index * 5 + plan_name_index}"
      sheet.merge_cells([first_cell, last_cell].join(':'))
    end
  end

  def extract_data(deal, index, plan_name_index)
    repeat_count = value_cell_width(plan_name_index) - 1

    plan_values = deal.plans.where(name: Plan::NAMES[plan_name_index]).order(:start_at).flat_map(&:values).map(&:value).map(&:to_f)
    repeated_plan_values = plan_values.map { |value| [value] + [nil] * repeat_count }.flatten
    data = [
      deal.name,
      deal.sku,
      deal.currency.abbr,
      deal.unit_price,
      deal.promo_unit_price,
      deal.unit_type,
      Plan::NAMES[plan_name_index],
      repeated_plan_values
    ].flatten
    data + [plan_values.sum]
  end

  def value_cell_width(plan_name_index)
    case Plan::NAMES[plan_name_index]
    when 'STRATEGIC' then 12
    when 'PERSPECTIVE' then 4
    else 1
    end
  end

  def deals_header(deal)
    header_dates = deal.plans.where(name: 'IMMEDIATE').pluck(:start_at).map(&:to_date).map(&:inspect)
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
      I18n.t('activerecord.attributes.plan.accepted')
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
