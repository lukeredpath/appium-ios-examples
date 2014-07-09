require_relative 'common'

$driver.with_session do
  begin
    application = $driver.target.front_most_app
    window = application.main_window

    catalog_menu = window.main_table_view

    def catalog_menu.select_option(name)
      cells.first_with_predicate('name contains[cd] :name', name: name).tap!
    end

    def window.go_back
      navigation_bar.left_button.tap
    end

    catalog_menu.select_option('Action Sheets')

    window.main_table_view.cells['Okay / Cancel'].tap
    application.action_sheet.buttons['OK'].tap

    window.go_back

    catalog_menu.select_option('Sliders')

    # proxy helper for sliders not yet implemented
    slider = window.main_table_view.cells[0].element_array_proxy_for(:sliders)[0]
    assert { slider.valid? }

    slider.drag_to_value(1)
    slider.drag_to_value(0)

    window.go_back

    catalog_menu.select_option('Switches')

    switch = window.main_table_view.cells[0].switches[0]
    assert { switch.valid? }

    switch.tap
    switch.tap

    window.go_back
  rescue StandardError => e
    puts "Error: #{e}"
  end
end
