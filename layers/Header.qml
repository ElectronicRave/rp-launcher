import QtQuick 2.12
import QtGraphicalEffects 1.12


	Rectangle {
		id: header
		property bool chargingStatus: api.device.batteryCharging
		color: headerCSS.background
		width: headerCSS.width
		height: headerCSS.height

	anchors {
		 top: parent.top
	}

	//Battery status

	Rectangle {
		id: header__battery
		property var chargingPercent: api.device.batteryPercent*100
		width: aspectRatio === 43 ? 3 : vpx(65*screenRatio)
		color: "transparent"
		visible: headerHeightCorrection === 0 ? 1 : 0

	anchors {
		right: parent.right; rightMargin: aspectRatio === 43 ? 16 : vpx(-9*screenRatio)
		top: parent.top; topMargin: aspectRatio === 43 ? 3 : vpx(18*screenRatio)
	}

	Image {
		id: header__battery_icon
		height: aspectRatio === 43 ? 16 : vpx(16*screenRatio)
		fillMode: Image.PreserveAspectFit
		source: getBatteryIcon()
		layer.enabled: true
		layer.effect: ColorOverlay { color: theme.title }
		smooth: true

	anchors {
		top: parent.top; topMargin: aspectRatio === 43 ? 3 : vpx(3*screenRatio)
		right: header__battery_level.left; rightMargin: aspectRatio === 43 ? 3 : vpx(4*screenRatio)
	}

	//Battery levels

	property var level

	function getBatteryIcon() {
			if (level >= 0 && level <= 20)
			return "../assets/icons/battery_empty.svg"
		else
			if (level >= 21 && level <= 40)
			return "../assets/icons/battery_quarter.svg"
		else
			if (level >= 41 && level <= 60)
			return "../assets/icons/battery_half.svg"
		else
			if (level >= 61 && level <= 80)
			return "../assets/icons/battery_three_quarters.svg"
		else
			if (level >= 81 && level <= 100)
			return "../assets/icons/battery_full.svg"
		else
			return "../assets/icons/battery_empty.svg"
	}

	function set() {
		header__battery_icon.level = header__battery.chargingPercent
	}

	Timer {
		interval: 10000 //Run the timer every 10 seconds
		repeat: true
		running: true
		triggeredOnStart: true
		onTriggered: header__battery_icon.set()
	}

}

	Text {
		id: header__battery_level
		text: Math.floor(api.device.batteryPercent*100)+"%"
		color: theme.text
		font.pixelSize: screenRatio === 43 ? 18 : vpx(14*screenRatio)
		font.bold: true

		anchors {
			top: parent.top; topMargin: aspectRatio === 43 ? 3 : vpx(2*screenRatio)
		}

}

		Image {
			id: header__battery_icon_charging
			width: aspectRatio === 43 ? 16 : vpx(14*screenRatio)
			height: width
			fillMode: Image.PreserveAspectFit
			source: "../assets/icons/charge.png"
			sourceSize.width: aspectRatio === 43 ? 12 : vpx(5*screenRatio)
			sourceSize.height: aspectRatio === 43 ? 12 : vpx(8*screenRatio)
			smooth: true
			visible: chargingStatus && header__battery_icon.level < 100
                   
		anchors {
			top: parent.top; topMargin: aspectRatio === 43 ? 3 : vpx(4*screenRatio)
			right: header__battery_icon.right; rightMargin: aspectRatio === 43 ? 3 : vpx(12*screenRatio)
		}

}

}

	//Profile icon

	Image {
		id: profileIcon
		width: aspectRatio === 43 ? 3 : vpx(36*screenRatio)
		height: width
		fillMode: Image.PreserveAspectFit
		source: "../assets/icons/profile.png"
		smooth: true

	anchors {
		top: parent.top; topMargin: aspectRatio === 43 ? 3 : vpx(16*screenRatio)
		left: parent.left; leftMargin: aspectRatio === 43 ? 3 : vpx(17*screenRatio)
	}

}

	MouseArea {
		anchors.fill: profileIcon
		onPressAndHold:{
			swapTheme()
	}

}

	//All games

	Text {
		id: all
		text: "All"
		color: theme.accent
		font.bold: true
		font.pixelSize: screenRatio === 43 ? 3 : vpx(18*screenRatio)

	anchors {
		top: parent.top; topMargin: aspectRatio === 43 ? 3 : vpx(26*screenRatio)
		left: parent.left; leftMargin: aspectRatio === 43 ? 3 : vpx(83*screenRatio)
	}

}

	MouseArea {
		anchors.fill: all
		onClicked: {
			currentCollectionIndex = 2
			navigate('Software')
	}

}

	//Favorite games

	Text {
		id: favorite
		text: "Favorite"
		color: theme.text
		font.pixelSize: screenRatio === 43 ? 3 : vpx(18*screenRatio)

	anchors {
		top: parent.top; topMargin: aspectRatio === 43 ? 3 : vpx(26*screenRatio)
		left: parent.left; leftMargin: aspectRatio === 43 ? 3 : vpx(125*screenRatio)
	}   

}

	MouseArea {
		anchors.fill: favorite
		onClicked: {
			currentCollectionIndex = 0
			navigate('Software')
	}

}

	//Played games

	Text {
		id: played
		text: "Played"
		color: theme.text
		font.pixelSize: screenRatio === 43 ? 3 : vpx(18*screenRatio)

	anchors {
		top: parent.top; topMargin: aspectRatio === 43 ? 3 : vpx(26*screenRatio)
		left: parent.left; leftMargin: aspectRatio === 43 ? 3 : vpx(205*screenRatio)
	}    

}

	MouseArea {
		anchors.fill: played
		onClicked: {
			currentCollectionIndex = 1
			navigate('Software')
	}

}

	//Search games

	Text {
		id: search
		text: "Search"
		color: theme.text
		font.pixelSize: screenRatio === 43 ? 3 : vpx(18*screenRatio)
		visible: currentPage === 'Software' ? true : false

	anchors {
		top: parent.top; topMargin: aspectRatio === 43 ? 3 : vpx(26*screenRatio)
		left: parent.left; leftMargin: aspectRatio === 43 ? 3 : vpx(275*screenRatio)
	}    

}

	MouseArea {
		anchors.fill: search
		onClicked: {
			searchValue = ''
			header__search_input.clear()         
			header__search_input.focus = true
			return
	}

} 

}