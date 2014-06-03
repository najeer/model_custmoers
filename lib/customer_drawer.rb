class CustomerDrawer
	def self.draw(customers)
		pdf = PDF::Writer.new
          customers.each do |customer|
          pdf.text customer.name
      end
      pdf.render
  end
  def work_order_summary_pdf(pdf,current_account,order)
      items = [[ "Work Order #{t 'order.num_separator'} #{order.order_number}" ,"Due Dt. #{qb_format_date(order.due_date)}"]]
      pdf.table(items,:width => pdf.bounds.width, :cell_style => {:inline_format => true,:border_width => 0.5,:border_color=> 'C1C1C1' }) do
        row(0).style(:style => :bold,:size => 8)
      end
      pdf.move_down(5)
      header = ["#{t 'order.sold_to'}","#{t 'order.contact_info'} ","#{t 'order.shipping'}/#{t 'order.install'}"]
      get_customer_info(header,pdf,order,nil,1)
      pdf.move_down(5)
      header = ["#{t 'order.quote'} #{t 'order.num_separator'}","#{t 'order.quote_date'} ","#{t 'order.sales_rep'}","#{t 'order.payment_terms'}","#{t 'order.po'} #","#{t 'order.po_date'}"]
      items = [["#{order.quote_number}",
              "#{qb_format_date(order.quote_date)}",#{(current_account.phone, :area_code => true)}
              " #{get_salesman_info(order)} ",
              "#{order.term_code}",
              "#{order.po_number}",
              "#{qb_format_date(order.po_date)}"]]
      colmap = {}
      colmap[0] = {:width => 50, :align => :left}
      colmap[1] = {:width => 70, :align => :left}
      colmap[3] = {:width => 60, :align => :left}
      colmap[4] = {:width => 50, :align => :left}
      colmap[5] = {:width => 70, :align => :left}
      colmap[6] = {:width => 60, :align => :left}
      pdf.table([header]+items,:width => pdf.bounds.width, :cell_style => {:inline_format => true,:border_width => 0.5,:border_color=> 'C1C1C1' }) do
        row(0).style(:style => :bold,:size => 8)
        row(1).style(:size => 8)
        colmap.keys.each do |key|
          columns(key).style(colmap[key])
        end
      end
      pdf.move_down(3)
      order.estimates.each_with_index do |estimate,index| 
       get_summary_workorder_items(pdf,estimate)
      end
      
    end
end