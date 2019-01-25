//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

import QtQuick 2.11
import QtQuick.Controls 2.4
import JASP.Theme 1.0

JASPControl
{
	controlType:			"CheckBox"
	implicitWidth:			control.implicitWidth
	implicitHeight:			control.implicitHeight
	useDefaultBackground:	true
	property alias text:	control.text
    property alias checked: control.checked
    property alias control: control

    signal clicked();
    
	Component.onCompleted: control.clicked.connect(clicked);
    
	CheckBox
	{
		id:			control
		padding:	Theme.jaspControlPadding

		indicator: Rectangle
		{
			id:		checkIndicator
			width:	height
			height:	label.height
			y:		control.padding
			x:		control.padding

			color:			control.checked ? (control.enabled ? Theme.buttonBackgroundColor : Theme.disableControlBackgroundColor) : Theme.controlBackgroundColor
			border.color:	control.enabled ? (control.checked ? Theme.buttonBackgroundColor : Theme.borderColor)					: Theme.disableControlBackgroundColor
			border.width:	1
			radius:			Theme.borderRadius
            
			Text
			{
				visible:					control.checked ? true : false
				color:						Theme.white
				text:						"\u2713"
				font:						Theme.font
				anchors.horizontalCenter:	parent.horizontalCenter
            }
        }
        
		contentItem: Label
		{
			id:					label
			text:				control.text
			font:				Theme.font
			leftPadding:		checkIndicator.width + control.spacing
			verticalAlignment:	Text.AlignVCenter
        }
    }
}
