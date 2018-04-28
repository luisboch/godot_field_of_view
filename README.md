# godot_field_of_view
Godot script that allow use of Field of View in (currently) 2d game. 

<b>Features</b>
<ul>
  <li>Hight customizable</li>
  <li>Multiple targets</li>
  <li>Target defined by groups</li>
  <li>Precision can be defined</li>
</ul>

<b>How to install</b>
<p>Can be installed from <i>Assetlib</i></p>

<b>How to use</b>
<ul>
  <li>Add Node2d to character </li>
  <li>plug the related script (assets/luisboch/field-of-view/2d/field_of_view.gd) </li>
  <li>Configure it</li>
  <li>From Character node read "in_danger_area" and "in_warn_area" properties to get the visible nodes</li>
</ul>
<b>Configurations</b>
<ul>
  <li><b>View Detail:</b>Int, Indicate the number of rays created to check the Fov area, greater value will be more precise with hight cost. Check and test to</li>
  <li><b>Field of View:</b> In degrees, configure the view angle</li>
  <li><b>Radius Warn:</b> Float, radius to configure warn area</li>
  <li><b>Radius Danger:</b> Float, radius to configure danger area, must be lower than <i>Radius Warn</i></li>
  <li><b>Show circle:</b> Bool, use to debug the Warn area</li>
   <li><b>Show Fov:</b> Bool, use to view the rays created</li>
  <li><b>Show Target line:</b> Bool, draw line to target?</li>
  <li><b>Circle Color:</b> Color, when <i>Show circle</i> is true, this define the color used to draw</li>
  <li><b>Fov Color:</b> Color, when <i>Show Fov</i> is true, this define the color used to draw rays</li>
  <li><b>Fov Warn Color:</b> Color, when <i>Show Fov</i> is true, this define the color used to draw ray to target when is "warn" state</li>
  <li><b>Fov Danger Color:</b> Color, when <i>Show Fov</i> is true, this define the color used to draw ray to target when is "danger" state</li>
</ul>
  
<b>Current state</b>
<img src="https://github.com/luisboch/godot_field_of_view/blob/images/assets/luisboch/field-of-view/2d/demo/print/print_1.jpg" />
<br />
<img src="https://github.com/luisboch/godot_field_of_view/blob/images/assets/luisboch/field-of-view/2d/demo/print/print_2.jpg" />
<br />
<img src="https://github.com/luisboch/godot_field_of_view/blob/images/assets/luisboch/field-of-view/2d/demo/print/print_3.jpg" />
<br />
<img src="https://github.com/luisboch/godot_field_of_view/blob/images/assets/luisboch/field-of-view/2d/demo/print/print_4.jpg" />
<br />
<img src="https://github.com/luisboch/godot_field_of_view/blob/images/assets/luisboch/field-of-view/2d/demo/print/print_5.jpg" />
<br />
<img src="https://github.com/luisboch/godot_field_of_view/blob/images/assets/luisboch/field-of-view/2d/demo/print/print_6.jpg" />
<br />
<img src="https://github.com/luisboch/godot_field_of_view/blob/images/assets/luisboch/field-of-view/2d/demo/print/print_7.jpg" />
<br />
<img src="https://github.com/luisboch/godot_field_of_view/blob/images/assets/luisboch/field-of-view/2d/demo/print/print_8.jpg" />

<b>Variables</b>
<br />
<img src="https://github.com/luisboch/godot_field_of_view/blob/images/assets/luisboch/field-of-view/2d/demo/print/variables.jpg" />


