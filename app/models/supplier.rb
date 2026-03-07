class Supplier < ApplicationRecord
  has_many :supplier_contacts, dependent: :destroy
  
  # 支払条件を日本語で表示
  def payment_terms_display
    closing = closing_day == 99 ? "月末" : "#{closing_day}日"
    payment = payment_day == 99 ? "月末" : "#{payment_day}日"
    "#{closing}締め／#{payment_terms}ヶ月後の#{payment}払い"
  end

  def self.to_csv
    require 'csv'
    
    CSV.generate(headers: true) do |csv|
      csv << [
        "仕入先コード",
        "仕入先名",
        "締日",
        "支払サイト",
        "支払日",
        "ケース割れ発注可否",
        "ケース割れ送料",
        "備考"
      ]
      
      all.each do |supplier|
        csv << [
          supplier.supplier_code,
          supplier.supplier_name,
          supplier.closing_day,
          supplier.payment_terms,
          supplier.payment_day,
          supplier.case_break_order_allowed ? "可" : "否",
          supplier.case_break_order_fee,
          supplier.notes
        ]
      end
    end
  end

  def self.import(file)
    require 'csv'
    
    # 必須ヘッダーのチェック
    required_headers = ["仕入先コード", "仕入先名", "締日", "支払サイト", "支払日", "ケース割れ発注可否", "ケース割れ送料", "備考"]
    csv = CSV.read(file.path, headers: true)
    
    missing_headers = required_headers - csv.headers
    if missing_headers.any?
      raise "CSVのフォーマットが正しくありません。"
    end
    
    errors = []
    
    csv.each.with_index(2) do |row, line_number|
      begin
        supplier = find_or_initialize_by(supplier_code: row["仕入先コード"])
        supplier.assign_attributes(
          supplier_name: row["仕入先名"],
          closing_day: row["締日"],
          payment_terms: row["支払サイト"],
          payment_day: row["支払日"],
          case_break_order_allowed: row["ケース割れ発注可否"] == "可",
          case_break_order_fee: row["ケース割れ送料"],
          notes: row["備考"]
        )
        supplier.save!
      rescue => e
        errors << "#{line_number}行目: #{e.message}"
      end
    end
    
    raise errors.join("\n") if errors.any?
  end
end