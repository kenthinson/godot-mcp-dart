<a id="doc-user-interface"></a>

# User interface (UI)

In this section of the tutorial, we explain the basics of creating a graphical
user interface (GUI) in Godot.

## UI building blocks

Like everything else in Godot, the user interface is built using nodes, specifically
[Control](../../classes/class_control.md#class-control) nodes. There are many different types of controls
which are useful for creating specific types of GUIs. For simplicity, we can
separate them into two groups: content and layout.

Typical content controls include:

* [Buttons](../../classes/class_button.md#class-button)
* [Labels](../../classes/class_label.md#class-label)
* [LineEdits](../../classes/class_lineedit.md#class-lineedit) and [TextEdits](../../classes/class_textedit.md#class-textedit)

Typical layout controls include:

* [BoxContainers](../../classes/class_boxcontainer.md#class-boxcontainer)
* [MarginContainers](../../classes/class_margincontainer.md#class-margincontainer)
* [ScrollContainers](../../classes/class_scrollcontainer.md#class-scrollcontainer)
* [TabContainers](../../classes/class_tabcontainer.md#class-tabcontainer)
* [Popups](../../classes/class_popup.md#class-popup)

The following pages explain the basics of using such controls.

* [Size and anchors](size_and_anchors.md)
* [Using Containers](gui_containers.md)
* [Custom GUI controls](custom_gui_controls.md)
* [Keyboard/Controller Navigation and Focus](gui_navigation.md)
* [Control node gallery](control_node_gallery.md)

## GUI skinning and themes

Godot features an in-depth skinning/theming system for control nodes. The pages in this section
explain the benefits of that system and how to set it up in your projects.

* [Introduction to GUI skinning](gui_skinning.md)
* [Using the theme editor](gui_using_theme_editor.md)
* [Theme type variations](gui_theme_type_variations.md)
* [Using Fonts](gui_using_fonts.md)

## Control node tutorials

The following articles cover specific details of using particular control nodes.

* [BBCode in RichTextLabel](bbcode_in_richtextlabel.md)

## Creating applications

Godot can also be used to create applications (rather than games).

* [Creating applications](creating_applications.md)
