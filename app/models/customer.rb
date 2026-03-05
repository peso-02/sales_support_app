class Customer < ApplicationRecord
  enum delivery_note_type: { separate_later: 1, with_product: 2, not_required: 3 }
  enum order_method: { web_edi: 0, email: 1, fax: 2 }
  
  has_many :product_prices, dependent: :destroy
  has_many :products, through: :product_prices
  has_many :manuals, dependent: :destroy
  
  belongs_to :sales_rep, class_name: 'User', optional: true
  belongs_to :assistant, class_name: 'User', optional: true

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
        "得意先コード",
        "得意先名",
        "締日",
        "支払サイト",
        "支払日",
        "業態",
        "ケース割れ出荷可否",
        "ケース割れ送料",
        "納品書タイプ",
        "発注方法",
        "備考"
      ]
      
      all.each do |customer|
        csv << [
          customer.customer_code,
          customer.customer_name,
          customer.closing_day,
          customer.payment_terms,
          customer.payment_day,
          customer.business_type,
          customer.case_break_shipping_allowed ? "可" : "否",
          customer.case_break_shipping_fee,
          customer.delivery_note_type,
          customer.order_method,
          customer.notes
        ]
      end
    end
  end

  def self.import(file)
    require 'csv'
    
    # 必須ヘッダーのチェック
    required_headers = ["得意先コード", "得意先名", "締日", "支払サイト", "支払日", "業態", "ケース割れ出荷可否", "ケース割れ送料", "納品書タイプ", "発注方法", "備考"]
    csv = CSV.read(file.path, headers: true)
    
    missing_headers = required_headers - csv.headers
    if missing_headers.any?
      raise "CSVのフォーマットが正しくありません。"
    end

    errors = []
    
    csv.each.with_index(2) do |row, line_number|
      begin
        customer = find_or_initialize_by(customer_code: row["得意先コード"])
        
        # 納品書タイプの変換（1:後日別送、2:商品につける、3:不要）
        delivery_note_type_value = case row["納品書タイプ"]
        when "1" then "separate_later"
        when "2" then "with_product"
        when "3" then "not_required"
        when nil, "" then nil
        else
          raise "納品書タイプが不正です（1:後日別送、2:商品につける、3:不要）のいずれかを入力してください"
        end
        
        # 発注方法の変換（0:Web EDI、1:メール、2:FAX）
        order_method_value = case row["発注方法"]
        when "0" then "web_edi"
        when "1" then "email"
        when "2" then "fax"
        when nil, "" then nil
        else
          raise "発注方法が不正です（0:Web EDI、1:メール、2:FAX）のいずれかを入力してください"
        end
        
        customer.assign_attributes(
          customer_name: row["得意先名"],
          closing_day: row["締日"],
          payment_terms: row["支払サイト"],
          payment_day: row["支払日"],
          business_type: row["業態"],
          case_break_shipping_allowed: row["ケース割れ出荷可否"] == "可",
          case_break_shipping_fee: row["ケース割れ送料"],
          delivery_note_type: delivery_note_type_value,
          order_method: order_method_value,
          notes: row["備考"]
        )
        customer.save!
      rescue => e
        errors << "#{line_number}行目: #{e.message}"
      end
    end
    
    raise errors.join("\n") if errors.any?
  end
end