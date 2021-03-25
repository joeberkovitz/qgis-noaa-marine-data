<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.4-Hannover" readOnly="0" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips" labelsEnabled="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 enableorderby="0" tolerance="6" toleranceUnit="MM" forceraster="0" toleranceUnitScale="3x:0,0,0,0,0,0" type="pointCluster">
    <renderer-v2 symbollevels="0" enableorderby="0" forceraster="0" type="singleSymbol">
      <symbols>
        <symbol name="0" clip_to_extent="1" alpha="1" force_rhr="0" type="marker">
          <layer pass="0" locked="0" enabled="1" class="SimpleMarker">
            <prop k="angle" v="0"/>
            <prop k="color" v="255,255,255,255"/>
            <prop k="horizontal_anchor_point" v="1"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="name" v="arrow"/>
            <prop k="offset" v="0,0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="outline_color" v="164,4,23,255"/>
            <prop k="outline_style" v="solid"/>
            <prop k="outline_width" v="0.4"/>
            <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="outline_width_unit" v="MM"/>
            <prop k="scale_method" v="diameter"/>
            <prop k="size" v="7"/>
            <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="size_unit" v="MM"/>
            <prop k="vertical_anchor_point" v="2"/>
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" value="" type="QString"/>
                <Option name="properties" type="Map">
                  <Option name="angle" type="Map">
                    <Option name="active" value="true" type="bool"/>
                    <Option name="expression" value="&quot;meanFloodDir&quot;" type="QString"/>
                    <Option name="type" value="3" type="int"/>
                  </Option>
                  <Option name="enabled" type="Map">
                    <Option name="active" value="false" type="bool"/>
                    <Option name="expression" value="max_flood IS NULL" type="QString"/>
                    <Option name="type" value="3" type="int"/>
                  </Option>
                  <Option name="fillColor" type="Map">
                    <Option name="active" value="false" type="bool"/>
                    <Option name="expression" value="if(max_flood IS NULL,'#FFFFFF','#00FF00')" type="QString"/>
                    <Option name="type" value="3" type="int"/>
                  </Option>
                  <Option name="size" type="Map">
                    <Option name="active" value="false" type="bool"/>
                    <Option name="expression" value="if(max_ebb,-max_ebb*5 + 2,7)" type="QString"/>
                    <Option name="type" value="3" type="int"/>
                  </Option>
                </Option>
                <Option name="type" value="collection" type="QString"/>
              </Option>
            </data_defined_properties>
          </layer>
          <layer pass="0" locked="0" enabled="1" class="SimpleMarker">
            <prop k="angle" v="0"/>
            <prop k="color" v="255,255,255,255"/>
            <prop k="horizontal_anchor_point" v="1"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="name" v="arrow"/>
            <prop k="offset" v="0,0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="outline_color" v="35,164,35,255"/>
            <prop k="outline_style" v="solid"/>
            <prop k="outline_width" v="0.4"/>
            <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="outline_width_unit" v="MM"/>
            <prop k="scale_method" v="diameter"/>
            <prop k="size" v="7"/>
            <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="size_unit" v="MM"/>
            <prop k="vertical_anchor_point" v="2"/>
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" value="" type="QString"/>
                <Option name="properties" type="Map">
                  <Option name="angle" type="Map">
                    <Option name="active" value="true" type="bool"/>
                    <Option name="field" value="meanEbbDir" type="QString"/>
                    <Option name="type" value="2" type="int"/>
                  </Option>
                  <Option name="enabled" type="Map">
                    <Option name="active" value="false" type="bool"/>
                    <Option name="expression" value="max_ebb IS NULL" type="QString"/>
                    <Option name="type" value="3" type="int"/>
                  </Option>
                  <Option name="fillColor" type="Map">
                    <Option name="active" value="false" type="bool"/>
                    <Option name="expression" value="if(max_flood IS NULL,'#FFFFFF','#00FF00')" type="QString"/>
                    <Option name="type" value="3" type="int"/>
                  </Option>
                  <Option name="size" type="Map">
                    <Option name="active" value="false" type="bool"/>
                    <Option name="expression" value="if(max_ebb,-max_ebb*5 + 2,7)" type="QString"/>
                    <Option name="type" value="3" type="int"/>
                  </Option>
                </Option>
                <Option name="type" value="collection" type="QString"/>
              </Option>
            </data_defined_properties>
          </layer>
          <layer pass="0" locked="0" enabled="1" class="SimpleMarker">
            <prop k="angle" v="0"/>
            <prop k="color" v="163,75,245,255"/>
            <prop k="horizontal_anchor_point" v="1"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="name" v="triangle"/>
            <prop k="offset" v="0,0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="outline_color" v="50,87,128,255"/>
            <prop k="outline_style" v="solid"/>
            <prop k="outline_width" v="0.4"/>
            <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="outline_width_unit" v="MM"/>
            <prop k="scale_method" v="diameter"/>
            <prop k="size" v="5"/>
            <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="size_unit" v="MM"/>
            <prop k="vertical_anchor_point" v="1"/>
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" value="" type="QString"/>
                <Option name="properties" type="Map">
                  <Option name="fillColor" type="Map">
                    <Option name="active" value="true" type="bool"/>
                    <Option name="expression" value="if(type='H','#a34bf5',lighter('#a34bf5',150))" type="QString"/>
                    <Option name="type" value="3" type="int"/>
                  </Option>
                </Option>
                <Option name="type" value="collection" type="QString"/>
              </Option>
            </data_defined_properties>
          </layer>
        </symbol>
      </symbols>
      <rotation/>
      <sizescale/>
    </renderer-v2>
    <symbol name="centerSymbol" clip_to_extent="1" alpha="1" force_rhr="0" type="marker">
      <layer pass="0" locked="0" enabled="1" class="SimpleMarker">
        <prop k="angle" v="0"/>
        <prop k="color" v="163,75,245,255"/>
        <prop k="horizontal_anchor_point" v="1"/>
        <prop k="joinstyle" v="bevel"/>
        <prop k="name" v="triangle"/>
        <prop k="offset" v="0,0"/>
        <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="offset_unit" v="MM"/>
        <prop k="outline_color" v="35,35,35,255"/>
        <prop k="outline_style" v="solid"/>
        <prop k="outline_width" v="0"/>
        <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="outline_width_unit" v="MM"/>
        <prop k="scale_method" v="diameter"/>
        <prop k="size" v="6"/>
        <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="size_unit" v="MM"/>
        <prop k="vertical_anchor_point" v="1"/>
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
      </layer>
      <layer pass="0" locked="0" enabled="1" class="FontMarker">
        <prop k="angle" v="0"/>
        <prop k="chr" v="A"/>
        <prop k="color" v="255,255,255,255"/>
        <prop k="font" v=".AppleSystemUIFont"/>
        <prop k="font_style" v=""/>
        <prop k="horizontal_anchor_point" v="1"/>
        <prop k="joinstyle" v="miter"/>
        <prop k="offset" v="0,-0.47999999999999998"/>
        <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="offset_unit" v="MM"/>
        <prop k="outline_color" v="255,255,255,255"/>
        <prop k="outline_width" v="0"/>
        <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="outline_width_unit" v="MM"/>
        <prop k="size" v="3.84"/>
        <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="size_unit" v="MM"/>
        <prop k="vertical_anchor_point" v="1"/>
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties" type="Map">
              <Option name="char" type="Map">
                <Option name="active" value="true" type="bool"/>
                <Option name="expression" value="@cluster_size" type="QString"/>
                <Option name="type" value="3" type="int"/>
              </Option>
            </Option>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </data_defined_properties>
      </layer>
    </symbol>
  </renderer-v2>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <fieldConfiguration>
    <field name="field_1" configurationFlags="None"/>
    <field name="id" configurationFlags="None"/>
    <field name="name" configurationFlags="None"/>
    <field name="bin" configurationFlags="None"/>
    <field name="latitude" configurationFlags="None"/>
    <field name="longitude" configurationFlags="None"/>
    <field name="depth" configurationFlags="None"/>
    <field name="type" configurationFlags="None"/>
    <field name="meanFloodDir" configurationFlags="None"/>
    <field name="meanEbbDir" configurationFlags="None"/>
    <field name="id_bin" configurationFlags="None"/>
  </fieldConfiguration>
  <aliases>
    <alias field="field_1" name="" index="0"/>
    <alias field="id" name="" index="1"/>
    <alias field="name" name="" index="2"/>
    <alias field="bin" name="" index="3"/>
    <alias field="latitude" name="" index="4"/>
    <alias field="longitude" name="" index="5"/>
    <alias field="depth" name="" index="6"/>
    <alias field="type" name="" index="7"/>
    <alias field="meanFloodDir" name="" index="8"/>
    <alias field="meanEbbDir" name="" index="9"/>
    <alias field="id_bin" name="" index="10"/>
  </aliases>
  <defaults>
    <default field="field_1" expression="" applyOnUpdate="0"/>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="name" expression="" applyOnUpdate="0"/>
    <default field="bin" expression="" applyOnUpdate="0"/>
    <default field="latitude" expression="" applyOnUpdate="0"/>
    <default field="longitude" expression="" applyOnUpdate="0"/>
    <default field="depth" expression="" applyOnUpdate="0"/>
    <default field="type" expression="" applyOnUpdate="0"/>
    <default field="meanFloodDir" expression="" applyOnUpdate="0"/>
    <default field="meanEbbDir" expression="" applyOnUpdate="0"/>
    <default field="id_bin" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="field_1" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="id" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="name" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="bin" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="latitude" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="longitude" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="depth" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="type" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="meanFloodDir" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="meanEbbDir" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="id_bin" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="field_1" desc="" exp=""/>
    <constraint field="id" desc="" exp=""/>
    <constraint field="name" desc="" exp=""/>
    <constraint field="bin" desc="" exp=""/>
    <constraint field="latitude" desc="" exp=""/>
    <constraint field="longitude" desc="" exp=""/>
    <constraint field="depth" desc="" exp=""/>
    <constraint field="type" desc="" exp=""/>
    <constraint field="meanFloodDir" desc="" exp=""/>
    <constraint field="meanEbbDir" desc="" exp=""/>
    <constraint field="id_bin" desc="" exp=""/>
  </constraintExpressions>
  <expressionfields>
    <field typeName="string" name="id_bin" subType="0" length="0" expression="id || '_' || bin" comment="" precision="0" type="10"/>
  </expressionfields>
  <previewExpression>"name"</previewExpression>
  <mapTip>&lt;style>
.tip {
	width: 180px;
	font-size: 10px;
}
.name {
	font-weight: bold;
}
.predict {
    padding-top: 5px;
}
&lt;/style>
&lt;div class="tip">
	&lt;span class="name">[% name %]&lt;/span>
	&lt;br/>
	&lt;a href="https://tidesandcurrents.noaa.gov/noaacurrents/Predictions?id=[% id %]_[% bin %]">Station [% id %]&lt;/a>
	&lt;div class="predict">
	&lt;!--
		&lt;table>
		&lt;tbody>
		[%
		with_variable('station_id',id,
			aggregate(@noaa_predictions_layer_id,'concatenate',
				format('&lt;tr class="%2">&lt;td>%1&lt;/td>&lt;td>%2&lt;/td>&lt;td class="velocity">%3&lt;/td>&lt;/tr>',
					   format_date(time,'MM/dd hh:mm'),
					   type,
					   if(type = 'slack','',
						   if(type = 'ebb',-velocity,velocity))),
				id = @station_id
		))
		%]
		&lt;/tbody>
		&lt;/table>
	-->
	&lt;/div>
&lt;/div></mapTip>
  <layerGeometryType>0</layerGeometryType>
</qgis>
