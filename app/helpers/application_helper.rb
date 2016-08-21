module ApplicationHelper

  def current_class? test_path
    request.path == test_path ? :active : nil
  end

  def showmenu
    categories = Category.all
    categories = categories.to_a
    menus = ""
    menu_to_html categories, "", menus
    menus.html_safe
  end

  def full_title page_title = ''
    base_title = "FOOD and DRINK"
    if page_title.empty?
      base_title
    else
      page_title << " | "
      page_title << base_title
    end
  end

  def cart_count
    current_order.nil? ? 0 : current_order.line_items.count
  end

  def order_pendding
    Order.with_new_order(1).count
  end

  def get_categories
    categories = Category.all
  end
  private
  def menu_to_html objects, parent, menus
    menu = []
    objects.each_with_index do |object, index|
      if object.parent_code == parent
        menu.push object
        objects.delete_at index
      end
    end
    unless menu.blank?
      if parent.blank?
        menus << "<ul class='edu-widget-menu-list
          edu-widget-menu-list_horizontal'>"
      else
        menus << "<ul class='edu-widget-menu-sublist'>"
      end
      menu.each do |ob|
        menus << "<li class='edu-widget-menu-item'>"
        menus << "<a class='edu-widget-menu-link
          edu-widget-menu-link-level-1 edu-link' href='/categories/#{ob.id}'>
          #{ob.name}</a>"
        menu_to_html objects, ob.id.to_s, menus
        menus << "</li>"
      end
      menus << "</ul>"
    end
  end
end
