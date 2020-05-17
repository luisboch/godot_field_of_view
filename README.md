# Godot Field Of View

Godot script that allow use of Field of View in (currently) 2d game. 

## Features

* Hight customizable
* Multiple targets
* Target defined by groups
* Precision can be defined
* Update delay (faster will use more cpu)

## How to install

Can be installed from ![asset lib](https://godotengine.org/asset-library/asset/210)

## How to use

* Enable plugin under project settings
* Add Field of View node
* Configure it (And add target groups to track, without it, plugin will not work as expected!)
* From Character node read "in_danger_area" and "in_warn_area" properties to get the visible nodes, or,
* Use events "target_enter" or "target_exit" to work;

## Configurations

* **View Detail:** Int, Indicates the number of rays created to check the Fov area, greater value will be more precise with cpu cost.
* **Field of View:** In degrees, configure the view angle
* **Warn distance:**  Float, view distance
* **Danger distance:**  Float, view distance to consider danger, must be lower than  *Warn distance*  
* **Show Fov:**  Bool, use to view the rays created
* **Show Target line:**  Bool, draw line to target?
* **Fov Color:** Color, when *Show Fov* is true, this define the color used to draw rays
* **Fov Warn Color:** Color, when *Show Fov* is true, this define the color used to draw rays when is "warn" state
* **Fov Danger Color:** Color, when  *Show Fov* is true, this define the color used to draw rays when is "danger" state
* **Frequency:** Float, frequency to update view area, lower will update fast with cpu cost, default value is 0.5
* **Target Groups** Array groups to track, required at least one.
  
## Current state

![Screenshot 1](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/assets/luisboch/field-of-view/2d/demo/print/print_1.jpg)

![Screenshot 2](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/assets/luisboch/field-of-view/2d/demo/print/print_2.jpg)

![Screenshot 3](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/assets/luisboch/field-of-view/2d/demo/print/print_3.jpg)

![Screenshot 4](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/assets/luisboch/field-of-view/2d/demo/print/print_4.jpg)

![Screenshot 5](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/assets/luisboch/field-of-view/2d/demo/print/print_5.jpg)

![Screenshot 6](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/assets/luisboch/field-of-view/2d/demo/print/print_6.jpg)

![Screenshot 7](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/assets/luisboch/field-of-view/2d/demo/print/print_7.jpg)

![Screenshot 8](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/assets/luisboch/field-of-view/2d/demo/print/print_8.jpg)

## Previews:

![Preview 1](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/preview1.gif)

![Preview 2](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/preview2.gif)

![Preview 3](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/preview3.gif)

![Preview 4](https://raw.githubusercontent.com/luisboch/godot_field_of_view/images/preview4.gif)

## How-To from zero

A complete how to use this plugin.

[![Youtube vídeo](https://img.youtube.com/vi/tpR-9X6G8hk/0.jpg)](https://www.youtube.com/watch?v=tpR-9X6G8hk)
