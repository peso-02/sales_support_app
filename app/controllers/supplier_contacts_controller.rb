class SupplierContactsController < ApplicationController
  before_action :set_supplier
  before_action :set_supplier_contact, only: [:edit, :update, :destroy]

  def new
    @supplier_contact = @supplier.supplier_contacts.build
  end

  def create
    @supplier_contact = @supplier.supplier_contacts.build(supplier_contact_params)
    
    if @supplier_contact.save
      redirect_to supplier_path(@supplier), notice: "担当者を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @supplier_contact.update(supplier_contact_params)
      redirect_to supplier_path(@supplier), notice: "担当者を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @supplier_contact.destroy
    redirect_to supplier_path(@supplier), notice: "担当者を削除しました。"
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  def set_supplier_contact
    @supplier_contact = @supplier.supplier_contacts.find(params[:id])
  end

  def supplier_contact_params
    params.require(:supplier_contact).permit(:contact_name, :email, :phone, :fax, :notes)
  end
end
