#= require app/views/menu_views/menu_view_level3
#= require app/views/menu_items/menu_item_level2
#= require_self

class Eludia.Views.MenuViewLevel2 extends Eludia.Views.MenuViewBase
  className: 'navbar-menu-level2 hide'
  itemView: Eludia.Views.MenuItemLevel2
  submenuView: Eludia.Views.MenuViewLevel3
  submenuRegion: 'menu_region_level3'

  initialize: ->
    _.extend @, Eludia.Helpers.ApplicationHelpers
    # using helper @windowWidth
    super

  onShow: ->
    @_setPosition()
    @$el.removeClass('hide')
    @_overflowCheck()

  _overflowCheck: ->
    if @childrenOverflow() == true
      @$el.addClass 'single-column-scrollable'


  showSubmenu: (item_view) ->
    if item_view.model.get('items')
      position = @$el.position()
      @initPosition = position.left
      @setPositionLeft(@$el, 0, @transitionDuration())
      @shifted = true
    else
      return false
    super

  showSubmenuRegion: (item_view) ->
    @submenu_region.show @submenu_view
    if item_view.model.get('items')
      @listenTo @submenu_view, 'level3menu:single_column', @_setSubmenuHeight()

  _setSubmenuHeight: ->
    level2Height = @$el.height()
    if @submenu_view.singleColumn == true
      @submenu_view.$el.css('min-height', level2Height + 'px')

  _setPosition: ->
    $parentEl = @options.parent_item_view.$el
    parentPos = $parentEl.position()
    parentLeft = parentPos.left
    maxLeftPos = @windowWidth() - @$el.width()
    if parentLeft < maxLeftPos
      @setPositionLeft(@$el, parentLeft)
    else
      @setPositionLeft(@$el, maxLeftPos)

